import 'package:flutter/material.dart';
import 'package:task_manager/widgets/custom_checkbox.dart';

class MatrixTaskCard extends StatelessWidget {
  const MatrixTaskCard({
    super.key,
    required this.taskTitle,
    required this.color,
  });
  final String taskTitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCheckbox(color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              taskTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
