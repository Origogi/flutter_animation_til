import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class TaskCompletionRing extends StatelessWidget {
  const TaskCompletionRing({Key? key, required this.progress})
      : super(key: key);

  final double progress;

  @override
  Widget build(BuildContext context) {
    final themeDate = AppTheme.of(context);
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        painter: RingPainter(
            progress: progress,
            taskNotCompletedColor: themeDate.taskRing,
            taskCompletedColor: themeDate.accent),
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  final double progress;
  final Color taskNotCompletedColor;
  final Color taskCompletedColor;

  RingPainter(
      {required this.progress,
      required this.taskNotCompletedColor,
      required this.taskCompletedColor});

  @override
  void paint(Canvas canvas, Size size) {
    final notCompleted = progress < 1.0;
    final strokeWidth = size.width / 15.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius =
        notCompleted ? (size.width - strokeWidth) / 2 : size.width / 2;

    if (notCompleted) {
      final backgroundPaint = Paint()
        ..isAntiAlias = true
        ..color = taskNotCompletedColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;
      canvas.drawCircle(center, radius, backgroundPaint);
    }

    final foregroundPaint = Paint()
      ..isAntiAlias = true
      ..color = taskCompletedColor
      ..style = notCompleted ? PaintingStyle.stroke : PaintingStyle.fill
      ..strokeWidth = strokeWidth;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        2 * pi * progress, false, foregroundPaint);
  }

  @override
  bool shouldRepaint(covariant RingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
