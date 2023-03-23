import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/constants/text_styles.dart';
import 'package:habit_tracker_flutter/models/task_preset.dart';
import 'package:habit_tracker_flutter/ui/task/animated_task.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class TaskWithName extends StatelessWidget {
  const TaskWithName({Key? key, required this.task}) : super(key: key);

  final TaskPreset task;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedTask(iconName: AppAssets.dog),
        SizedBox(height: 8),
        Text(
          task.name.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyles.taskName.copyWith(
            color: AppTheme.of(context).accent,
          ),
        ),
      ],
    );
  }
}
