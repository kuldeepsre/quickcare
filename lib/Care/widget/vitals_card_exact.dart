import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VitalsReadinessCard extends StatelessWidget {
  const VitalsReadinessCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Vitals readiness', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text('Vehicle CG-AMB-024 · Ravi Kumar', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                const SizedBox(height: 16),
                _greenTile(icon: Icons.assignment_outlined, title: 'Equipment check', value: '8/8 complete'),
                const SizedBox(height: 10),
                _greenTile(icon: Icons.air_outlined, title: 'Oxygen', value: '82%'),
                const SizedBox(height: 10),
                _whiteTile(icon: Icons.videocam_outlined, title: 'CCTV', value: 'Ready'),
                const SizedBox(height: 10),
                _whiteTile(icon: Icons.navigation_outlined, title: 'GPS', value: 'Strong'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity, height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0B6B4A), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: const Icon(Icons.navigation_outlined, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _greenTile({required IconData icon, required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(color: const Color(0xFFE8F5EC), borderRadius: BorderRadius.circular(10)),
      child: Row(children: [
        Icon(icon, size: 18, color: const Color(0xFF0B6B4A)),
        const SizedBox(width: 10),
        Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const Spacer(),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF0B6B4A))),
      ]),
    );
  }

  static Widget _whiteTile({required IconData icon, required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade300)),
      child: Row(children: [
        Icon(icon, size: 18, color: const Color(0xFF0B6B4A)),
        const SizedBox(width: 10),
        Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const Spacer(),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF0B6B4A))),
      ]),
    );
  }
}