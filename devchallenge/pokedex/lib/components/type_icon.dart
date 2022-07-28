import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/models/i_filterable.dart';

class TypeIcon extends StatefulWidget {
  TypeIcon({
    Key? key,
    required this.type,
    this.selected = false,
    required this.onSelected,
  }) : super(key: key);

  final IFilterable type;
  bool selected;
  final Function(bool, IFilterable) onSelected;

  @override
  State<TypeIcon> createState() => _TypeIconState();
}

class _TypeIconState extends State<TypeIcon> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() => widget.selected = !widget.selected);
        widget.onSelected(widget.selected, widget.type);
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.selected ? widget.type.color : Colors.transparent,
          boxShadow: widget.selected
              ? [
                  BoxShadow(
                    color: widget.type.color.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [],
        ),
        child: SvgPicture.asset(
          'assets/${widget.type.assetsFolder}/${widget.type.fileName}.svg',
          color: widget.selected ? Colors.white : widget.type.color,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
