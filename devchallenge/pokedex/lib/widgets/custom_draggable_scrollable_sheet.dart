import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomDraggableScrollableSheet extends StatefulWidget {
  const CustomDraggableScrollableSheet({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 36, horizontal: 36),
  }) : super(key: key);

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  State<CustomDraggableScrollableSheet> createState() =>
      _CustomDraggableScrollableSheetState();
}

class _CustomDraggableScrollableSheetState
    extends State<CustomDraggableScrollableSheet> {
  final _controller = DraggableScrollableController();
  double _draggedPixels = 0;

  @override
  initState() {
    super.initState();
    _controller.addListener(() {
      setState(() => _draggedPixels = _controller.pixels);
    });
  }

  _bar() {
    return Container(
      height: 6,
      width: 80,
      decoration: const BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
    );
  }

  _draggableScrollableSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      minChildSize: 0.15,
      controller: _controller,
      builder: (ctx, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            child: Container(
              padding: widget.padding,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                color: kBackgroundColor,
              ),
              child: widget.child,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: _draggableScrollableSheet(),
          ),
          Positioned(
            child: _bar(),
            top: _draggedPixels == 0 ? 0 : null,
            bottom: _draggedPixels == 0 ? null : _draggedPixels + 5,
          ),
        ],
      ),
    );
  }
}
