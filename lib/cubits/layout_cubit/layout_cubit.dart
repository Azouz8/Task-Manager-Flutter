import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubits/layout_cubit/layout_states.dart';
import 'package:task_manager/screens/home_screen.dart';
import 'package:task_manager/screens/matrix_screen.dart';
import 'package:task_manager/screens/profile_screen.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(const LayoutInitial());

  static LayoutCubit get(BuildContext context) =>
      BlocProvider.of<LayoutCubit>(context);

  int get currentIndex => state.currentIndex;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.format_list_bulleted),
      label: "Ledger",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.grid_view),
      label: "Matrix",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_rounded),
      label: "Profile",
    ),
  ];

  List<Widget> screens = [
    const HomeScreen(),
    const MatrixScreen(),
    const ProfileScreen(),
  ];

  void changeBottomNavIndex(int index) {
    emit(LayoutChangeBottomNavState(index));
  }
}
