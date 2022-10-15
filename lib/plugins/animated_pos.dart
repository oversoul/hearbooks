import 'package:flutter/material.dart';

class AnimatedPos extends ImplicitlyAnimatedWidget {
  final double position;
  final Widget? child;

  const AnimatedPos({
    super.key,
    this.child,
    required super.duration,
    super.curve = Curves.linear,
    required this.position,
  });

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _AnimatedPosState();
}

class _AnimatedPosState extends AnimatedWidgetBaseState<AnimatedPos> {
  Tween<dynamic>? _position;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(_position?.evaluate(animation)),
      alignment: Alignment.centerLeft,
      child: widget.child,
    );
  }

  @override
  void forEachTween(visitor) {
    _position = visitor(
      _position,
      widget.position,
      (dynamic value) => Tween<double>(begin: value),
    );
  }
}
