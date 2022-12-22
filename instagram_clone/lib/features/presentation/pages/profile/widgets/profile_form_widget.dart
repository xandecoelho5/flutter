import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/consts.dart';

class ProfileFormWidget extends StatelessWidget {
  const ProfileFormWidget({
    Key? key,
    this.controller,
    this.title,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title!, style: const TextStyle(color: primaryColor, fontSize: 16)),
        sizeVer(5),
        TextFormField(
          controller: controller,
          style: const TextStyle(color: primaryColor),
          decoration: const InputDecoration(
            labelStyle: TextStyle(color: primaryColor),
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: secondaryColor,
        ),
      ],
    );
  }
}
