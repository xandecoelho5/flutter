import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(this.text, {Key? key, this.selected = false})
      : super(key: key);

  final String text;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: kTypePsychic.withOpacity(0.3),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    );

    return Container(
      decoration: selected ? decoration : null,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: selected ? kTypePsychic : const Color(0xFFF2F2F2),
          onPrimary: selected ? kTextWhite : kTextGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          elevation: 0,
        ),
        child: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
