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
            showUnselectedLabels: false,
            showSelectedLabels: false,
            enableFeedback: false,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
          ),
          backgroundColor: const Color(0xff121212),
        );
      },
    );
  }
}
