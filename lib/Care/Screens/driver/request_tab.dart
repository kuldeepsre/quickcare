import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestsDashboardScreen extends StatelessWidget {
  const RequestsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Welcome & Status Banner
              const Text(
                "DRIVER PORTAL",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF007A55),
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Request",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Manage requests for your driver workspace",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 16),

              // Online Status & Action Banner
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0FDF4).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(100), // Makes the ends fully curved

                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.circle, color: Colors.green, size: 10),
                        SizedBox(width: 8),
                        Text(
                          "Online · Accepting trips",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF166534),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF007A55),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "View live requests",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),


              const SizedBox(height: 16),

              // Requests List Container
              _buildRequestsContainer(),
              const SizedBox(height: 16),

              // Profile Readiness Card
              _buildProfileReadinessCard(),
              const SizedBox(height: 16),

              // Partner Support Banner
              _buildPartnerSupportCard(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildRequestsContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE6ECE9)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Requests',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF102A21),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Manage requests for your driver workspace',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Color(0xFF667871),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF0B4F38),
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'View all',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const _RequestItemCard(
            number: '01',
            title: 'Emergency pickup',
            route: '100 Feet Road, Indiranagar',
            distanceTime: '1.2 km away · 3 min',
            badgeText: 'Critical',
            badgeBgColor: Color(0xFFFEECEB),
            badgeTextColor: Color(0xFFB42318),
            numberBgColor: Color(0xFFFEECEB),
            numberTextColor: Color(0xFFB42318),
          ),
          const Divider(height: 32, color: Color(0xFFEDF2F0)),
          const _RequestItemCard(
            number: '02',
            title: 'Hospital transfer',
            route: 'Manipal Hospital → CityCare',
            distanceTime: '4.8 km away · 12 min',
            badgeText: 'Scheduled',
            badgeBgColor: Color(0xFFEBF3FE),
            badgeTextColor: Color(0xFF1D4ED8),
            numberBgColor: Color(0xFFF0F5F9),
            numberTextColor: Color(0xFF2B547E),
          ),
          const Divider(height: 32, color: Color(0xFFEDF2F0)),
          const _RequestItemCard(
            number: '03',
            title: 'Discharge pickup',
            route: 'St. Martha’s Hospital',
            distanceTime: '6.1 km away · 16 min',
            badgeText: 'Standard',
            badgeBgColor: Color(0xFFE8F5EF),
            badgeTextColor: Color(0xFF0B5D3F),
            numberBgColor: Color(0xFFEFF7F3),
            numberTextColor: Color(0xFF0B5D3F),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileReadinessCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE6ECE9)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            width: 84,
            height: 84,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 0.92,
                  strokeWidth: 7,
                  backgroundColor: const Color(0xFFE6ECE9),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF0B4F38),
                  ),
                  strokeCap: StrokeCap.round,
                ),
                const Center(
                  child: Text(
                    '92%',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF102A21),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Profile readiness',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF102A21),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Add your latest documents to stay verified.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF667871),
            ),
          ),
          const SizedBox(height: 18),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF102A21),
              side: const BorderSide(color: Color(0xFFD5DFDB)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              'Complete profile',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartnerSupportCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF084C35),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2.0),
                child: Icon(
                  Icons.verified_user_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'QuickCare partner support',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Priority support is available around the clock.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.white.withOpacity(0.06),
                side: BorderSide(color: Colors.white.withOpacity(0.25)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone_in_talk_outlined, size: 18),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RequestItemCard extends StatelessWidget {
  final String number;
  final String title;
  final String route;
  final String distanceTime;
  final String badgeText;
  final Color badgeBgColor;
  final Color badgeTextColor;
  final Color numberBgColor;
  final Color numberTextColor;

  const _RequestItemCard({
    required this.number,
    required this.title,
    required this.route,
    required this.distanceTime,
    required this.badgeText,
    required this.badgeBgColor,
    required this.badgeTextColor,
    required this.numberBgColor,
    required this.numberTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: numberBgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            number,
            style: TextStyle(
              color: numberTextColor,
              fontWeight: FontWeight.w700,
              fontSize: 13.5,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF102A21),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                route,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF5F716A),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 14,
                    color: Color(0xFF7B8B85),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    distanceTime,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF7B8B85),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeBgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    color: badgeTextColor,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF102A21),
                  side: const BorderSide(color: Color(0xFFD5DFDB)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 9,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Review',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}