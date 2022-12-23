import 'package:flutter/material.dart';

class LikeAnimationWidget extends StatefulWidget {
  const LikeAnimationWidget({
    Key? key,
    required this.child,
    required this.duration,
    required this.isLikeAnimating,
    this.onLikeFinish,
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final bool isLikeAnimating;
  final VoidCallback? onLikeFinish;

  @override
  State<LikeAnimationWidget> createState() => _LikeAnimationWidgetState();
}

class _LikeAnimationWidgetState extends State<LikeAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _scale = Tween<double>(begin: 1, end: 1.2).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant LikeAnimationWidget oldWidget) {
    if (widget.isLikeAnimating != oldWidget.isLikeAnimating) {
      _beginLikeAnimation();
    }
    super.didUpdateWidget(oldWidget);
  }

  _beginLikeAnimation() async {
    if (widget.isLikeAnimating) {
      await _controller.forward();
      await _controller.reverse();
      await Future.delayed(const Duration(milliseconds: 200));
      widget.onLikeFinish?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _scale, child: widget.child);
  }
}
