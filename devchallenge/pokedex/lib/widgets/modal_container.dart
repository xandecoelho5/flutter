import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ModalContainer extends StatelessWidget {
  const ModalContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 36),
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color: kBackgroundColor,
      ),
      child: child,
    );
  }
}
