import 'package:flutter/material.dart';
import 'package:pokedex/components/type_icon.dart';
import 'package:pokedex/widgets/custom_draggable_scrollable_sheet.dart';

import '../models/filter/filter.dart';
import '../models/i_filterable.dart';
import '../models/pokemon_height.dart';
import '../models/pokemon_type.dart';
import '../models/pokemon_weight.dart';
import '../utils/constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/slider/syncfusion_slider.dart';

class FilterModal extends StatefulWidget {
  FilterModal({
    Key? key,
    required this.filter,
    required this.onApply,
  }) : super(key: key);

  Filter filter;
  final Function(Filter) onApply;

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  late final List<PokemonType> _types = [...widget.filter.types];
  late final List<PokemonType> _weaknesses = [...widget.filter.weaknesses];
  late final List<PokemonHeight> _heights = [...widget.filter.heights];
  late final List<PokemonWeight> _weights = [...widget.filter.weights];
  late RangeValues _numberRange = RangeValues(
    widget.filter.numberRange.start,
    widget.filter.numberRange.end,
  );

  _listRow(
    List<IFilterable> filterableList,
    List<IFilterable> selectedList,
    onSelected,
  ) {
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
            type: filterableList[index],
            selected: selectedList.contains(filterableList[index]),
            onSelected: onSelected,
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 10),
      ),
    );
  }

  _getTypesSorted() {
    var types = [...PokemonType.values];
    types.sort((a, b) => a.name.compareTo(b.name));
    return types;
  }

  _addOrRemoveType(List list, bool selected, IFilterable type) {
    if (selected) {
      list.add(type);
    } else {
      list.remove(type);
    }
  }

  _typesRow() => _listRow(_getTypesSorted(), _types, (selected, type) {
        _addOrRemoveType(_types, selected, type);
      });

  _weaknessesRow() =>
      _listRow(_getTypesSorted(), _weaknesses, (selected, type) {
        _addOrRemoveType(_weaknesses, selected, type);
      });

  _heightsRow() => _listRow(PokemonHeight.values, _heights, (selected, type) {
        _addOrRemoveType(_heights, selected, type);
      });

  _weightsRow() => _listRow(PokemonWeight.values, _weights, (selected, type) {
        _addOrRemoveType(_weights, selected, type);
      });

  _apply() {
    widget.filter = widget.filter.copyWith(
      types: _types,
      weaknesses: _weaknesses,
      heights: _heights,
      weights: _weights,
      numberRange: _numberRange,
    );
    widget.onApply(widget.filter);
    Navigator.pop(context);
  }

  _reset() {
    widget.filter = widget.filter.copyWith(
      types: [],
      weaknesses: [],
      heights: [],
      weights: [],
      numberRange: const RangeValues(1, 898),
    );
    widget.onApply(widget.filter);
    Navigator.pop(context);
  }

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
          _weaknessesRow(),
          _paddedWidget(child: const Text('Heights', style: titleStile)),
          _heightsRow(),
          _paddedWidget(child: const Text('Weights', style: titleStile)),
          _weightsRow(),
          _paddedWidget(child: const Text('Number Range', style: titleStile)),
          kSpacerMedium,
          _paddedWidget(
            child: SyncfusionSlider(
              rangeValues: _numberRange,
              onChangeEnd: (values) => setState(
                () => _numberRange = RangeValues(values.start, values.end),
              ),
            ),
          ),
          kSpacerLarge,
          _paddedWidget(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomButton(
                    'Reset',
                    onPressed: _reset,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    'Apply',
                    selected: true,
                    onPressed: _apply,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
