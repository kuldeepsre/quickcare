import 'package:flutter/material.dart';
import 'package:patientapp/utils/AppColors.dart';


class DateChip extends StatelessWidget {
  final String label;
  final String day;
  final bool selected;
  final VoidCallback onTap;

  const DateChip({
    super.key,
    required this.label,
    required this.day,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFE3F3EF) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
              width: selected ? 1.2 : 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top label: Today / Tomorrow / 20 Jun
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: selected ? AppColors.primary : AppColors.textLight,
                ),
              ),
              const SizedBox(height: 3),
              // Day number: 18 / 19 / 20
              Text(
                day,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: selected ? AppColors.primary : AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}