import 'package:flutter/material.dart';

class AnimatedGradient extends ImplicitlyAnimatedWidget {
  final Color backgroundColor;
  final Widget? child;

  const AnimatedGradient({
    super.key,
    this.child,
    required super.duration,
    super.curve = Curves.linear,
    required this.backgroundColor,
  });

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _AnimatedGradientState();
}

class _AnimatedGradientState extends AnimatedWidgetBaseState<AnimatedGradient> {
  Tween<dynamic>? _colorTween;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: const [.4, .42, 1],
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
          colors: [
            Colors.white.withOpacity(.5),
            _colorTween?.evaluate(animation),
            darken(_colorTween?.evaluate(animation), .2),
          ],
        ),
      ),
      child: widget.child,
    );
  }

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  @override
  void forEachTween(visitor) {
    _colorTween = visitor(
      _colorTween,
      widget.backgroundColor,
      (dynamic value) => ColorTween(begin: value),
    );
  }
}
