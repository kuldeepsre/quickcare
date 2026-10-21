import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:patientapp/Care/Screens/HOMETAB/BookingsScreen.dart';
import 'package:patientapp/Care/Screens/home_labe_test.dart';
import 'package:patientapp/Care/Screens/home_my_record.dart';
import 'package:patientapp/Care/Screens/home_nurse.dart';
import 'package:patientapp/Care/Screens/home_tele_consult.dart';
import 'package:patientapp/Care/Screens/hometab/BookingsScreen.dart';

import 'package:patientapp/Care/widget/ConvenienceGrid.dart';
import 'package:patientapp/Care/widget/EmergencyBanner.dart';
import 'package:patientapp/Care/widget/EmergencySosCard.dart';
import 'package:patientapp/Care/widget/FamilyCareBanner.dart';
import 'package:patientapp/Care/widget/LanguageSelectorWidget.dart';
import 'package:patientapp/Care/widget/MyRecordsCard.dart';
import 'package:patientapp/Care/widget/NotificationIcon.dart';
import 'package:patientapp/Care/widget/UpcomingBookingCard.dart';
import 'package:patientapp/main.dart';
import 'package:patientapp/utils/AppRoute.dart';
import 'package:provider/provider.dart';

import '../../provider/LanguageProvider.dart';
import '../../widget/QuickCareTile.dart';

class PatientDashboardScreen extends StatefulWidget {
  const PatientDashboardScreen({super.key});

  @override
  State<PatientDashboardScreen> createState() => _PatientDashboardScreenState();
}

class _PatientDashboardScreenState extends State<PatientDashboardScreen> {
  String _currentAddress = "Fetching location...";

  @override
  void initState() {
    super.initState();
    _determinePositionAndAddress();
  }

  Future<void> _determinePositionAndAddress() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => _currentAddress = "Location services are disabled.");
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _currentAddress = "Location permissions are denied");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => _currentAddress = "Location permissions are permanently denied.");
      return;
    }

    try {
      // Get current GPS coordinates
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Reverse geocode coordinates to get address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _currentAddress = "${place.subLocality ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}".replaceAll(RegExp(r'^,\s*'), '');
        });
      }
    } catch (e) {
      setState(() => _currentAddress = "Gorakhpur, Uttar Pradesh"); // Fallback
    }
  }
  @override
  Widget build(BuildContext context) {
    // Accessing the provider using context.watch for reactive rebuilds
    final langProvider = context.watch<LanguageProvider>();

    return Scaffold(

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Greeting & Location
            Text(
              langProvider.translate('greeting'),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                const Icon(Icons.location_on, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  _currentAddress, // Displays live fetched address,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Emergency Help Card (SOS)

        /*    EmergencySosCard(langProvider: langProvider,),*/
            const SizedBox(height: 16),
            // Active Ambulance Banner
            EmergencyBanner(),
            const SizedBox(height: 24),

            // Quick Care Section
            Text(
              langProvider.translate('quickCare'),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            ConvenienceGrid(),
            const SizedBox(height: 24),
            UpcomingBookingCard(),
            const SizedBox(height: 24),
            MyRecordsCard(),
            const SizedBox(height: 24),
            FamilyCareBanner()
          ],
        ),
      ),
    );
  }
}
