import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:patientapp/Care/provider/navigation_provider.dart';
import 'package:provider/provider.dart';

class UpcomingBookingCard extends StatelessWidget {
  const UpcomingBookingCard({super.key});

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
              Text('Upcoming booking', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              GestureDetector(
                  onTap: (){
                    context.read<NavigationProvider>().changePage(1);
                  },
                  child: Text('View all', style: TextStyle(color: Color(0xFF0F3E33), fontSize: 13, fontWeight: FontWeight.w600))),
            ],
          ),
          const SizedBox(height: 4),
          Text('Your next scheduled care', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECFDF5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: const [
                      Text('20', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF059669))),
                      Text('JUN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Color(0xFF059669))),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('HOME NURSE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                      const SizedBox(height: 2),
                      const Text('Post-operative nursing care', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      const SizedBox(height: 2),
                      const Text('Friday, 10:30 AM · 60 minutes', style: TextStyle(fontSize: 11, color: Colors.grey)),
                      const SizedBox(height: 8),
                      Row(
                        children: const [
                          CircleAvatar(
                            radius: 8,
                            backgroundColor: Color(0xFFD1FAE5),
                            child: Text('NS', style: TextStyle(fontSize: 7, color: Color(0xFF0F3E33), fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(width: 6),
                          Text('Assigned nurse Neha Sharma', style: TextStyle(fontSize: 11, color: Colors.grey)),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}