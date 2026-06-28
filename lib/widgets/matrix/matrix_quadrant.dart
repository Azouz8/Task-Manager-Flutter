import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubits/task_cubit/task_cubit.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/widgets/matrix/matrix_quadrant_task_list.dart';
import 'package:task_manager/widgets/matrix/matrix_quadrant_title.dart';

class MatrixQuadrant extends StatelessWidget {
  const MatrixQuadrant({
    super.key,
    required this.taskCategory,
  });

  final EisenhowerCategory taskCategory;

  @override
  Widget build(BuildContext context) {
    return DragTarget<TaskModel>(
      onAcceptWithDetails: (details) {
        final draggedTask = details.data;
        final updatedTask = draggedTask.copyWith(category: taskCategory);
        context.read<TaskCubit>().updateTask(updatedTask);
      },

      builder: (context, accepted, rejected) {
        final isHovered = accepted.isNotEmpty;
        return Container(
          decoration: BoxDecoration(
            color: isHovered
                ? Theme.of(context).cardColor.withAlpha(220)
                : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            children: [
              MatrixQuadrantTitle(taskCategory: taskCategory),
              const SizedBox(height: 16),
              MatrixQuadrantTaskList(taskCategory: taskCategory, isHovered: isHovered,),
            ],
          ),
        );
      },
    );
  }
}
