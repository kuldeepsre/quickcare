import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:patientapp/Care/Screens/SearchLocationField.dart';
import 'package:patientapp/Care/provider/location_provider.dart';
import 'package:patientapp/Care/widget/booking_card.dart';
import 'package:patientapp/Care/widget/date_chip.dart';
import 'package:patientapp/Care/widget/primary_button.dart';
import 'package:patientapp/Care/widget/real_map_picker.dart';
import 'package:patientapp/Care/widget/stepper_widget.dart';
import 'package:patientapp/Care/widget/time_chip.dart';
import 'package:patientapp/utils/AppColors.dart';
import 'package:provider/provider.dart';

class NewBookingFlow extends StatefulWidget {
  const NewBookingFlow({super.key});

  @override
  State<NewBookingFlow> createState() => _NewBookingFlowState();
}

class _NewBookingFlowState extends State<NewBookingFlow> {
  int step = 1;
  LatLng location = const LatLng(12.9784, 77.6408);
  int selectedDate = 19;
  String selectedTime = '10:30 AM';
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    addressController = TextEditingController(
      text: '42, 12th Main Road, Indiranagar',
    );
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white, // <-- here
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(

        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.fromLTRB(
          20,
          20,
          20,
          32 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NEW BOOKING',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Ambulance',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, size: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              StepperWidget(current: step),
              const SizedBox(height: 24),
              if (step == 1)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Where do you need care?',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const Text(
                      'Confirm your pickup or care location.',
                      style: TextStyle(fontSize: 13, color: AppColors.textGrey),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      child:
                          const SearchLocationField(), // DONE - Search + Map + Auto Address
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      text: 'Continue to schedule',
                      onTap: () => setState(() => step = 2),
                    ),
                  ],
                ),
              if (step == 2)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Choose a schedule',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        DateChip(
                          label: 'Today',
                          day: '18',
                          selected: selectedDate == 18,
                          onTap: () => setState(() => selectedDate = 18),
                        ),
                        const SizedBox(width: 8),
                        DateChip(
                          label: 'Tomorrow',
                          day: '19',
                          selected: selectedDate == 19,
                          onTap: () => setState(() => selectedDate = 19),
                        ),
                        const SizedBox(width: 8),
                        DateChip(
                          label: '20 Jun',
                          day: '20',
                          selected: selectedDate == 20,
                          onTap: () => setState(() => selectedDate = 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Available times',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          ['9:00 AM', '10:30 AM', '12:00 PM', '3:30 PM']
                              .map(
                                (t) => TimeChip(
                                  label: t,
                                  selected: selectedTime == t,
                                  onTap: () => setState(() => selectedTime = t),
                                ),
                              )
                              .toList(),
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      text: 'Confirm booking',
                      onTap: () => setState(() => step = 3),
                    ),
                  ],
                ),
              if (step == 3)
                Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: AppColors.cardBg,
                        shape: BoxShape.circle,
                      ),
                      child:Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.shield_outlined,
                            size: 36,
                            color: AppColors.primary,
                          ),
                          Icon(
                            Icons.check,
                            size: 16,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'BOOKING CONFIRMED',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        color: AppColors.primary,
                      ),
                    ),
                    const Text(
                      'Your care is on the way',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.bg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Booking reference',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.textGrey,
                            ),
                          ),
                          Text(
                            'QC-18542',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    PrimaryButton(
                      text: 'Done',
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
