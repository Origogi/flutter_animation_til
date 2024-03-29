import 'package:flutter/widgets.dart';
import 'package:habit_tracker_flutter/ui/animations/animation_controller_state.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/sliding_panel.dart';

class SlidingPanelAnimator extends StatefulWidget {
  const SlidingPanelAnimator(
      {Key? key, required this.direction, required this.child})
      : super(key: key);

  final SlideDirection direction;
  final Widget child;

  @override
  State<SlidingPanelAnimator> createState() =>
      SlidingPanelAnimatorState(Duration(milliseconds: 200));
}

class SlidingPanelAnimatorState
    extends AnimationControllerState<SlidingPanelAnimator> {
  SlidingPanelAnimatorState(Duration animationDuration)
      : super(animationDuration);

  late final _curveAnimation = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(CurvedAnimation(
      parent: animationController, curve: Curves.easeInOutCubic));

  void slideIn() {
    animationController.forward();
  }

  void slideOut() {
    animationController.reverse();
  }

  double _getOffSetX(double screenWidth, double animationValue) {
    final startOffset = widget.direction == SlideDirection.rightToLeft
        ? screenWidth - SlidingPanel.leftPanelFixedWidth
        : -SlidingPanel.leftPanelFixedWidth;
    return startOffset * (1.0 - animationValue);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _curveAnimation,
      builder: (BuildContext context, Widget? child) {
        final animationValue = _curveAnimation.value;

        if (animationValue == 0) {
          return Container();
        }

        final offsetX =
            _getOffSetX(MediaQuery.of(context).size.width, animationValue);

        return Transform.translate(
          offset: Offset(offsetX, 0),
          child: child,
        );
      },
      child: SlidingPanel(
        child: widget.child,
        direction: widget.direction,
      ),
    );
  }
}
