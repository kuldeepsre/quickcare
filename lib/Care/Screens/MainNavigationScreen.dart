import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Care/Screens/auth/PhoneLoginScreen.dart';
import 'package:patientapp/Care/Screens/driver/DriverOverviewScreen.dart';
import 'package:patientapp/Care/Screens/driver/TripScreen.dart';
import 'package:patientapp/Care/Screens/driver/document_tab.dart';
import 'package:patientapp/Care/Screens/driver/driver_profile.dart';
import 'package:patientapp/Care/Screens/driver/request_tab.dart';
import 'package:patientapp/Care/Screens/hometab/my_profile.dart';
import 'package:patientapp/Care/Screens/hospital/hospital_admission_tab.dart';
import 'package:patientapp/Care/Screens/hospital/hospital_document_tab.dart';
import 'package:patientapp/Care/Screens/hospital/hospital_overview_tab.dart';
import 'package:patientapp/Care/Screens/hospital/hospital_profile_tab.dart';
import 'package:patientapp/Care/Screens/hospital/hospital_request_tab.dart';
import 'package:patientapp/Care/provider/navigation_provider.dart';
import 'package:patientapp/Care/widget/LanguageSelectorWidget.dart';
import 'package:patientapp/Care/widget/logout_dialog.dart';
import 'package:patientapp/utils/AppColors.dart';
import 'package:patientapp/utils/AppRoute.dart';
import 'package:patientapp/utils/SessionManager.dart';
import 'package:provider/provider.dart';

import '../provider/LanguageProvider.dart';
import 'HOMETAB/BookingsScreen.dart';
import 'HOMETAB/PatientDashboardScreen.dart';
import '../Screens/RecordsScreen.dart';
import 'HOMETAB/FamilyScreen.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Enum for Portal Roles
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import your providers and screens
// import '../providers/navigation_provider.dart';
// import '../providers/language_provider.dart';

