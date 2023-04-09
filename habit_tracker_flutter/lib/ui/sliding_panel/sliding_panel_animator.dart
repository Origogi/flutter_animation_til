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
      _SlidingPanelAnimatorState(Duration(milliseconds: 200));
}

class _SlidingPanelAnimatorState
    extends AnimationControllerState<SlidingPanelAnimator> {
  _SlidingPanelAnimatorState(Duration animationDuration)
      : super(animationDuration);

  void slideIn() {
    animationController.forward();
  }

  void slideOut() {
    animationController.reverse();
  }

  double _getOffSetX(double screenWidth, double animationValue) {
    final startOffset = widget.direction == SlideDirection.leftToRight
        ? screenWidth - SlidingPanel.leftPanelFixedWidth
        : -SlidingPanel.leftPanelFixedWidth;

    return startOffset * (1.0 - animationValue);
    ;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        final animationValue = animationController.value;

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
