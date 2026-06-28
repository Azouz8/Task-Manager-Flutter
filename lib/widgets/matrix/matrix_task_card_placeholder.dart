import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class MatrixTaskCardPlaceholder extends StatelessWidget {
  const MatrixTaskCardPlaceholder({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return  DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: const Radius.circular(16),
        color: color.withAlpha(50),
        strokeWidth: 2,
        dashPattern: const [6, 4],
        strokeCap: StrokeCap.round
      ),
      child: Container(
        height: 50,
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          'Drop here',
          style: TextStyle(
            color: color.withAlpha(60),
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
