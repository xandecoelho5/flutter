import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/pokemon_types.dart';

class Badge extends StatelessWidget {
  const Badge(
    this.type, {
    Key? key,
    this.onlyIcon = false,
    this.margin,
  }) : super(key: key);

  final PokemonTypes type;
  final bool onlyIcon;
  final double? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: onlyIcon ? 25 : null,
      padding: const EdgeInsets.all(5),
      margin: EdgeInsets.only(right: margin ?? 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: type.foregroundColor,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/types/${type.name}.svg',
            color: Colors.white,
            height: 15,
            width: 15,
          ),
          if (!onlyIcon) const SizedBox(width: 5),
          if (!onlyIcon)
            Text(
              type.type,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
        ],
      ),
    );
  }
}
