import 'package:flutter/material.dart';

class AnimatedScale extends ImplicitlyAnimatedWidget {
  final double scale;
  final Widget? child;

  const AnimatedScale({
    super.key,
    this.child,
    required super.duration,
    super.curve = Curves.linear,
    required this.scale,
  });

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _AnimatedScaleState();
}

class _AnimatedScaleState extends AnimatedWidgetBaseState<AnimatedScale> {
  Tween<dynamic>? _scale;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..scale(_scale?.evaluate(animation)),
      alignment: Alignment.bottomCenter,
      child: widget.child,
    );
  }

  @override
  void forEachTween(visitor) {
    _scale = visitor(
      _scale,
      widget.scale,
      (dynamic value) => Tween<double>(begin: value),
    );
  }
}
