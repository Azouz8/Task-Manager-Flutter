import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager/models/task_model.dart';

class TaskRepository {
  final Box<TaskModel> box = Hive.box<TaskModel>('tasks');

  Future<void> addTask(TaskModel task) async {
    await box.put(task.id, task);
  }

  Future<void> deleteTask(String id) async {
    await box.delete(id);
  }

  Future<void> updateTask(TaskModel task) async {
    await box.put(task.id, task);
  }

  List<TaskModel> getTasks() {
    return box.values.toList();
  }

  Listenable listenable() => box.listenable();
}
