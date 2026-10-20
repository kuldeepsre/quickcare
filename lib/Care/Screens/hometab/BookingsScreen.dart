import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Care/model/Booking.dart';
import 'package:patientapp/Care/provider/booking_provider.dart';
import 'package:patientapp/Care/widget/CustomTab.dart';
import 'package:patientapp/Care/widget/booking_card.dart';
import 'package:patientapp/Care/widget/new_booking.dart';
import 'package:patientapp/utils/AppColors.dart';
import 'package:provider/provider.dart';

import '../../provider/LanguageProvider.dart';

// --- MY BOOKINGS SCREEN ---
import 'package:flutter/material.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  int selectedTab = 0;
  final tabs = ['Upcoming', 'Past', 'Cancelled'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My bookings',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Track and manage your care appointments',
                style: TextStyle(fontSize: 14, color: AppColors.textGrey),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => const NewBookingFlow(),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text('+ New booking', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 24),

              // DYNAMIC TABS - YOUR REQUEST
              Row(
                children: List.generate(tabs.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index < tabs.length - 1 ? 24 : 0,
                    ),
                    child: CustomTab(
                      label: tabs[index],
                      active: selectedTab == index,
                      onTap: () => setState(() => selectedTab = index),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              Expanded(child: _buildTabContent()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return Consumer<BookingProvider>(
      builder: (context, provider, child) {
        // Filter by tab
        final List<Booking> list;
        if (selectedTab == 0) {
          list = provider.upcoming;
        } else if (selectedTab == 1) {
          list = provider.past;
        } else {
          list = provider.cancelled;
        }

        // Empty state
        if (list.isEmpty) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      selectedTab == 0
                          ? Icons.event_available
                          : selectedTab == 1
                          ? Icons.history
                          : Icons.cancel_outlined,
                      size: 40,
                      color: AppColors.textLight,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      selectedTab == 0
                          ? 'No upcoming bookings'
                          : selectedTab == 1
                          ? 'No past bookings'
                          : 'No cancelled bookings',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // List with builder
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: ListView.builder(
            padding: const EdgeInsets.all(18),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final booking = list[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BookingCard(
                    date: booking.date,
                    month: booking.month,
                    tag: booking.tag,
                    title: booking.title,
                    info: booking.info,
                    status: booking.status,
                  ),
                  if (index != list.length - 1)
                    const Divider(
                      height: 32,
                      thickness: 1,
                      color: Color(0xFFEEF4F1),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
