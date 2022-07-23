import 'package:flutter/material.dart';
import 'package:pokedex/utils/constants.dart';
import 'package:pokedex/widgets/custom_button.dart';

import '../widgets/modal_container.dart';

class SortModal extends StatelessWidget {
  const SortModal({Key? key}) : super(key: key);

  _content() {
    return Column(
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
