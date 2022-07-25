import 'package:flutter/material.dart';
import 'package:pokedex/components/generation_card.dart';

import '../utils/constants.dart';
import '../widgets/custom_draggable_scrollable_sheet.dart';

const generations = [
  ['001', '004', '007'],
  ['152', '155', '158'],
  ['252', '255', '258'],
  ['387', '390', '393'],
  ['495', '498', '501'],
  ['650', '653', '656'],
  ['722', '725', '728'],
  ['810', '813', '816'],
];

class GenerationsModal extends StatelessWidget {
  const GenerationsModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDraggableScrollableSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Generations',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          kSpacerSmall,
          const Text(
            'Use search for generations to explore your Pokémon!',
            style: TextStyle(color: kTextGrey, fontSize: 16),
          ),
          kSpacerLarge,
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: List.generate(generations.length, (index) {
              return GenerationCard(
                generation: index + 1,
                numbers: generations[index],
                selected: index % 2 == 0,
              );
            }),
          ),
        ],
      ),
    );
  }
}
