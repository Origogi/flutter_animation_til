import 'package:flutter/foundation.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/models/task_state.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:riverpod/riverpod.dart';

class HiveDataStore {
  static const frontTasksBoxName = 'frontTasks';
  static const backTasksBoxName = 'backTasks';

  static const tasksStateBoxName = 'tasksState';

  static String taskStateKey(String taskId) => 'tasksState/$taskId';

  Future<void> init() async {
    await Hive.initFlutter();

    // Register adapters
    Hive.registerAdapter<Task>(TaskAdapter());
    Hive.registerAdapter<TaskState>(TaskStateAdapter());

    // open boxes
    await Hive.openBox<Task>(frontTasksBoxName);
    await Hive.openBox<Task>(backTasksBoxName);

    await Hive.openBox<TaskState>(tasksStateBoxName);
  }

  Future<void> createDemoTasks({
    required List<Task> frontTasks,
    required List<Task> backTasks,
    bool force = false,
  }) async {
    final frontBox = Hive.box<Task>(frontTasksBoxName);
    if (frontBox.isEmpty || force == true) {
      await frontBox.clear();
      await frontBox.addAll(frontTasks);
    } else {
      print('Box already has ${frontBox.length} items');
    }
    final backBox = Hive.box<Task>(backTasksBoxName);
    if (backBox.isEmpty || force == true) {
      await backBox.clear();
      await backBox.addAll(backTasks);
    } else {
      print('Box already has ${backBox.length} items');
    }
  }

  ValueListenable<Box<Task>> frontTasksListenable() {
    return Hive.box<Task>(frontTasksBoxName).listenable();
  }

  ValueListenable<Box<Task>> backTasksListenable() {
    return Hive.box<Task>(backTasksBoxName).listenable();
  }

  Future<void> setTaskState(
      {required Task task, required bool completed}) async {
    final box = Hive.box<TaskState>(tasksStateBoxName);
    final taskState = TaskState(taskId: task.id, completed: completed);
    await box.put(taskStateKey(task.id), taskState);
  }

  ValueListenable<Box<TaskState>> taskStateListenable({required Task task}) {
    final box = Hive.box<TaskState>(tasksStateBoxName);
    final key = taskStateKey(task.id);
    return box.listenable(keys: <String>[key]);
  }

  TaskState taskState(Box<TaskState> box, {required Task task}) {
    final key = taskStateKey(task.id);
    return box.get(key) ?? TaskState(taskId: task.id, completed: false);
  }
}

final dataStoreProvider = Provider<HiveDataStore>((ref) {
  throw UnimplementedError();
});
