import 'package:flutter/material.dart';
import 'package:pokedex/components/type_icon.dart';
import 'package:pokedex/widgets/modal_container.dart';

import '../models/i_filterable.dart';
import '../models/pokemon_height.dart';
import '../models/pokemon_type.dart';
import '../models/pokemon_weight.dart';
import '../utils/constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/slider/syncfusion_slider.dart';

class FilterModal extends StatelessWidget {
  const FilterModal({Key? key}) : super(key: key);

  _listRow(List<IFilterable> filterableList) {
    return Expanded(
      child: ListView.separated(
        itemCount: filterableList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return TypeIcon(
              type: filterableList[index], selected: index % 2 == 0);
        },
        separatorBuilder: (_, __) => const SizedBox(width: 10),
      ),
    );
  }

  _typesRow() {
    var types = [...PokemonType.values];
    types.sort((a, b) => a.name.compareTo(b.name));
    return _listRow(types);
  }

  _heightsRow() => _listRow(PokemonHeight.values);

  _weightsRow() => _listRow(PokemonWeight.values);

  _content() {
    const titleStile = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Filters',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        kSpacerSmall,
        const Text(
          'Use advanced search to explore Pokémon by type, weakness, height and more!',
          style: TextStyle(color: kTextGrey, fontSize: 16),
        ),
        kSpacerLarge,
        const Text('Types', style: titleStile),
        kSpacerSmall,
        _typesRow(),
        kSpacerLarge,
        const Text('Weaknesses', style: titleStile),
        kSpacerSmall,
        _typesRow(),
        kSpacerLarge,
        const Text('Heights', style: titleStile),
        kSpacerSmall,
        _heightsRow(),
        kSpacerLarge,
        const Text('Weights', style: titleStile),
        kSpacerSmall,
        _weightsRow(),
        kSpacerLarge,
        const Text('Number Range', style: titleStile),
        kSpacerMedium,
        const SyncfusionSlider(),
        kSpacerLarge,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Expanded(child: CustomButton('Reset')),
            SizedBox(width: 16),
            Expanded(child: CustomButton('Apply', selected: true)),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: DraggableScrollableSheet(
        // initialChildSize: 0.5,
        // minChildSize: 0.15,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: ModalContainer(
              child: _content(),
            ),
          );
        },
      ),
    );
  }
}
