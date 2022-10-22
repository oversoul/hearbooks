import 'dart:math' as math;

import 'package:flutter/material.dart';

class PlayerProgress extends CustomPainter {
  final double margin;
  final double progress;
  final Color activeColor;
  final Color inactiveColor;
  final Paint painter;

  PlayerProgress({
    required this.progress,
    this.margin = 0,
    this.activeColor = Colors.black,
    this.inactiveColor = Colors.grey,
  })  : assert(progress >= 0.0 && progress <= 1.0),
        painter = Paint()
          ..strokeWidth = 4
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    painter.color = inactiveColor;

    Offset origin = Offset(margin, -size.height - margin);
    Size end = Size(size.width - (margin * 2), size.height * 2);

    canvas.drawArc(origin & end, math.pi, -math.pi, false, painter);

    painter.color = activeColor;

    canvas.drawArc(origin & end, math.pi, -math.pi * progress, false, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
