import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/persistence/hive_data_store.dart';
import 'package:habit_tracker_flutter/ui/home/tasks_grid_page.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:page_flip_builder/page_flip_builder.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageFlipKey = GlobalKey<PageFlipBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final source = ref.watch(dataStoreProvider);

      return Container(
        color: Colors.black,
        child: PageFlipBuilder(
          key: _pageFlipKey,
          frontBuilder: (_) => ValueListenableBuilder(
              valueListenable: source.frontTasksListenable(),
              builder: (_, Box<Task> box, __) {
                return TasksGridPage(
                  key: ValueKey(1),
                  tasks: box.values.toList(),
                  onFlip: () {
                    _pageFlipKey.currentState?.flip();
                  },
                );
              }),
          backBuilder: (_) => ValueListenableBuilder(
              valueListenable: source.backTasksListenable(),
              builder: (_, Box<Task> box, __) {
                return TasksGridPage(
                  key: ValueKey(2),
                  tasks: box.values.toList(),
                  onFlip: () {
                    _pageFlipKey.currentState?.flip();
                  },
                );
              }),
        ),
      );
    });
  }
}
