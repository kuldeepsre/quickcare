import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerifiedBadge extends StatelessWidget {
  const VerifiedBadge({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F2EF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: const BoxDecoration(
              color: Color(0xFF0E4A3E),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              size: 10,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            'Verified account',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0E4A3E),
            ),
          ),
        ],
      ),
    );
  }
}