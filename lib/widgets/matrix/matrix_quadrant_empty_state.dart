import 'package:flutter/material.dart';

class MatrixQuadrantEmptyState extends StatelessWidget {
  const MatrixQuadrantEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: const Text(
          'No tasks',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ),
    );
  }
}
