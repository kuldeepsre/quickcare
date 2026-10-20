import 'package:flutter/material.dart';
import 'package:patientapp/utils/AppColors.dart';


class CustomTab extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback? onTap;

  const CustomTab({
    super.key,
    required this.label,
    required this.active,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Label
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: active ? AppColors.primary : AppColors.textLight,
            ),
          ),
          const SizedBox(height: 6),
          // Active underline - 50px wide like in screenshot
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 2.5,
            width: active ? 50 : 0,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}