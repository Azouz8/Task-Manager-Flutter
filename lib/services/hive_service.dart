import 'package:hive/hive.dart';
import 'package:task_manager/models/task_model.dart';

class HiveService {
  static Box<TaskModel> get taskBox => Hive.box<TaskModel>('tasks');
}
