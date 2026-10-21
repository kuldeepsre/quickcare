import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:patientapp/Care/provider/navigation_provider.dart';
import 'package:patientapp/Care/widget/record_items.dart';
import 'package:provider/provider.dart';

class MyRecordsCard extends StatelessWidget {
  const MyRecordsCard({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Text('My records',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              GestureDetector(
                onTap: (){
                  context.read<NavigationProvider>().changePage(2);
                },
                child: Text('View all', style: TextStyle(color: Color(0xFF0F3E33),
                    fontSize: 13,
                    fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text('Recent health activity',
              style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          const SizedBox(height: 16),
          const RecordItem(icon: Icons.science_outlined,
              title: 'Complete Blood Count',
              subtitle: 'Lab report · 12 Jun 2025'),
          const Divider(height: 24),
          const RecordItem(icon: Icons.description_outlined,
              title: 'Home Nursing Summary',
              subtitle: 'Visit notes · 08 Jun 2025'),
        ],
      ),
    );
  }
}