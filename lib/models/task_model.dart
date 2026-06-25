import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'task_model.g.dart';

const uuid = Uuid();

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final TaskStatus status;

  @HiveField(5)
  final EisenhowerCategory category;

  TaskModel({
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.category,
  }) : id = uuid.v4();

  @override
  String toString() {
    return '''
            id: $id,
            title: $title,
            description: $description,
            date: $date,
            status: $status,
            category: $category
''';
  }
}

@HiveType(typeId: 1)
enum TaskStatus {
  @HiveField(0)
  overdue,

  @HiveField(1)
  todo,

  @HiveField(2)
  doing,

  @HiveField(3)
  done,
}

@HiveType(typeId: 2)
enum EisenhowerCategory {
  @HiveField(0)
  urgentImportant,

  @HiveField(1)
  notUrgentImportant,

  @HiveField(2)
  urgentNotImportant,

  @HiveField(3)
  notUrgentNotImportant,
}
