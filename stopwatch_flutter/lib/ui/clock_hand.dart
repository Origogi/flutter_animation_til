import 'package:flutter/widgets.dart';

class ClockHand extends StatelessWidget {
  const ClockHand(
      {Key? key,
      required this.rotationZAngle,
      required this.handThickness,
      required this.handLength,
      required this.color})
      : super(key: key);

  final double rotationZAngle;
  final double handThickness;
  final double handLength;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.topLeft,
      transform: Matrix4.identity()
        ..translate(-handThickness / 2, 0,0)
        ..rotateZ(rotationZAngle),
      child: Container(
        height: handLength,
        width: handThickness,
        color: color,
      ),
    );
  }
}
