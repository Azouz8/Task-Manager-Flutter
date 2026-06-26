import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubits/home_cubit/home_cubit.dart';
import 'package:task_manager/widgets/home_appbar.dart';
import 'package:task_manager/widgets/home_slidingbar.dart';
import 'package:task_manager/widgets/home_task_list.dart';
import 'package:task_manager/widgets/task_form/home_taskform.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openTaskForm(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return HomeTaskform();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _openTaskForm(context);
          },
          shape: const CircleBorder(),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          child: const Icon(Icons.add),
        ),
        body: const Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            HomeAppbar(),
            HomeSlidingbar(),
            HomeTaskList(),
          ],
        ),
      ),
    );
  }
}
