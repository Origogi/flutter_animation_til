import 'dart:math';

import 'package:flutter/widgets.dart';

class PageFlipBuilder extends StatefulWidget {
  const PageFlipBuilder(
      {Key? key, required this.frontBuilder, required this.backBuilder})
      : super(key: key);

  final WidgetBuilder frontBuilder;
  final WidgetBuilder backBuilder;

  @override
  PageFlipBuilderState createState() => PageFlipBuilderState();
}

class PageFlipBuilderState extends State<PageFlipBuilder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 500));

  bool _showFrontSide = true;

  void flip() {
    if (_showFrontSide) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController.addStatusListener(_updateStatus);
    _animationController.addListener(() {
      print(_animationController.value);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController.addStatusListener(_updateStatus);
    super.dispose();
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.dismissed) {
      setState(() {
        _showFrontSide = !_showFrontSide;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPageFlipBuilder(
        animation: _animationController,
        showFrontSide: _showFrontSide,
        frontBuilder: widget.frontBuilder,
        backBuilder: widget.backBuilder);
  }
}

class AnimatedPageFlipBuilder extends AnimatedWidget {
  const AnimatedPageFlipBuilder(
      {Key? key,
      required Animation<double> animation,
      required this.showFrontSide,
      required this.frontBuilder,
      required this.backBuilder})
      : super(key: key, listenable: animation);

  final bool showFrontSide;
  final WidgetBuilder frontBuilder;
  final WidgetBuilder backBuilder;

  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    final isAnimationFirst = animation.value < 0.5;
    final child =
        isAnimationFirst ? frontBuilder(context) : backBuilder(context);
    final rotationValue = animation.value * pi;
    final rotationAngle =
        animation.value > 0.5 ? pi - rotationValue : rotationValue;

    var tilt = (animation.value - 0.5).abs() - 0.5;
    tilt *= isAnimationFirst ? -0.003 : 0.003;

    return Transform(
      transform: Matrix4.rotationY(rotationAngle)..setEntry(3, 0, tilt),
      child: child,
      alignment: Alignment.center,
    );
  }
}
