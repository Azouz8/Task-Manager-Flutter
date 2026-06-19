import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubits/layout_cubit/layout_states.dart';
import 'package:task_manager/screens/home_screen.dart';
import 'package:task_manager/screens/matrix_screen.dart';
import 'package:task_manager/screens/profile_screen.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitial());

  static LayoutCubit get(BuildContext context) =>
      BlocProvider.of<LayoutCubit>(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
    const BottomNavigationBarItem(
      icon: Icon(Icons.grid_goldenratio_rounded),
      label: "Matrix",
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  ];

  List<Widget> screens = [const HomeScreen(), const MatrixScreen(), const ProfileScreen()];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(LayoutChangeBottomNavState());
  }
}
