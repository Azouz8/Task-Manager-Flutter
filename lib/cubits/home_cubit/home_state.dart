part of 'home_cubit.dart';

@immutable
sealed class HomeState {
  HomeState({required this.selectedControl});
  final Map<TaskStatus, Container> slidingBarControlsMap = {
    TaskStatus.overdue: Container(
      padding: const EdgeInsets.all(10),
      child: const Text(
        "Overdue",
        style: TextStyle(color: Colors.white),
      ),
    ),
    TaskStatus.todo: Container(
      padding: const EdgeInsets.all(10),
      child: const Text(
        "To Do",
        style: TextStyle(color: Colors.white),
      ),
    ),
    TaskStatus.doing: Container(
      padding: const EdgeInsets.all(10),
      child: const Text(
        "Doing",
        style: TextStyle(color: Colors.white),
      ),
    ),
    TaskStatus.done: Container(
      padding: const EdgeInsets.all(10),
      child: const Text(
        "Done",
        style: TextStyle(color: Colors.white),
      ),
    ),
  };

  final TaskStatus selectedControl;
}

final class HomeInitial extends HomeState {
  HomeInitial({super.selectedControl = TaskStatus.todo});
}

final class HomeUpdate extends HomeState {
  HomeUpdate(TaskStatus control) : super(selectedControl: control);
}
