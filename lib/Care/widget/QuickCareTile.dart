import 'package:flutter/material.dart';

class QuickCareCard extends StatelessWidget {
  final IconData icon;
  final dynamic label;
  final VoidCallback onTap;
  const QuickCareCard({super.key, required this.icon, required this.label,   required this.onTap,});

@override
Widget build(BuildContext context) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF007A55), size: 24),
          const SizedBox(height: 40),
          Text(
            label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
        ],
      ),
    ),
  );
}
}