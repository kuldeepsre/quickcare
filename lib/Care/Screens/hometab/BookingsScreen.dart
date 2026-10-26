import 'package:flutter/material.dart';
import 'package:patientapp/Care/model/Booking.dart';
import 'package:patientapp/Care/provider/booking_provider.dart';
import 'package:patientapp/Care/widget/CustomTab.dart';
import 'package:patientapp/Care/widget/booking_card.dart';
import 'package:patientapp/Care/widget/new_booking.dart';
import 'package:patientapp/utils/AppColors.dart';
import 'package:patientapp/utils/constants.dart';
import 'package:provider/provider.dart';


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
                onPressed: () =>
                    showDialog(
                      context: context,
                      builder: (context) {
                        Constants.booking_heading = "bookAmbulance";
                        return const NewBookingFlow();
                      },
                    ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 22, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text('+ New booking',
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 24),
              // TABS
              Row(
                children: List.generate(tabs.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        right: index < tabs.length - 1 ? 24 : 0),
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

  // ========== MAIN SWITCHER ==========
  Widget _buildTabContent() {
    return Consumer<BookingProvider>(
      builder: (context, provider, child) {
        switch (selectedTab) {
          case 0:
            return _buildUpcomingList(provider.upcoming);
          case 1:
            return _buildPastList(provider.past);
          case 2:
            return _buildCancelledList(provider.cancelled);
          default:
            return const SizedBox();
        }
      },
    );
  }

  // ========== 1. UPCOMING LIST ==========
  Widget _buildUpcomingList(List<Booking> list) {
    if (list.isEmpty) {
      return _emptyState(
        icon: Icons.event_available,
        title: 'No upcoming bookings',
        subtitle: 'Your future appointments will appear here',
      );
    }
    return _whiteContainer(
      child: ListView.separated(
        padding: const EdgeInsets.all(18),
        itemCount: list.length,
        separatorBuilder: (_, __) => _divider(),
        itemBuilder: (context, i) {
          final b = list[i];
          return BookingCard(
            date: b.date,
            month: b.month,
            tag: b.tag,
            title: b.title,
            info: b.info,
            status: b.status,
          );
        },
      ),
    );
  }

  // ========== 2. PAST LIST (COMPLETED) ==========
  Widget _buildPastList(List<Booking> list) {
    if (list.isEmpty) {
      return _emptyState(
        icon: Icons.history,
        title: 'No past bookings',
        subtitle: 'Your completed visits will appear here',
      );
    }
    return _whiteContainer(
      child: ListView.separated(
        padding: const EdgeInsets.all(18),
        itemCount: list.length,
        separatorBuilder: (_, __) => _divider(),
        itemBuilder: (context, i) {
          final b = list[i];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookingCard(
                date: b.date,
                month: b.month,
                tag: b.tag,
                title: b.title,
                info: b.info,
                status: "Completed",
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _actionChip(
                    label: "Invoice",
                    icon: Icons.receipt_long_outlined,
                    onTap: () {},
                  ),
                  const SizedBox(width: 8),
                  _actionChip(
                    label: "Re-book",
                    isPrimary: true,
                    onTap: () {
                      Constants.booking_heading = b.tag;
                      showDialog(
                        context: context,
                        builder: (_) => const NewBookingFlow(),
                      );
                    },
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: const Row(
                      children: [
                        Icon(Icons.star_border, size: 16,
                            color: AppColors.primary),
                        SizedBox(width: 4),
                        Text("Rate", style: TextStyle(fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  // ========== 3. CANCELLED LIST ==========
  Widget _buildCancelledList(List<Booking> list) {
    if (list.isEmpty) {
      return _emptyState(
        icon: Icons.cancel_outlined,
        title: 'No cancelled bookings',
        subtitle: 'You have not cancelled any booking',
      );
    }
    return _whiteContainer(
      child: ListView.separated(
        padding: const EdgeInsets.all(18),
        itemCount: list.length,
        separatorBuilder: (_, __) => _divider(),
        itemBuilder: (context, i) {
          final b = list[i];
          return Opacity(
            opacity: 0.65,
            child: BookingCard(
              date: b.date,
              month: b.month,
              tag: b.tag,
              title: b.title,
              info: b.info,
              status: "Cancelled",
            ),
          );
        },
      ),
    );
  }

  // ========== COMMON UI HELPERS ==========
  Widget _whiteContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }

  Widget _divider() =>
      const Divider(height: 32, thickness: 1, color: Color(0xFFEEF4F1));

  Widget _emptyState(
      {required IconData icon, required String title, required String subtitle}) {
    return _whiteContainer(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 44, color: AppColors.textLight),
              const SizedBox(height: 12),
              Text(title, style: const TextStyle(fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textGrey)),
              const SizedBox(height: 4),
              Text(subtitle, textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textLight)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionChip(
      {required String label, IconData? icon, bool isPrimary = false, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: isPrimary ? AppColors.primary : AppColors.border),
        ),
        child: Row(
          children: [
            if (icon != null) Icon(icon, size: 14,
                color: isPrimary ? Colors.white : AppColors.textGrey),
            if (icon != null) const SizedBox(width: 4),
            Text(label, style: TextStyle(fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isPrimary ? Colors.white : AppColors.textDark)),
          ],
        ),
      ),
    );
  }

}