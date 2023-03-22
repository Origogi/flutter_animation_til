import 'package:flutter/widgets.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/ui/common_widgets/centered_svg_icon.dart';
import 'package:habit_tracker_flutter/ui/task/task_completion_ring.dart';

import '../theming/app_theme.dart';

class AnimatedTask extends StatefulWidget {
  const AnimatedTask({Key? key, required this.iconName}) : super(key: key);

  final String iconName;

  @override
  State<AnimatedTask> createState() => _AnimatedTaskState();
}

class _AnimatedTaskState extends State<AnimatedTask>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _curveAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    _curveAnimation = _animationController.drive(
      CurveTween(curve: Curves.easeInOutCubic),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (_animationController.status != AnimationStatus.completed) {
      _animationController.forward();
    } else {
      _animationController.value = 0.0;
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (_animationController.status != AnimationStatus.completed) {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      child: AnimatedBuilder(
        animation: _curveAnimation,
        builder: (BuildContext context, Widget? child) {
          final themeData = AppTheme.of(context);
          final progress = _curveAnimation.value;
          final hasCompleted = progress == 1.0;

          final iconColor =
              hasCompleted ? themeData.accentNegative : themeData.taskIcon;

          return Stack(
            children: [
              TaskCompletionRing(progress: _curveAnimation.value),
              Positioned.fill(
                  child: CenteredSvgIcon(
                      iconName: widget.iconName, color: iconColor))
            ],
          );
        },
      ),
    );
  }
}
