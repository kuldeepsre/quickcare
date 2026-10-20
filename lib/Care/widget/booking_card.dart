// booking_card.dart
import 'package:flutter/material.dart';
import 'package:patientapp/utils/AppColors.dart';



class BookingCard extends StatelessWidget {
  final String date, month, tag, title, info, status;
  const BookingCard({
    super.key,
    required this.date,
    required this.month,
    required this.tag,
    required this.title,
    required this.info,
    required this.status,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return const Color(0xFFE3F3EF); // greenish
      case 'scheduled':
        return const Color(0xFFEAF2FF); // bluish
      case 'cancelled':
        return const Color(0xFFFFE9E9);
      default:
        return AppColors.mint;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56,
          height: 64,
          decoration: BoxDecoration(color: AppColors.cardBg, borderRadius: BorderRadius.circular(14)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(date, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.primary)),
            Text(month, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textGrey)),
          ]),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(tag, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.primary, letterSpacing: 1.2)),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textDark)),
            const SizedBox(height: 6),
            Row(children: [
              const Icon(Icons.access_time, size: 14, color: AppColors.textLight),
              const SizedBox(width: 4),
              Expanded(child: Text(info, style: const TextStyle(fontSize: 12, color: AppColors.textGrey))),
            ]),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: _getStatusColor(status), borderRadius: BorderRadius.circular(20)),
                  child: Text(status, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primary)),
                ),
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
                    'View Details',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0E4A3E),
                    ),
                  ),
                )
              ],
            ),

          ]),
        ),
      ],
    );
  }
}



// date_chip.dart & time_chip.dart - same logic extracted