import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Care/provider/LanguageProvider.dart';
import 'package:patientapp/Care/widget/CrewwAppBar.dart';
import 'package:patientapp/Care/widget/LanguageSelectorWidget.dart';
import 'package:patientapp/Care/widget/crew_language_selection.dart';
import 'package:patientapp/Crew/Screens/ActiveTrip.dart';
import 'package:patientapp/Crew/Screens/ChecklistScreen.dart';
import 'package:patientapp/Crew/Screens/DispatchScreen.dart';
import 'package:patientapp/Crew/Screens/earning_screens.dart';
import 'package:provider/provider.dart';

class CrewMainNavigationScreen extends StatefulWidget {
  const CrewMainNavigationScreen({
    super.key,
  });

  @override
  State<CrewMainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<CrewMainNavigationScreen> {
  int _currentIndex = 0;
  late final String currentLanguage;

  @override
  Widget build(BuildContext context) {
    final langProvider = context.watch<LanguageProvider>();

    final List<Widget> screens = [
      DispatchScreen(),
      ActiveTripScreen(),
      ChecklistScreen(),
      EarningsScreen(),
    ];

    // Nav config
    final navItems = [
      {'icon': Icons.dashboard_outlined, 'activeIcon': Icons.dashboard, 'label': langProvider.translate('dispatch')},
      {'icon': Icons.navigation_outlined, 'activeIcon': Icons.navigation, 'label': langProvider.translate('activeTrip')},
      {'icon': Icons.checklist_outlined, 'activeIcon': Icons.checklist, 'label': langProvider.translate('checklist')},
      {'icon': Icons.account_balance_wallet_outlined, 'activeIcon': Icons.account_balance_wallet, 'label': langProvider.translate('earnings')},
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric( vertical: 10),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left Section
                Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A8A25), // Main green
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.local_shipping_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'CareGorakhpur Crew',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFFC107),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'On duty',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFFFFB300),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                // Right Section
                Row(
                  children: [
                    // EN Selector
                    Container(
                      padding: const EdgeInsets.symmetric( vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F3EF),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFEAEAEA)),
                      ),
                      child: Row(
                        children:  [

                          Consumer<LanguageProvider>(
                            builder: (context, langProvider, child) {
                              return LanguageCrewSelectorWidget(
                                currentLanguage: langProvider.currentLanguage,
                                onLanguageChanged: langProvider.setLanguage,
                                onNotificationTap: () {
                                  // Navigate to notifications
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Wifi
                    Container(
                      width: 34,
                      height: 30,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F3EF),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFEAEAEA)),
                      ),
                      child: const Icon(Icons.wifi_rounded,
                          size: 16, color: Color(0xFF5A5A5A)),
                    ),
                    const SizedBox(width: 8),

                    // AK Avatar
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0E4D2A),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'AK',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: screens[_currentIndex],

        // ===== CUSTOM BOTTOM NAV WITH SELECTED BACKGROUND TAB =====
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, -2)),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(navItems.length, (index) {
                final isSelected = _currentIndex == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected? const Color(0xFF0B4B3D) : Colors.transparent, // Green rectangle when selected
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isSelected? navItems[index]['activeIcon'] as IconData : navItems[index]['icon'] as IconData,
                            size: 22,
                            color: isSelected? Colors.white : Colors.grey.shade600,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            navItems[index]['label'] as String,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: isSelected? FontWeight.w700 : FontWeight.w500,
                              color: isSelected? Colors.white : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}