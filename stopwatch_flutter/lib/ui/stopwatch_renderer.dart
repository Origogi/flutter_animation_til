import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stopwatch_flutter/ui/clock_hand.dart';
import 'package:stopwatch_flutter/ui/elapsed_time_text.dart';

class StopwatchRenderer extends StatelessWidget {
  const StopwatchRenderer(
      {Key? key, required this.elapsed, required this.radius})
      : super(key: key);

  final Duration elapsed;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: Colors.orange,
              width: 4,
            ),
          ),
        ),
        Positioned(
          left: radius,
          top: radius,
          child: ClockHand(
              rotationZAngle: pi + (2 * pi / 60000) * elapsed.inMilliseconds,
              handThickness: 2,
              handLength: radius,
              color: Colors.orange),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: radius * 1.3,
          child: ElapsedTimeText(
            elapsed: elapsed,
          ),
        ),
      ],
    );
  }
}
