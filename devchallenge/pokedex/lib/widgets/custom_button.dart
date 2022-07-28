import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomButton extends StatefulWidget {
  CustomButton(
    this.text, {
    Key? key,
    this.selected = false,
    this.onSelected,
    this.onPressed,
  }) : super(key: key);

  final String text;
  bool selected;
  final Function(bool)? onSelected;
  final Function()? onPressed;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
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
      height: 60,
      decoration: widget.selected ? decoration : null,
      child: ElevatedButton(
        onPressed: () {
          if (widget.onPressed != null) {
            widget.onPressed!();
          }
          if (widget.onSelected != null) {
            setState(() => widget.selected = !widget.selected);
            widget.onSelected!(widget.selected);
          }
        },
        style: ElevatedButton.styleFrom(
          primary: widget.selected ? kTypePsychic : kBackgroundDefaultInput,
          onPrimary: widget.selected ? kTextWhite : kTextGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20.5),
          elevation: 0,
        ),
        child: Text(widget.text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
