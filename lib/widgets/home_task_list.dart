import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubits/home_cubit/home_cubit.dart';
import 'package:task_manager/cubits/task_cubit/task_cubit.dart';
import 'package:task_manager/cubits/task_cubit/task_states.dart';
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
            return allTasks.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: allTasks.length,
                      itemBuilder: (context, index) {
                        final task = allTasks[index];
                        return TaskCard(
                          allTasks[index],
                          key: ValueKey(task.id),
                          updateTask: updateTask,
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: Column(
                      mainAxisAlignment: .center,
                      mainAxisSize: .min,
                      children: [
                        Text(
                          "There is no Tasks to Do,",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
                        ),
                        Text(
                          "Hurry up and add some!",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
          },
        );
      },
    );
  }
}
