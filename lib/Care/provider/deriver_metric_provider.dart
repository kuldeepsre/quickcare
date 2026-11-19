import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Care/model/metric_model.dart';

class MetricProvider extends ChangeNotifier {
  final List<MetricModel> _metrics = [
    MetricModel(
      icon: Icons.monitor_heart_outlined,
      iconColor: Colors.teal,
      title: "3",
      subtitle: "Trips today",
      caption: "+1 from yesterday",
    ),
    MetricModel(
      icon: Icons.access_time_outlined,
      iconColor: Colors.blue,
      title: "24 min",
      subtitle: "Avg. response",
      caption: "4 min faster",
    ),
    MetricModel(
      icon: Icons.verified_user_outlined,
      iconColor: Colors.purple,
      title: "4.9",
      subtitle: "Driver rating",
      caption: "128 reviews",
    ),
    MetricModel(
      icon: Icons.description_outlined,
      iconColor: Colors.amber.shade800,
      title: "₹3,840",
      subtitle: "This week",
      caption: "12 completed trips",
    ),
  ];

  List<MetricModel> get metrics => _metrics;
}