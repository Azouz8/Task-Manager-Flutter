abstract class LayoutStates {
  final int currentIndex;
  const LayoutStates(this.currentIndex);
}

class LayoutInitial extends LayoutStates {
  const LayoutInitial() : super(0);
}

class LayoutChangeBottomNavState extends LayoutStates {
  const LayoutChangeBottomNavState(super.currentIndex);
}
