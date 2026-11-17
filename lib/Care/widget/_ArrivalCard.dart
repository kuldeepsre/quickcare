import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArrivalCard extends StatelessWidget {
  final String indexNumber;
  final Color indexBgColor;
  final Color indexTextColor;
  final String title;
  final String subtitle;
  final String etaText;
  final String statusLabel;
  final Color statusBgColor;
  final Color statusTextColor;

  const ArrivalCard({
    Key? key,
     required this.indexNumber,
    required this.indexBgColor,
    required this.indexTextColor,
    required this.title,
    required this.subtitle,
    required this.etaText,
    required this.statusLabel,
    required this.statusBgColor,
    required this.statusTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6ECE9)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Index Number Badge
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: indexBgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              indexNumber,
              style: TextStyle(
                color: indexTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF102A21),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Status Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusBgColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        statusLabel,
                        style: TextStyle(
                          color: statusTextColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF667871),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  etaText,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0A5C36),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}