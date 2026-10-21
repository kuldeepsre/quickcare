import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Care/widget/ConvenienceCard.dart';


class ConvenienceGrid extends StatelessWidget {
  const ConvenienceGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth > 700;
        return isWide
            ? Row(
          children: const [
            Expanded(child: ConvenienceCard(title: 'Book Ambulance', subtitle: 'Emergency or scheduled transport', icon: Icons.airport_shuttle, iconBg: Color(0xFFFEF2F2), iconColor: Color(0xFFDC2626))),
            SizedBox(width: 16),
            Expanded(child: ConvenienceCard(title: 'Home Nurse', subtitle: 'Qualified care at your doorstep', icon: Icons.medical_services_outlined, iconBg: Color(0xFFECFDF5), iconColor: Color(0xFF059669))),
            SizedBox(width: 16),
            Expanded(child: ConvenienceCard(title: 'Home Lab Test', subtitle: 'Sample collection from home', icon: Icons.biotech_outlined, iconBg: Color(0xFFEFF6FF), iconColor: Color(0xFF2563EB))),
          ],
        )
            : Column(
          children: const [
            ConvenienceCard(title: 'Book Ambulance', subtitle: 'Emergency or scheduled transport', icon: Icons.airport_shuttle, iconBg: Color(0xFFFEF2F2), iconColor: Color(0xFFDC2626)),
            SizedBox(height: 12),
            ConvenienceCard(title: 'Home Nurse', subtitle: 'Qualified care at your doorstep', icon: Icons.medical_services_outlined, iconBg: Color(0xFFECFDF5), iconColor: Color(0xFF059669)),
            SizedBox(height: 12),
            ConvenienceCard(title: 'Home Lab Test', subtitle: 'Sample collection from home', icon: Icons.biotech_outlined, iconBg: Color(0xFFEFF6FF), iconColor: Color(0xFF2563EB)),
          ],
        );
      },
    );
  }
}