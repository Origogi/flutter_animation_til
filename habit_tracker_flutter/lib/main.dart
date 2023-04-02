import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/constants/app_colors.dart';
import 'package:habit_tracker_flutter/persistence/hive_data_store.dart';
import 'package:habit_tracker_flutter/ui/home/home_page.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

import 'models/task.dart';
import 'models/task_preset.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppAssets.preloadSVGs();

  final dataStore = HiveDataStore();
  await dataStore.init();

  final presets = TaskPreset.allPresets.toList()..shuffle();

  final tasks = presets
      .sublist(0, 12)
      .map((e) => Task.create(name: e.name, iconName: e.iconName))
      .toList();

  await dataStore.createDemoTasks(
      frontTasks: tasks.sublist(0, 6),
      backTasks: tasks.sublist(6),
      force: false);

  runApp(ProviderScope(overrides: [
    dataStoreProvider.overrideWithValue(dataStore),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Helvetica Neue',
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      home: AppTheme(
        data: AppThemeData.defaultWithSwatch(AppColors.red),
        child: HomePage(),
      ),
    );
  }
}
