import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FamilyCard extends StatelessWidget {
  final String initials;
  final String name;
  final String subtitle;
  final String bookings;
  final String records;
  final Color bgColor;
  const FamilyCard({
    super.key,
    required this.initials,
    required this.name,
    required this.subtitle,
    required this.bookings,
    required this.records,
    required this.bgColor,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8EFEC)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              initials,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F2D26),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF8A9E98),
            ),
          ),
          const SizedBox(height: 18),
          const Divider(color: Color(0xFFEFF4F1), height: 1),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'Bookings',
                      style: TextStyle(fontSize: 10, color: Color(0xFF8A9E98)),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      bookings,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F2D26),
                      ),
                    ),
                  ],
                ),
              ),
              Container(width: 1, height: 30, color: const Color(0xFFEFF4F1)),
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'Records',
                      style: TextStyle(fontSize: 10, color: Color(0xFF8A9E98)),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      records,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F2D26),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Color(0xFFEFF4F1), height: 1),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFE0E8E5)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text(
              'View profile',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0E4A3E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}