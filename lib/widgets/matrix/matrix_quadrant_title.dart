import 'package:flutter/material.dart';
import 'package:task_manager/widgets/matrix/quadrant_title_dot.dart';

import '../../models/task_model.dart';

class MatrixQuadrantTitle extends StatelessWidget {
  const MatrixQuadrantTitle({super.key, required this.taskCategory});

  final EisenhowerCategory taskCategory;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 8,
        children: [
          QuadrantTitleDot(color: taskCategory.color),
          Expanded(
            child: Text(
              taskCategory.title,
              style: TextStyle(
                color: taskCategory.color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
