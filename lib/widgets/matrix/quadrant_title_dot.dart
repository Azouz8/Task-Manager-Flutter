import 'package:flutter/material.dart';

class QuadrantTitleDot extends StatelessWidget {
  const QuadrantTitleDot({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
