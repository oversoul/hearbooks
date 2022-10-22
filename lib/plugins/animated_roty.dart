import 'package:flutter/material.dart';

class AnimatedRotY extends ImplicitlyAnimatedWidget {
  final double position;
  final Widget? child;
  final Widget? backWidget;
  final double? threshold;

  const AnimatedRotY({
    super.key,
    this.child,
    this.backWidget,
    this.threshold,
    required super.duration,
    super.curve = Curves.linear,
    required this.position,
  });

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _AnimatedRotYState();
}

class _AnimatedRotYState extends AnimatedWidgetBaseState<AnimatedRotY> {
  Tween<dynamic>? _position;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(_position?.evaluate(animation)),
      alignment: Alignment.centerLeft,
      child: showWidget(),
    );
  }

  Widget? showWidget() {
    if (widget.backWidget == null || widget.threshold == null) {
      return widget.child;
    }

    return ((_position?.evaluate(animation) > widget.threshold))
        ? widget.backWidget
        : widget.child;
  }

  @override
  void forEachTween(visitor) {
    _position = visitor(
      _position,
      widget.position,
      (value) => Tween<double>(begin: value),
    );
  }
}
