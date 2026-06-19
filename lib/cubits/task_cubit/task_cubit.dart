import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubits/task_cubit/tast_states.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/repos/task_repo.dart';

class TaskCubit extends Cubit<TaskStates> {
  final TaskRepository repository;

  TaskCubit(this.repository) : super(TaskStates([])) {
    _startListening();
  }

  void _startListening() {
    repository.listenable().addListener(() {
      final tasks = repository.getTasks();
      emit(TaskStates(tasks));
    });
  }

  List<TaskModel> getTasksByStatus(TaskStatus status) {
    return state.allTasks.where((task) => task.status == status).toList();
  }

  List<TaskModel> getTasksByCategory(EisenhowerCategory category) {
    return state.allTasks.where((task) => task.category == category).toList();
  }

  Map<EisenhowerCategory, List<TaskModel>> get tasksByCategory {
    final map = <EisenhowerCategory, List<TaskModel>>{};

    for (var category in EisenhowerCategory.values) {
      map[category] = state.allTasks
          .where((task) => task.category == category)
          .toList();
    }
    return map;
  }

  Map<TaskStatus, List<TaskModel>> get tasksByStatus {
    final map = <TaskStatus, List<TaskModel>>{};

    for (var status in TaskStatus.values) {
      map[status] = state.allTasks
          .where((task) => task.status == status)
          .toList();
    }

    return map;
  }

  Future<void> addTask(TaskModel task) async {
    await repository.addTask(task);
  }

  Future<void> deleteTask(String id) async {
    await repository.deleteTask(id);
  }

  Future<void> updateTask(TaskModel task) async {
    await repository.updateTask(task);
  }
}
