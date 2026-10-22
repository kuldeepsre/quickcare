import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Care/provider/LanguageProvider.dart';
import 'package:patientapp/Care/widget/ConvenienceCard.dart';
import 'package:patientapp/Care/widget/new_booking.dart';
import 'package:patientapp/utils/AppRoute.dart';
import 'package:patientapp/utils/constants.dart';
import 'package:provider/provider.dart';


class ConvenienceGrid extends StatelessWidget {
  const ConvenienceGrid({super.key});

  @override
  Widget build(BuildContext context) {

    final langProvider=context.watch<LanguageProvider>();
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth > 700;
        return Column(
          children:  [
            GestureDetector(
                onTap: (){

                  showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return NewBookingFlow();
                  },
                  );
                  Constants.booking_heading="bookAmbulance";
                },
                child: ConvenienceCard(title: langProvider.translate('bookAmbulance'), subtitle: 'Emergency or scheduled transport', icon: Icons.airport_shuttle, iconBg: Color(0xFFFEF2F2), iconColor: Color(0xFFDC2626))),
            SizedBox(height: 12),
            GestureDetector(
                onTap: (){
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return NewBookingFlow();
                      },
                  );
                  Constants.booking_heading="homeNurse";
                },

                child: ConvenienceCard(title: langProvider.translate('homeNurse'), subtitle: 'Qualified care at your doorstep', icon: Icons.medical_services_outlined, iconBg: Color(0xFFECFDF5), iconColor: Color(0xFF059669))),
            SizedBox(height: 12),
            GestureDetector(
                onTap: (){
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return NewBookingFlow();
                      },
                  );
                  Constants.booking_heading="homeLabTest";
                },
                child: ConvenienceCard(title:  langProvider.translate('homeLabTest'), subtitle: 'Sample collection from home', icon: Icons.biotech_outlined, iconBg: Color(0xFFEFF6FF), iconColor: Color(0xFF2563EB))),
          ],
        );
      },
    );
  }
}