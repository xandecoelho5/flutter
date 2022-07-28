import 'package:flutter/material.dart';
import 'package:pokedex/utils/constants.dart';
import 'package:pokedex/widgets/custom_button.dart';

import '../models/sort/sort_options.dart';
import '../widgets/custom_draggable_scrollable_sheet.dart';

class SortModal extends StatefulWidget {
  const SortModal({
    Key? key,
    required this.currentIndex,
    required this.onSortChanged,
  }) : super(key: key);

  final int? currentIndex;
  final Function(int?, SortOptions) onSortChanged;

  @override
  State<SortModal> createState() => _SortModalState();
}

class _SortModalState extends State<SortModal> {
  late int? _value = widget.currentIndex;

  @override
  Widget build(BuildContext context) {
    return CustomDraggableScrollableSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Sort',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          kSpacerSmall,
          const Text(
            'Sort Pokémon alphabetically or by name or by National Pokédex number!',
            style: TextStyle(color: kTextGrey, fontSize: 16),
          ),
          kSpacerLarge,
          SizedBox(
            height: 300,
            child: ListView.separated(
              itemCount: SortOptions.values.length,
              itemBuilder: (context, index) {
                return CustomButton(
                  SortOptions.values[index].label,
                  selected: _value == index,
                  onSelected: (bool selected) {
                    setState(() {
                      if (_value != index) {
                        _value = selected ? index : null;
                        widget.onSortChanged(
                          _value,
                          SortOptions.values[index],
                        );
                      }
                    });
                  },
                );
              },
              separatorBuilder: (_, __) => kSpacerMedium,
            ),
          ),
        ],
      ),
    );
  }
}
