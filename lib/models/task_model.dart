import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
part 'task_model.g.dart';

final formatter = DateFormat.yMd();
final Map<EisenhowerCategory, String> categoryMap = {
  EisenhowerCategory.notUrgentImportant: "NOT urget important",
  EisenhowerCategory.notUrgentNotImportant: "NOT urget NOT important",
  EisenhowerCategory.urgentImportant: "Urget important",
  EisenhowerCategory.urgentNotImportant: "Urget NOT important",
};
final Map<EisenhowerCategory, Color> categoryColors = {
  EisenhowerCategory.notUrgentImportant: const Color(0xFFFFD070),
  EisenhowerCategory.notUrgentNotImportant: const Color(0xFFC7C5D4),
  EisenhowerCategory.urgentImportant: const Color(0xFFFF8080),
  EisenhowerCategory.urgentNotImportant: const Color(0xFF80FFA3),
};

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

  static const _uuid = Uuid();

  TaskModel({
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.category,
    String? id,
  }) : id = id ?? _uuid.v4();

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    TaskStatus? status,
    EisenhowerCategory? category,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      status: status ?? this.status,
      category: category ?? this.category,
    );
  }

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
