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
import 'package:patientapp/Care/widget/EmergencySosCard.dart';
import 'package:patientapp/Care/widget/LanguageSelectorWidget.dart';
import 'package:patientapp/Care/widget/NotificationIcon.dart';
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

            EmergencySosCard(langProvider: langProvider,),
            const SizedBox(height: 16),
            // Active Ambulance Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFD0E8DC)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE0EDE5),
                                    // Matches the card/screen accent tone
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    langProvider.translate('onTheWay'),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF000000),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  'CG-AMB-024',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  '6 min',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color(0xFF007A55),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.directions_car,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            langProvider.translate('headingToYou'),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Galaxy Hospital, Gorakhpur',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Vertically Stacked Track Ambulance Button (Full Width)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF007A55),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/track_ambulance.png', height: 32),
                          const SizedBox(width: 8),
                          Text(
                            langProvider.translate('trackAmbulance'),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.6,
              children: [
                QuickCareCard(
                  icon: Icons.airport_shuttle,
                  label: langProvider.translate('bookAmbulance'),
                  onTap: () {
                  /*  AppRoute.to(context, BookingsScreen());*/
                  },
                ),
                QuickCareCard(
                  icon: Icons.favorite_border,
                  label: langProvider.translate('homeNurse'),
                  onTap: () {
                    AppRoute.to(context, HomeNurse());
                  },
                ),
                QuickCareCard(
                  icon: Icons.edit_note,
                  label: langProvider.translate('homeLabTest'),
                  onTap: () {
                    AppRoute.to(context, HomeLabeTest());
                  },
                ),
                QuickCareCard(
                  icon: Icons.video_call,
                  label: langProvider.translate('teleConsult'),
                  onTap: () {
                    AppRoute.to(context, TeleConsult());
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            QuickCareCard(
              icon: Icons.description_outlined,
              label: langProvider.translate('myRecords'),
              onTap: () {
                AppRoute.to(context, MyRecords());
              },
            ),
            const SizedBox(height: 24),

            // Nearby Care Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        langProvider.translate('nearbyCare'),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.podcasts,
                        color: Color(0xFF007A55),
                        size: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    langProvider.translate('hospitalsOnline'),
                    style: const TextStyle(fontSize: 12,fontWeight:FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    langProvider.translate('labsAccepting'),
                    style: const TextStyle(fontSize: 12,fontWeight:FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        size: 8,
                        color: Color(0xFF007A55),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        langProvider.translate('liveAvailability'),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF007A55),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
