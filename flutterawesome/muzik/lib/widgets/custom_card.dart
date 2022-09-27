import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.imageUrl,
    this.width,
    this.radius,
    this.fit,
  }) : super(key: key);

  final String imageUrl;
  final double? width;
  final double? radius;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 140,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: fit ?? BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(radius ?? 30),
      ),
    );
  }
}
