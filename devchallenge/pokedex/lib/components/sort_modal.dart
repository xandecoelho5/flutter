import 'package:flutter/material.dart';
import 'package:pokedex/utils/constants.dart';
import 'package:pokedex/widgets/custom_button.dart';

import '../widgets/custom_draggable_scrollable_sheet.dart';

class SortModal extends StatelessWidget {
  const SortModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDraggableScrollableSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Text(
            'Sort',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          kSpacerSmall,
          Text(
            'Sort Pokémon alphabetically or by name or by National Pokédex number!',
            style: TextStyle(color: kTextGrey, fontSize: 16),
          ),
          kSpacerLarge,
          CustomButton('Smallest number first', selected: true),
          kSpacerMedium,
          CustomButton('Highest number first'),
          kSpacerMedium,
          CustomButton('A-Z'),
          kSpacerMedium,
          CustomButton('Z-A'),
        ],
      ),
    );
  }
}
