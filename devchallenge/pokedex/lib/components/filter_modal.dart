import 'package:flutter/material.dart';
import 'package:pokedex/components/type_icon.dart';
import 'package:pokedex/widgets/custom_draggable_scrollable_sheet.dart';

import '../models/i_filterable.dart';
import '../models/pokemon_height.dart';
import '../models/pokemon_type.dart';
import '../models/pokemon_weight.dart';
import '../utils/constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/slider/syncfusion_slider.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({Key? key}) : super(key: key);

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  _listRow(List<IFilterable> filterableList) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.135,
      // height: 100,
      width: double.infinity,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 36),
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

  _paddedWidget({required Widget child}) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    const titleStile = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

    return CustomDraggableScrollableSheet(
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _paddedWidget(
            child: const Text(
              'Filters',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
          ),
          kSpacerSmall,
          _paddedWidget(
            child: const Text(
              'Use advanced search to explore Pokémon by type, weakness, height and more!',
              style: TextStyle(color: kTextGrey, fontSize: 16),
            ),
          ),
          kSpacerLarge,
          _paddedWidget(child: const Text('Types', style: titleStile)),
          _typesRow(),
          _paddedWidget(child: const Text('Weaknesses', style: titleStile)),
          _typesRow(),
          _paddedWidget(child: const Text('Heights', style: titleStile)),
          _heightsRow(),
          _paddedWidget(child: const Text('Weights', style: titleStile)),
          _weightsRow(),
          _paddedWidget(child: const Text('Number Range', style: titleStile)),
          kSpacerMedium,
          _paddedWidget(child: const SyncfusionSlider()),
          kSpacerLarge,
          _paddedWidget(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Expanded(child: CustomButton('Reset')),
                SizedBox(width: 16),
                Expanded(child: CustomButton('Apply', selected: true)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