enum PortalType { patient, driver, hospital, laboratory }

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  PortalType _selectedPortal = PortalType.patient;
  bool _isPortalMenuOpen = false;

  static const Color primaryColor = Color(0xFF007A55);
  static const Color darkGreen = Color(0xFF0E4A3E);

  // Portal Details mapping for title, icon, user profile name, and subtitle
  Map<String, dynamic> _getPortalDetails(PortalType type) {
    switch (type) {
      case PortalType.driver:
        return {'title': 'Driver', 'icon': Icons.directions_car, 'user': 'Rahul Verma', 'sub': 'Driver · AMB-118'};
      case PortalType.hospital:
        return {'title': 'Hospital', 'icon': Icons.local_hospital, 'user': 'CityCare Hospital', 'sub': 'Admin Portal'};
      case PortalType.laboratory:
        return {'title': 'Laboratory', 'icon': Icons.science, 'user': 'Apex Diagnostics', 'sub': 'Lab Manager'};
      case PortalType.patient:
      default:
        return {'title': 'Patient', 'icon': Icons.person_outline, 'user': 'Arjun Kapor', 'sub': 'Patient ID: QC-2048'};
    }
  }

  // Dynamic Pages based on Selected Portal
  List<Widget> _getPortalPages() {
    switch (_selectedPortal) {
      case PortalType.driver:
        return  [
          const DriverOverviewScreen(),
          const RequestsDashboardScreen(),
          const TripScreen(),
          const DocumentsScreen(),
          const DriverProfileScreen(),
        ];
      case PortalType.hospital:
        return [
          HospitalOverviewScreen(),
          HospitalRequestsScreen(),
          HospitalAdmistionScreen(),
          HospitalDocumentTab(),
          HospitalProfileScreen()
        ];
      case PortalType.laboratory:
        return const [
          Center(child: Text("Sample Collections", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          Center(child: Text("Reports & Diagnostics", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          Center(child: Text("Reports & Diagnostics", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          Center(child: Text("Reports & Diagnostics", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          Center(child: Text("Reports & Diagnostics", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
        ];
      case PortalType.patient:
      default:
        return [
          const PatientDashboardScreen(),
          const BookingsScreen(),
          const HealthRecordsScreen(),
          const FamilyScreen(),
          MyProfileScreen(),
        ];
    }
  }

  // FIXED HERE: was List> -> now List<Map<String, dynamic>>
  List<Map<String, dynamic>> _getSideMenuItems(dynamic language) {
    switch (_selectedPortal) {
      case PortalType.driver:
        return [
          {'icon': Icons.home_outlined, 'label':  language.translate('Overview')},
          {'icon': Icons.notifications_outlined, 'label':  language.translate('Requests')},
          {'icon': Icons.directions_car_outlined, 'label': language.translate('Trip')},
          {'icon': Icons.folder, 'label': language.translate('Documents')},
          {'icon': Icons.person_outline, 'label':language.translate('Profile')},
        ];
      case PortalType.hospital:
        return [
          {'icon': Icons.home_outlined, 'label': language.translate('Overview')},
          {'icon': Icons.request_page_sharp, 'label':language.translate('Requests')},
          {'icon': Icons.people_outline, 'label':  language.translate('Admissions')},
          {'icon': Icons.folder_outlined, 'label': language.translate('Documents')},
          {'icon': Icons.person_outline, 'label': language.translate('Profile')},
        ];
      case PortalType.laboratory:
        return [
          {'icon': Icons.home_outlined, 'label': language.translate('Overview')},
          {'icon': Icons.science_outlined, 'label': language.translate('TestOrders')},
          {'icon': Icons.monitor_heart, 'label':language.translate('Samples')},
          {'icon': Icons.folder, 'label': language.translate('Documents')},
          {'icon': Icons.person, 'label': language.translate('Profile')},
        ];
      case PortalType.patient:
      default:
        return [
          {'icon': Icons.home_outlined, 'label': language.translate('home')},
          {'icon': Icons.calendar_today_outlined, 'label': language.translate('bookings')},
          {'icon': Icons.description_outlined, 'label': language.translate('records')},
          {'icon': Icons.people_outline, 'label': language.translate('family')},
          {'icon': Icons.person_outline, 'label':language.translate('profile')},
        ];
    }
  }

  // Dynamic Bottom Navigation Bar Items based on Selected Portal
  List<BottomNavigationBarItem> _getBottomNavItems(dynamic language) {
    switch (_selectedPortal) {
      case PortalType.driver:
        return  [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: language.translate('Overview')),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: language.translate('Requests')),
          BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: language.translate('Trip')),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: language.translate('Documents')),
          BottomNavigationBarItem(icon: Icon(Icons.person), label:  language.translate('Profile')),
        ];
      case PortalType.hospital:
        return  [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: language.translate('Overview')),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping_outlined), label: language.translate('Requests')),
          BottomNavigationBarItem(icon: Icon(Icons.local_hospital_outlined), label: language.translate('Admissions')),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: language.translate('Documents')),
          BottomNavigationBarItem(icon: Icon(Icons.person), label:  language.translate('Profile')),

        ];
      case PortalType.laboratory:
        return  [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: language.translate('Overview')),
          BottomNavigationBarItem(icon: Icon(Icons.science),  label:language.translate('TestOrders')),
          BottomNavigationBarItem(icon: Icon(Icons.monitor_heart),  label:language.translate('Samples')),
          BottomNavigationBarItem(icon: Icon(Icons.folder_outlined), label: language.translate('Documents')),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: language.translate('Profile')),
        ];
      case PortalType.patient:
      default:
        return [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: language.translate('home')),
          BottomNavigationBarItem(icon: const Icon(Icons.calendar_today), label: language.translate('bookings')),
          BottomNavigationBarItem(icon: const Icon(Icons.folder_open), label: language.translate('records')),
          BottomNavigationBarItem(icon: const Icon(Icons.people_outline), label: language.translate('family')),
          BottomNavigationBarItem(icon: const Icon(Icons.person_outline), label: language.translate('profile')),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigation = context.watch<NavigationProvider>();
    final language = context.watch<LanguageProvider>();

    final pages = _getPortalPages();
    final sideMenuItems = _getSideMenuItems(language);
    final bottomNavItems = _getBottomNavItems(language);

    if (navigation.currentIndex >= pages.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<NavigationProvider>().changePage(0);
      });
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        showDialog<void>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text(language.translate('exitApp')),
            content: Text(language.translate('areSureExitApp')),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(language.translate('cancel')),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const PhoneLoginScreen()),
                        (route) => false,
                  );
                },
                child: Text(language.translate('Yes')),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Color(0xFF0F2D26)),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title: Row(
            children: [
              Text(
                language.translate('appName'),
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              Consumer<LanguageProvider>(
                builder: (context, provider, child) {
                  return LanguageSelectorWidget(
                    currentLanguage: provider.currentLanguage,
                    onLanguageChanged: provider.setLanguage,
                    onNotificationTap: () {},
                  );
                },
              ),
            ],
          ),
        ),
        drawer: _buildDrawer(context, navigation, language),
        body: IndexedStack(
          index: navigation.currentIndex < pages.length ? navigation.currentIndex : 0,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navigation.currentIndex < bottomNavItems.length ? navigation.currentIndex : 0,
          onTap: (index) {
            context.read<NavigationProvider>().changePage(index);
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          items: bottomNavItems,
        ),
      ),
    );
  }

  Widget _buildDrawer(
      BuildContext context,
      NavigationProvider navigation,
      LanguageProvider language,
      ) {
    final sideMenuItems = _getSideMenuItems(language);
    final currentInfo = _getPortalDetails(_selectedPortal);

    return Drawer(
      backgroundColor: Colors.white,
      width: 280,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: darkGreen,
                    child: Icon(Icons.favorite_border, color: Colors.white),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'QuickCare',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F2D26)),
                      ),
                      Text(
                        'Private health support',
                        style: TextStyle(fontSize: 10, color: Color(0xFF8A9E98)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "VIEWING WORKSPACE",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: () => setState(() => _isPortalMenuOpen = !_isPortalMenuOpen),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Icon(currentInfo['icon'] as IconData, size: 18, color: darkGreen),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(currentInfo['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                const Text("Switch portal", style: TextStyle(color: Colors.grey, fontSize: 10)),
                              ],
                            ),
                          ),
                          Icon(_isPortalMenuOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.grey, size: 18),
                        ],
                      ),
                    ),
                  ),
                  if (_isPortalMenuOpen)
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
                      ),
                      child: Column(
                        children: PortalType.values.map((portal) {
                          final info = _getPortalDetails(portal);
                          final isSelected = _selectedPortal == portal;
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _selectedPortal = portal;
                                _isPortalMenuOpen = false;
                              });
                              context.read<NavigationProvider>().changePage(0);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.grey.shade100 : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(info['icon'] as IconData, size: 16, color: isSelected ? darkGreen : Colors.black54),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      info['title'] as String,
                                      style: TextStyle(
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                        fontSize: 12,
                                        color: isSelected ? darkGreen : Colors.black87,
                                      ),
                                    ),
                                  ),
                                  if (isSelected) const Icon(Icons.verified_user, size: 14, color: Colors.green),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                ],
              ),
            ),
            const Divider(height: 20, color: Color(0xFFEFF4F1)),
            Expanded(
              child: ListView.builder(
                itemCount: sideMenuItems.length,
                itemBuilder: (context, index) {
                  final item = sideMenuItems[index];
                  final selected = index == navigation.currentIndex;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: selected ? const Color(0xFFE9F2EF) : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      dense: true,
                      leading: Icon(
                        item['icon'] as IconData,
                        size: 20,
                        color: selected ? darkGreen : const Color(0xFF6B7F7A),
                      ),
                      title: Text(
                        item['label'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                          color: selected ? darkGreen : const Color(0xFF5A6F69),
                        ),
                      ),
                      onTap: () {
                        context.read<NavigationProvider>().changePage(index);
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0E3D33),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.call_outlined, color: Colors.white),
                  const SizedBox(height: 12),
                  Text(language.translate('need_help'), style: const TextStyle(color: Colors.white70, fontSize: 10)),
                  const SizedBox(height: 6),
                  Text(language.translate('Careteam'), style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(language.translate('call_support'), style: const TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFEFF4F1)),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFFE2F0E9),
                child: Text(currentInfo['user'][0], style: const TextStyle(color: darkGreen)),
              ),
              title: Text(currentInfo['user'] as String, style: const TextStyle(fontSize: 12)),
              subtitle: Text(currentInfo['sub'] as String, style: const TextStyle(fontSize: 10)),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.surfaceWhite,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.logout, color: AppColors.red, size: 20),
                ),
                title: Text(language.translate('logout'), style: const TextStyle(color: AppColors.red, fontWeight: FontWeight.w600)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.red),
                onTap: () => LogoutDialog.show(
                  context,
                  onConfirm: () async {
                    await SessionManager.clearSession();
                    AppRoute.toAndRemoveUntil(context, const PhoneLoginScreen());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}