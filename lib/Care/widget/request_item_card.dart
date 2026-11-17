import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestItemCard extends StatelessWidget {
  final String number;
  final String title;
  final String route;
  final String distanceTime;
  final String badgeText;
  final Color badgeBgColor;
  final Color badgeTextColor;
  final Color numberBgColor;
  final Color numberTextColor;

   RequestItemCard({
    required this.number,
    required this.title,
    required this.route,
    required this.distanceTime,
    required this.badgeText,
    required this.badgeBgColor,
    required this.badgeTextColor,
    required this.numberBgColor,
    required this.numberTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: numberBgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            number,
            style: TextStyle(
              color: numberTextColor,
              fontWeight: FontWeight.w700,
              fontSize: 13.5,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF102A21),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                route,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF5F716A),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 14,
                    color: Color(0xFF7B8B85),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    distanceTime,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF7B8B85),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeBgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    color: badgeTextColor,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF102A21),
                  side: const BorderSide(color: Color(0xFFD5DFDB)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 9,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Review',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}