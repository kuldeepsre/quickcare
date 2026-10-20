import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:patientapp/Care/Screens/HOMETAB/BookingsScreen.dart';
import 'package:patientapp/Care/widget/booking_card.dart';
import 'package:patientapp/Care/widget/primary_button.dart';
import 'package:patientapp/Care/widget/real_map_picker.dart';
import 'package:patientapp/utils/AppColors.dart';


class NewBookingFlow extends StatefulWidget {
  const NewBookingFlow({super.key});
  @override
  State<NewBookingFlow> createState() => _NewBookingFlowState();
}

class _NewBookingFlowState extends State<NewBookingFlow> {
  int step = 1;
  LatLng location = const LatLng(12.9784, 77.6408);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('NEW BOOKING', style: TextStyle(fontSize: 11, letterSpacing: 1.2, color: AppColors.primary, fontWeight: FontWeight.w700)),
        const Text('Ambulance', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 20),
        StepperWidget(current: step),
        const SizedBox(height: 24),
        if(step == 1) _StepOne(location: location, onChanged: (p) => location = p, onNext: () => setState(() => step = 2)),
        if(step == 2) _StepTwo(onNext: () => setState(() => step = 3)),
        if(step == 3) _StepThree(),
      ]),
    );
  }
}

class _StepOne extends StatelessWidget {
  final LatLng location;
  final Function(LatLng) onChanged;
  final VoidCallback onNext;
  const _StepOne({required this.location, required this.onChanged, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Where do you need care?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
      const SizedBox(height: 12),
      RealMapPicker(initialPosition: location, onLocationChanged: onChanged),
      const SizedBox(height: 20),
      PrimaryButton(text: 'Continue to schedule', onTap: onNext),
    ]);
  }
}

class _StepTwo extends StatefulWidget {
  final VoidCallback onNext;
  const _StepTwo({required this.onNext});
  @override
  State<_StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<_StepTwo> {
  int date = 19;
  String time = '10:30 AM';
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Choose a schedule', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
      const SizedBox(height: 12),
      Row(children: [
        DateChip(label: 'Today', day: '18', selected: date==18, onTap: ()=>setState(()=>date=18)),
        DateChip(label: 'Tomorrow', day: '19', selected: date==19, onTap: ()=>setState(()=>date=19)),
        DateChip(label: '20 Jun', day: '20', selected: date==20, onTap: ()=>setState(()=>date=20)),
      ]),
      const SizedBox(height: 12),
      Wrap(spacing: 8, children: ['9:00 AM','10:30 AM','12:00 PM','3:30 PM'].map((t) => TimeChip(label: t, selected: time==t, onTap: ()=>setState(()=>time=t))).toList()),
      const SizedBox(height: 20),
      PrimaryButton(text: 'Confirm booking', onTap: widget.onNext),
    ]);
  }
}

class _StepThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Icon(Icons.verified_user, size: 48, color: AppColors.primary),
      const Text('BOOKING CONFIRMED', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary)),
      const Text('Your care is on the way', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
      const SizedBox(height: 20),
      PrimaryButton(text: 'Done', onTap: () => Navigator.pop(context)),
    ]);
  }
}