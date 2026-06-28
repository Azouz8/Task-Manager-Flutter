import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/widgets/matrix/matrix_quadrant_empty_state.dart';
import 'package:task_manager/widgets/matrix/matrix_task_card_placeholder.dart';

import '../../cubits/task_cubit/task_cubit.dart';
import '../../cubits/task_cubit/task_states.dart';
import '../../models/task_model.dart';
import 'matrix_task_card.dart';

class MatrixQuadrantTaskList extends StatelessWidget {
  const MatrixQuadrantTaskList({
    super.key,
    required this.taskCategory,
    required this.isHovered,
  });

  final EisenhowerCategory taskCategory;
  final bool isHovered;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<TaskCubit, TaskStates>(
        builder: (context, state) {
          final tasks = context.read<TaskCubit>().getTasksByCategory(
            taskCategory,
          );

          // Empty State
          if (tasks.isEmpty && !isHovered) {
            return const MatrixQuadrantEmptyState();
          }

          return ListView.builder(
            itemCount: tasks.length + (isHovered ? 1 : 0),
            itemBuilder: ((context, index) {
              if (index >= tasks.length) {
                return MatrixTaskCardPlaceholder(color: taskCategory.color);
              }
              final task = tasks.elementAt(index);
              return MatrixTaskCard(task: task);
            }),
          );
        },
      ),
    );
  }
}
