import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/components/generations_modal.dart';
import 'package:pokedex/screens/home/pokemon_list.dart';

import '../../components/filter_modal.dart';
import '../../components/sort_modal.dart';
import '../../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double _deviceWidth;
  late double _deviceHeight;
  late final FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _requestFocus() {
    setState(() => FocusScope.of(context).requestFocus(_searchFocusNode));
  }

  void _showModal(modal) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        minHeight: _deviceHeight * 0.1,
        maxHeight: _deviceHeight * 0.48,
      ),
      isScrollControlled: true,
      builder: (context) => modal,
    );
  }

  _appBar() {
    _svgIcon(assetName, onTap) {
      return InkWell(
        onTap: onTap,
        child: SvgPicture.asset(
          'assets/icons/$assetName',
          color: Colors.black,
        ),
      );
    }

    return AppBar(
      actions: [
        _svgIcon('generation.svg', () => _showModal(const GenerationsModal())),
        SizedBox(width: _deviceWidth * 0.05),
        _svgIcon('sort.svg', () => _showModal(const SortModal())),
        SizedBox(width: _deviceWidth * 0.05),
        _svgIcon('filter.svg', () => _showModal(const FilterModal())),
        SizedBox(width: _deviceWidth * 0.1),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: _deviceHeight * 0.1,
    );
  }

  _searchBar() {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.transparent, width: 0),
    );

    return TextField(
      onTap: _requestFocus,
      focusNode: _searchFocusNode,
      decoration: InputDecoration(
        focusedBorder: border,
        enabledBorder: border,
        fillColor: _searchFocusNode.hasFocus
            ? kBackgroundPressedInput
            : kBackgroundDefaultInput,
        hoverColor: kBackgroundPressedInput,
        filled: true,
        hintText: 'What Pokémon are you looking for?',
        hintStyle: const TextStyle(color: kTextGrey),
        prefixIconConstraints: BoxConstraints(minWidth: _deviceWidth * 0.11),
        prefixIcon: const Icon(
          Icons.search,
          color: kTextGrey,
          size: 20,
        ),
      ),
      style: const TextStyle(color: kTextBlack),
    );
  }

  _pokeball() {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return ui.Gradient.linear(
          bounds.center,
          bounds.bottomCenter,
          kGradientPokeball,
        );
      },
      child: SvgPicture.asset(
        'assets/patterns/pokeball.svg',
        height: _deviceWidth,
        width: _deviceWidth,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: Stack(
        children: [
          Positioned(
            top: _deviceWidth * -0.5,
            child: _pokeball(),
          ),
          Column(
            children: [
              kSpacerSmall,
              Padding(
                padding: EdgeInsets.only(
                  right: kLargePadding,
                  left: kLargePadding,
                  top: _deviceHeight * 0.1,
                  bottom: _deviceHeight * 0.015,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pokédex',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: _deviceHeight * 0.01),
                    Text(
                      'Search for Pokémon by name or using the National Pokédex number.',
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 16),
                    ),
                    SizedBox(height: _deviceHeight * 0.038),
                    _searchBar(),
                  ],
                ),
              ),
              const PokemonListComponent(),
            ],
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
    );
  }
}
