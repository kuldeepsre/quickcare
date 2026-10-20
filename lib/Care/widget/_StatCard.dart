import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String value;
  final String label;
  const StatCard({required this.value, required this.label});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF102E26))),
            const SizedBox(height: 4),
            Text(label,
                style: TextStyle(
                    fontSize: 11.5,
                    color: Colors.black.withOpacity(0.45),
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}