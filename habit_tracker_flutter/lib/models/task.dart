import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  Task({
    required this.id,
    required this.name,
    required this.iconName,
  });

  factory Task.create({
    required String name,
    required String iconName,
  }) {
    return Task(
      id: Uuid().v1(),
      name: name,
      iconName: iconName,
    );
  }

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String iconName;
}
