import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubits/layout_cubit/layout_cubit.dart';
import 'package:task_manager/cubits/layout_cubit/layout_states.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutStates>(
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return Scaffold(
          body: cubit.screens[state.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.currentIndex,
            items: cubit.bottomItems,
            onTap: (value) {
              cubit.changeBottomNavIndex(value);
            },
            backgroundColor: const Color(0xff5b9ee1),
            showUnselectedLabels: false,
            showSelectedLabels: false,
            enableFeedback: false,
            selectedItemColor: Colors.white,
            selectedIconTheme: const IconThemeData(
              color: Colors.white,
              size: 32,
            ),
            elevation: 0,
            unselectedItemColor: Colors.white54,
            type: BottomNavigationBarType.fixed,
          ),
        );
      },
    );
  }
}
