import 'package:flutter/material.dart';

import '../../../../utils/consts.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text(
          "Activity",
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
