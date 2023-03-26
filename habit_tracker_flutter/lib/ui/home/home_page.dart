import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/persistence/hive_data_store.dart';
import 'package:habit_tracker_flutter/ui/home/tasks_grid_page.dart';
import 'package:hive_flutter/adapters.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final source = ref.watch(dataStoreProvider);

    return ValueListenableBuilder(
        valueListenable: source.tasksListenable(),
        builder: (_, Box<Task> box, __) {
          return TasksGridPage(tasks: box.values.toList());
        });
  }
}
