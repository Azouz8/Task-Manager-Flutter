import 'package:flutter/material.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/widgets/custom_checkbox.dart';
class MatrixTaskCard extends StatelessWidget {
  const MatrixTaskCard({
    super.key,
    required this.task,
  });

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Draggable<TaskModel>(
      data: task,
      feedback: Material(
        type: MaterialType.transparency,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: _buildBaseContainer(context),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.4,
        child: _buildBaseContainer(context),
      ),
      child: _buildBaseContainer(context),
    );
  }

  Container _buildBaseContainer(BuildContext context){
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomCheckbox(task: task),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              task.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}