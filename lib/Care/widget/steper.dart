import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Stepper extends StatelessWidget {
  final int current;
  const Stepper({required this.current});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      for (int i = 1; i <= 3; i++) ...[
        Container(width: 28, height: 28, decoration: BoxDecoration(color: current >= i ? const Color(0xFF0E4D44) : Colors.white, shape: BoxShape.circle, border: Border.all(color: current >= i ? const Color(0xFF0E4D44) : const Color(0xFFDDE8E3))), child: Center(child: Text('$i', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: current >= i ? Colors.white : const Color(0xFF9DB5AF))))),
        if (i < 3) Expanded(child: Container(height: 1, color: const Color(0xFFDDE8E3))),
      ]
    ]);
  }
}