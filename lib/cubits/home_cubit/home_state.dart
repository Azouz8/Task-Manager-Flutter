part of 'home_cubit.dart';

@immutable
sealed class HomeState {
  HomeState({required this.selectedControl});
  final Map<SlidingBarControl, Container> slidingBarControlsMap = {
    SlidingBarControl.overDue: Container(
      padding: const EdgeInsets.all(10),
      child: const Text(
        "Overdue",
        style: TextStyle(color: Colors.white),
      ),
    ),
    SlidingBarControl.toDo: Container(
      padding: const EdgeInsets.all(10),
      child: const Text(
        "To Do",
        style: TextStyle(color: Colors.white),
      ),
    ),
    SlidingBarControl.doing: Container(
      padding: const EdgeInsets.all(10),
      child: const Text(
        "Doing",
        style: TextStyle(color: Colors.white),
      ),
    ),
    SlidingBarControl.done: Container(
      padding: const EdgeInsets.all(10),
      child: const Text(
        "Done",
        style: TextStyle(color: Colors.white),
      ),
    ),
  };

  final SlidingBarControl selectedControl;
}

final class HomeInitial extends HomeState {
  HomeInitial({super.selectedControl = SlidingBarControl.toDo});
}

final class HomeUpdate extends HomeState {
  HomeUpdate(SlidingBarControl control) : super(selectedControl: control);
}

enum SlidingBarControl { overDue, toDo, doing, done }
