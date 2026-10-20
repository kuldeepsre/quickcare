// stepper_widget.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/utils/AppColors.dart';

class StepperWidget extends StatelessWidget {
  final int current;
  const StepperWidget({super.key, required this.current});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      for(int i=1; i<=3; i++)...[
        Container(width: 28, height: 28, decoration: BoxDecoration(color: current >= i ? AppColors.primary : Colors.white, shape: BoxShape.circle, border: Border.all(color: current >= i ? AppColors.primary : AppColors.border)),
            child: Center(child: Text('$i', style: TextStyle(fontSize: 12, color: current >= i ? Colors.white : Colors.grey)))),
        if(i<3) Expanded(child: Container(height: 1, color: AppColors.border)),
      ]
    ]);
  }
}