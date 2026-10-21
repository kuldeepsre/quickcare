import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Care/Screens/auth/PhoneLoginScreen.dart';
import 'package:patientapp/Care/Screens/hometab/my_profile.dart';
import 'package:patientapp/Care/provider/navigation_provider.dart';
import 'package:patientapp/Care/widget/LanguageSelectorWidget.dart';
import 'package:patientapp/utils/AppRoute.dart';
import 'package:provider/provider.dart';

import '../provider/LanguageProvider.dart';
import 'HOMETAB/BookingsScreen.dart';
import 'HOMETAB/PatientDashboardScreen.dart';
import '../Screens/RecordsScreen.dart';
import 'HOMETAB/FamilyScreen.dart';


class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  static const Color primaryColor = Color(0xFF007A55);
  static const Color darkGreen = Color(0xFF0E4A3E);

  @override
  Widget build(BuildContext context) {
    final navigation = context.watch<NavigationProvider>();
    final language = context.watch<LanguageProvider>();

    final List<Widget> pages = [
      const PatientDashboardScreen(),
      const BookingsScreen(),
      HealthRecordsScreen(),
      const FamilyScreen(),
      MyProfileScreen(),
    ];

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
                    MaterialPageRoute(
                      builder: (_) => const PhoneLoginScreen(),
                    ),
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
              icon: const Icon(
                Icons.menu,
                color: Color(0xFF0F2D26),
              ),
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

        // Keeps the selected page and its state alive.
        body: IndexedStack(
          index: navigation.currentIndex,
          children: pages,
        ),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navigation.currentIndex,
          onTap: (index) {
            context.read<NavigationProvider>().changePage(index);
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: language.translate('home'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.calendar_today),
              label: language.translate('bookings'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.folder_open),
              label: language.translate('records'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.people_outline),
              label: language.translate('family'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              label: language.translate('profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(
      BuildContext context,
      NavigationProvider navigation,
      LanguageProvider language,
      ) {
    return Drawer(
      backgroundColor: Colors.white,
      width: 280,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
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
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'QuickCare',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF0F2D26),
                        ),
                      ),
                      Text(
                        'Private health support',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF8A9E98),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            _drawerItem(
              context,
              icon: Icons.home_outlined,
              label: language.translate('home'),
              index: 0,
              selectedIndex: navigation.currentIndex,
            ),
            _drawerItem(
              context,
              icon: Icons.calendar_today_outlined,
              label: language.translate('bookings'),
              index: 1,
              selectedIndex: navigation.currentIndex,
            ),
            _drawerItem(
              context,
              icon: Icons.description_outlined,
              label: language.translate('records'),
              index: 2,
              selectedIndex: navigation.currentIndex,
            ),
            _drawerItem(
              context,
              icon: Icons.people_outline,
              label: language.translate('family'),
              index: 3,
              selectedIndex: navigation.currentIndex,
            ),
            _drawerItem(
              context,
              icon: Icons.person_outline,
              label: language.translate('profile'),
              index: 4,
              selectedIndex: navigation.currentIndex,
            ),

            const Spacer(),

            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0E3D33),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.call_outlined, color: Colors.white),
                  SizedBox(height: 12),
                  Text(
                    'NEED HELP?',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Care team available\n24/7',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Call support  ›',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: Color(0xFFEFF4F1)),

            const ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(0xFFE2F0E9),
                child: Text(
                  'AK',
                  style: TextStyle(color: darkGreen),
                ),
              ),
              title: Text(
                'Arjun Kapor',
                style: TextStyle(fontSize: 12),
              ),
              subtitle: Text(
                'Patient ID: QC-2048',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(
      BuildContext context, {
        required IconData icon,
        required String label,
        required int index,
        required int selectedIndex,
      }) {
    final selected = index == selectedIndex;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: selected
            ? const Color(0xFFE9F2EF)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(
          icon,
          size: 20,
          color: selected ? darkGreen : const Color(0xFF6B7F7A),
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight:
            selected ? FontWeight.w700 : FontWeight.w500,
            color: selected ? darkGreen : const Color(0xFF5A6F69),
          ),
        ),
        onTap: () {
          context.read<NavigationProvider>().changePage(index);
          Navigator.pop(context);
        },
      ),
    );
  }
}