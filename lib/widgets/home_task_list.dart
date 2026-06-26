import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubits/home_cubit/home_cubit.dart';
import 'package:task_manager/cubits/task_cubit/task_cubit.dart';
import 'package:task_manager/cubits/task_cubit/tast_states.dart';
import 'package:task_manager/widgets/task_card.dart';

class HomeTaskList extends StatelessWidget {
  const HomeTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (homeContext, homeState) {
        return BlocBuilder<TaskCubit, TaskStates>(
          builder: (taskContext, taskState) {
            final updateTask = taskContext.read<TaskCubit>().updateTask;
            final allTasks = taskContext.read<TaskCubit>().getTasksByStatus(
              homeState.selectedControl,
            );
            return Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: allTasks.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    allTasks[index],
                    updateTask: updateTask,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
