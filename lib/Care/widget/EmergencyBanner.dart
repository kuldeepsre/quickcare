import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Care/provider/LanguageProvider.dart';
import 'package:provider/provider.dart';

class EmergencyBanner extends StatelessWidget {
  const EmergencyBanner({super.key});

  @override
  Widget build(BuildContext context) {

    final  language=context.watch<LanguageProvider>();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFECACA)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFDC2626),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.airport_shuttle, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(language.translate('emergency_assistant'),

                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFFDC2626)),
                    ),
                    SizedBox(height: 2),
                    Text(language.translate('need_ambulance'),
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF991B1B)),
                    ),
                    SizedBox(height: 2),
                    Text(language.translate('nearest'),
                      style: TextStyle(fontSize: 12, color: Color(0xFFB91C1C)),
                    ),
                  ],
                ),
              ),

            ],
          ),
          SizedBox(height: 7,),
          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDC2626),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),

                label:  Text(language.translate('request_now')),
              ),
            ],
          )
        ],
      ),
    );
  }
}