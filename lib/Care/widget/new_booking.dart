import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:patientapp/Care/Screens/SearchLocationField.dart';
import 'package:patientapp/Care/provider/LanguageProvider.dart';
import 'package:patientapp/Care/provider/ScheduleProvider.dart';

import 'package:patientapp/Care/widget/primary_button.dart';

import 'package:patientapp/Care/widget/stepper_widget.dart';
import 'package:patientapp/Care/widget/time_chip.dart';
import 'package:patientapp/utils/AppColors.dart';
import 'package:patientapp/utils/constants.dart';
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
    final langProvider=context.watch<LanguageProvider>();
    return Dialog(
      backgroundColor: Colors.white, // <-- here
      insetPadding: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child:  Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        langProvider.translate('newbooking'),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        langProvider.translate(Constants.booking_heading)
                       ,
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
                     Text(
                      langProvider.translate('needcare'),
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                     Text(langProvider.translate('confirmLocation')
                      ,
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
                      text:langProvider.translate('Continuetoschedule'),
                      onTap: () => setState(() => step = 2),
                    ),
                  ],
                ),
              if (step == 2)
                Consumer<ScheduleProvider>(
                  builder: (context, provider, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          langProvider.translate('Chooseschedule'),
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 16),
                        // DATES - from provider.dates (List<DateModel>)
                        if (provider.isLoadingDate)
                          const SizedBox(height: 50, child: Center(child: CircularProgressIndicator()))
                        else
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Row(
                              children: provider.dates.map((dateObj) {
                                final isSelected = provider.selectedDate?.value == dateObj.value;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: GestureDetector(
                                    onTap: () => provider.fetchTimes(dateObj),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 250),
                                      width: 72,
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      decoration: BoxDecoration(
                                        color: isSelected ? AppColors.primary : const Color(0xFFF5F5F5),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: isSelected ? AppColors.primary : Colors.transparent,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            dateObj.label.toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.5,
                                              color: isSelected ? Colors.white70 : Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            dateObj.day,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800,
                                              color: isSelected ? Colors.white : Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          // Dot indicator
                                          Container(
                                            height: 4,
                                            width: 4,
                                            decoration: BoxDecoration(
                                              color: isSelected ? Colors.white : Colors.transparent,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        const SizedBox(height: 18),
                         Text(langProvider.translate('availableTimes'),
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        // TIMES - from provider.times (List<TimeModel>)
                        if (provider.isLoadingTime)
                          const CircularProgressIndicator(strokeWidth: 2)
                        else
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: provider.times.map((timeObj) {
                              return TimeChip(
                                label: timeObj.label,
                                selected: provider.selectedTime?.value == timeObj.value,
                                onTap: () => provider.selectTime(timeObj),
                              );
                            }).toList(),
                          ),
                        const SizedBox(height: 20),
                        PrimaryButton(
                          text: langProvider.translate('confirmBooking'),
                          onTap: () => setState(() => step = 3),
                        ),
                      ],
                    );
                  },
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
                     Text(langProvider.translate('bookingConfirmed'),

                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        color: AppColors.primary,
                      ),
                    ),
                     Text(langProvider.translate('ontheWayCare'),

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
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(langProvider.translate('Bookingreference'),
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
                      text: langProvider.translate('done'),
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
