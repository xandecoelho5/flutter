import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  const AdaptativeButton({required this.label, required this.onPressed, Key? key})
      : super(key: key);

  final String label;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform.name == 'iOS';
    return isIOS
        ? CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            onPressed: onPressed,
            color: Theme.of(context).textTheme.button?.color,
            child: Text(label),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(textStyle: Theme.of(context).textTheme.button),
            child: Text(label),
          );
  }
}
