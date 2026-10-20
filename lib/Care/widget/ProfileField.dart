import 'package:flutter/cupertino.dart';

class ProfileField extends StatelessWidget {
  final String label;
  final String value;
  const ProfileField({super.key, required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF8A9E98),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0F2D26),
          ),
        ),
      ],
    );
  }
}