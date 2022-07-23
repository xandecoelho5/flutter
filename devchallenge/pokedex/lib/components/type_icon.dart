import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/models/i_filterable.dart';

class TypeIcon extends StatelessWidget {
  const TypeIcon({Key? key, required this.type, this.selected = false})
      : super(key: key);

  final IFilterable type;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? type.color : Colors.transparent,
        boxShadow: selected
            ? [
                BoxShadow(
                  color: type.color.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ]
            : [],
      ),
      child: SvgPicture.asset(
        'assets/${type.assetsFolder}/${type.fileName}.svg',
        color: selected ? Colors.white : type.color,
        height: 25,
        width: 25,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
