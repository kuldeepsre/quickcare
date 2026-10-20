import 'package:flutter/material.dart';
import 'package:patientapp/utils/AppColors.dart';


class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const PrimaryButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
          if (text != 'Done') const SizedBox(width: 6),
          if (text != 'Done') const Icon(Icons.chevron_right, size: 18),
        ]),
      ),
    );
  }
}