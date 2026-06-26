import 'package:flutter/material.dart';
import 'package:task_manager/widgets/matrix/matrix_task_card.dart';
import 'package:task_manager/widgets/matrix/quadrant_title_dot.dart';

class MatrixQuadrant extends StatelessWidget {
  const MatrixQuadrant({
    super.key,
    required this.quadrantTitle,
    required this.color,
  });
  final String quadrantTitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              QuadrantTitleDot(color: color),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  quadrantTitle,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                MatrixTaskCard(
                  taskTitle: 'Fix Routing Bug',
                  color: color,
                ),
                MatrixTaskCard(
                  taskTitle: 'Client meeting prep',
                  color: color,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
