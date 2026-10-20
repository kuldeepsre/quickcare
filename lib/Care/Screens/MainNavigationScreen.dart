import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Care/Screens/auth/PhoneLoginScreen.dart';
import 'package:patientapp/Care/Screens/hometab/my_profile.dart';
import 'package:patientapp/Care/widget/LanguageSelectorWidget.dart';
import 'package:patientapp/utils/AppRoute.dart';
import 'package:provider/provider.dart';

import '../provider/LanguageProvider.dart';
import 'HOMETAB/BookingsScreen.dart';
import 'HOMETAB/PatientDashboardScreen.dart';
import '../Screens/RecordsScreen.dart';
import 'HOMETAB/FamilyScreen.dart';


class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = [
    const PatientDashboardScreen(),
    const BookingsScreen(),
    HealthRecordsScreen(),
    const FamilyScreen(),
    MyProfileScreen(),
  ];

  void _onTapDrawer(int index) {
    setState(() => _currentIndex = index);
    Navigator.pop(context); // close drawer
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = context.watch<LanguageProvider>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(langProvider.translate('exitApp'),
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            content: Text(langProvider.translate('areSureExitApp'),
                style: const TextStyle(fontSize: 12)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(langProvider.translate('cancel')),
              ),
              TextButton(
                onPressed: () {
                  AppRoute.toAndRemoveUntil(context, const PhoneLoginScreen());
                },
                child: Text(langProvider.translate('Yes')),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: _buildDrawer(langProvider),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF0F2D26)),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          title: Row(
            children: [
              Text(
                langProvider.translate('appName'),
                style: const TextStyle(
                  color: Color(0xFF007A55),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              Consumer<LanguageProvider>(
                builder: (context, langProvider, child) {
                  return LanguageSelectorWidget(
                    currentLanguage: langProvider.currentLanguage,
                    onLanguageChanged: langProvider.setLanguage,
                    onNotificationTap: () {},
                  );
                },
              ),
            ],
          ),
        ),
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF007A55),
          unselectedItemColor: Colors.grey,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          items: [
            BottomNavigationBarItem(icon: const Icon(Icons.home), label: langProvider.translate('home')),
            BottomNavigationBarItem(icon: const Icon(Icons.calendar_today), label: langProvider.translate('bookings')),
            BottomNavigationBarItem(icon: const Icon(Icons.folder_open), label: langProvider.translate('records')),
            BottomNavigationBarItem(icon: const Icon(Icons.people_outline), label: langProvider.translate('family')),
            BottomNavigationBarItem(icon: const Icon(Icons.person_outline), label: langProvider.translate('profile')),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(LanguageProvider langProvider) {
    return Drawer(
      backgroundColor: Colors.white,
      width: 280,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0E4A3E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.favorite_border, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('QuickCare',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: Color(0xFF0F2D26))),
                      Text('Private health support',
                          style: TextStyle(fontSize: 10, color: Color(0xFF8A9E98))),
                    ],
                  ),
                ],
              ),
            ),

            // Menu Items
            _drawerItem(
              icon: Icons.home_outlined,
              label: langProvider.translate('home'),
              selected: _currentIndex == 0,
              onTap: () => _onTapDrawer(0),
            ),
            _drawerItem(
              icon: Icons.calendar_today_outlined,
              label: langProvider.translate('bookings'),
              selected: _currentIndex == 1,
              onTap: () => _onTapDrawer(1),
            ),
            _drawerItem(
              icon: Icons.description_outlined,
              label: langProvider.translate('records'),
              selected: _currentIndex == 2,
              onTap: () => _onTapDrawer(2),
            ),
            _drawerItem(
              icon: Icons.people_alt_outlined,
              label: langProvider.translate('family'),
              selected: _currentIndex == 3,
              onTap: () => _onTapDrawer(3),
            ),
            _drawerItem(
              icon: Icons.person_outline,
              label: langProvider.translate('profile'),
              selected: _currentIndex == 4,
              onTap: () => _onTapDrawer(4),
            ),

            const Spacer(),

            // Help Card
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0E3D33),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.call_outlined, color: Colors.white, size: 18),
                      ),
                      const SizedBox(height: 12),
                      const Text('NEED HELP?',
                          style: TextStyle(
                              color: Colors.white70, fontSize: 10, letterSpacing: 1, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      const Text('Care team available\n24/7',
                          style: TextStyle(
                              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700, height: 1.2)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Text('Call support',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                          const SizedBox(width: 4),
                          const Icon(Icons.chevron_right, color: Colors.white, size: 14),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: -20,
                    right: -20,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white.withOpacity(0.08)),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Profile
            Container(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xFFEFF4F1))),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE2F0E9),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Text('AK',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Color(0xFF0E4A3E))),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Arjun Kapor',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0F2D26))),
                        Text('Patient ID : QC-2048',
                            style: TextStyle(fontSize: 10, color: Color(0xFF8A9E98))),
                      ],
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down, size: 18, color: Color(0xFF6B7F7A)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFE9F2EF) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon,
            size: 20,
            color: selected ? const Color(0xFF0E4A3E) : const Color(0xFF6B7F7A)),
        title: Text(label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: selected ? const Color(0xFF0E4A3E) : const Color(0xFF5A6F69),
            )),
        onTap: onTap,
        dense: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        // left border indicator like screenshot
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}