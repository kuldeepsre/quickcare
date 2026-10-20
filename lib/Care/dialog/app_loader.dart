
import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color color;

  const AppLoader({
    super.key,
    this.size = 30,
    this.strokeWidth = 3,
    this.color = const Color(0xFFE57373),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        color: color,
      ),
    );
  }
}
