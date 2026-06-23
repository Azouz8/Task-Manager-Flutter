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
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xFF444444),
                  width: 1,
                ),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: state.currentIndex,
              items: cubit.bottomItems,
              onTap: (value) {
                cubit.changeBottomNavIndex(value);
              },
              showUnselectedLabels: true,
              showSelectedLabels: true,
              enableFeedback: false,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xFF201F1F),
              selectedItemColor: const Color(0xFFC1C1FF),
              unselectedItemColor: const Color(0xFFAFAFAF),
              selectedLabelStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          backgroundColor: const Color(0xff121212),
        );
      },
    );
  }
}
