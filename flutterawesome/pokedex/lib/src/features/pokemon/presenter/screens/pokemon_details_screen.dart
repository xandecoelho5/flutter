import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/src/core/utils/colors.dart';
import 'package:pokedex/src/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokedex/src/features/pokemon/domain/value_objects/base_stats.dart';
import 'package:pokedex/src/features/pokemon/presenter/components/favourite_button.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/utils.dart';
import '../blocs/favourite_bloc.dart';

class PokemonDetailsScreen extends StatefulWidget {
  const PokemonDetailsScreen({Key? key, required this.pokemon})
      : super(key: key);

  final PokemonEntity pokemon;

  @override
  State<PokemonDetailsScreen> createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends State<PokemonDetailsScreen> {
  _pokemonContainer() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          color: kGreenColor,
          padding: const EdgeInsets.symmetric(
            horizontal: kPokemonScreenHorPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Utils.capitalize(widget.pokemon.name),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: kTextColor,
                    ),
                  ),
                  Text(
                    widget.pokemon.types.join(','),
                    style: const TextStyle(fontSize: 16, color: kTextColor),
                  ),
                ],
              ),
              Text(
                '#${widget.pokemon.id.toString().padLeft(3, '0')}',
                style: const TextStyle(fontSize: 16, color: kTextColor),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -16,
          right: -52,
          child: Image.asset(
            'assets/icons/pokemon_bg.png',
            width: 176,
            height: 176,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Image.network(
            widget.pokemon.imageUrl,
            width: 136,
            height: 125,
          ),
        ),
      ],
    );
  }

  _bmiContainer() {
    Column columnInfo(String label, double value) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: kUnselectedTabColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value.toStringAsFixed(1),
            style: const TextStyle(
              fontSize: 14,
              color: kTextColor,
            ),
          ),
        ],
      );
    }

    return Container(
      width: double.infinity,
      height: 78,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: kPokemonScreenHorPadding,
        vertical: 17,
      ),
      child: Row(
        children: [
          columnInfo('Height', 69),
          const SizedBox(width: 48),
          columnInfo('Weight', 7),
          const SizedBox(width: 48),
          columnInfo('BMI', 14.7),
        ],
      ),
    );
  }

  _baseStatsContainer(context) {
    baseStatsItem(BaseStatsDef baseStats, [Color color = kPinkColor]) {
      statsBar() {
        final width =
            MediaQuery.of(context).size.width - 2 * kPokemonScreenHorPadding;

        return Stack(
          children: [
            Container(
              width: width,
              height: 4,
              decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            Container(
              width: width * baseStats.value / baseStats.maxValue,
              height: 4,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ],
        );
      }

      return Column(
        children: [
          Row(
            children: [
              Text(
                baseStats.name,
                style: const TextStyle(
                  fontSize: 14,
                  color: kUnselectedTabColor,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                baseStats.value.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  color: kTextColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          statsBar(),
        ],
      );
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: kPokemonScreenHorPadding,
            vertical: 12,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: kBackgroundColor,
                width: 1,
              ),
            ),
          ),
          child: const Text(
            'Base Stats',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: kTextColor,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: kPokemonScreenHorPadding,
            vertical: kPokemonScreenHorPadding,
          ),
          child: Column(
            children: [
              baseStatsItem(widget.pokemon.baseStats.hp),
              const SizedBox(height: 24),
              baseStatsItem(widget.pokemon.baseStats.attack),
              const SizedBox(height: 24),
              baseStatsItem(widget.pokemon.baseStats.defense),
              const SizedBox(height: 24),
              baseStatsItem(
                  widget.pokemon.baseStats.specialAttack, kYellowColor),
              const SizedBox(height: 24),
              baseStatsItem(
                  widget.pokemon.baseStats.specialDefense, kYellowColor),
              const SizedBox(height: 24),
              baseStatsItem(widget.pokemon.baseStats.speed),
              const SizedBox(height: 24),
              baseStatsItem(widget.pokemon.baseStats.averagePower),
              const SizedBox(height: 15),
            ],
          ),
        )
      ],
    );
  }

  void onFavouriteButtonPressed() {
    setState(() {
      if (widget.pokemon.isFavourite) {
        widget.pokemon.isFavourite = false;
        Modular.get<FavouriteBloc>().add(RemoveFavouriteEvent(widget.pokemon));
      } else {
        widget.pokemon.isFavourite = true;
        Modular.get<FavouriteBloc>().add(AddFavouriteEvent(widget.pokemon));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreenColor,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kTextColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocListener<FavouriteBloc, FavouriteState>(
          bloc: Modular.get<FavouriteBloc>(),
          listener: (context, state) {
            if (state is ErrorFavouriteState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }

            if (state is SuccessFavouriteState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    widget.pokemon.isFavourite
                        ? 'Added to favourites'
                        : 'Removed from favourites',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              Modular.to.pop();
            }
          },
          child: Column(
            children: [
              _pokemonContainer(),
              _bmiContainer(),
              const SizedBox(height: 8),
              _baseStatsContainer(context),
            ],
          ),
        ),
      ),
      backgroundColor: kBackgroundColor,
      floatingActionButton: FavouriteButton(
        isFavourite: widget.pokemon.isFavourite,
        onPressed: onFavouriteButtonPressed,
      ),
    );
  }
}
