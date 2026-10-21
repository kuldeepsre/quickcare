import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:patientapp/Care/provider/navigation_provider.dart';
import 'package:provider/provider.dart';

class FamilyCareBanner extends StatelessWidget {
  const FamilyCareBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Fixed overlapping avatars using a Stack
              SizedBox(
                width: 76,
                height: 40,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFFFEE2E2),
                        child: const Icon(Icons.person, color: Color(0xFFDC2626), size: 18),
                      ),
                    ),
                    Positioned(
                      left: 18,
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFFD1FAE5),
                        child: const Icon(Icons.person, color: Color(0xFF059669), size: 18),
                      ),
                    ),
                    Positioned(
                      left: 36,
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFFDBEAFE),
                        child: const Icon(Icons.person, color: Color(0xFF2563EB), size: 18),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('FAMILY CARE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                    SizedBox(height: 2),
                    Text('Care for everyone you love', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(height: 2),
                    Text('Manage appointments and records for your family from one secure place.', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),

            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            OutlinedButton(
              onPressed: () {
                context.read<NavigationProvider>().changePage(3);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF0F3E33),
                side: const BorderSide(color: Color(0xFF0F3E33)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Manage family'),
            ),
          ],)
        ],
      ),
    );
  }
}