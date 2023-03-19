import 'package:flutter/widgets.dart';

class TaskCompletionRing extends StatelessWidget {
  const TaskCompletionRing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        painter: RingPainter(),
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('$size');
    final paint = Paint()
      ..color = const Color(0xffF5F5F5)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2);
    canvas.drawArc(rect, 0, 2 * 3.14, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
