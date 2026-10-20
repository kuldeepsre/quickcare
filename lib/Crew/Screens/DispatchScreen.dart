import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as AppStrings;
import 'package:patientapp/Care/provider/LanguageProvider.dart';
import 'package:patientapp/Care/widget/dispach_card.dart';
import 'package:patientapp/Care/widget/vitals_card_exact.dart';
import 'package:patientapp/utils/AppColors.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';



import 'package:flutter/material.dart';

class DispatchScreen extends StatefulWidget {
  const DispatchScreen({super.key});

  @override
  State<DispatchScreen> createState() => _ExactDispatchScreenState();
}

class _ExactDispatchScreenState extends State<DispatchScreen> {


  @override
  Widget build(BuildContext context) {
    final langProvider=context.watch<LanguageProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F6),
      body: SafeArea(
        child: Column(
          children: [

            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                   Text(langProvider.translate('Ambulancecrewdispatch'), style: TextStyle(fontSize: 12, color:AppColors.primaryGreen,fontWeight: FontWeight.normal)),
                  const SizedBox(width: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(langProvider.translate('Dispatch'), style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800)),
                      Spacer(),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.8), // 50% opacity
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            langProvider.translate('onDuty'),
                            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    DispatchCard(),
                    _whiteCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Route preview', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(20)),
                            child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.navigation, size: 12, color: Color(0xFF2E7D32)), SizedBox(width: 4), Text('3 mins to pickup', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF2E7D32)))]),
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(height: 96, color: const Color(0xFFEFEFEF), child: Stack(children: [CustomPaint(size: const Size(double.infinity, 96), painter: _RoadPainter()), Positioned(left: 22, top: 22, child: Container(width: 32, height: 32, decoration: BoxDecoration(color: const Color(0xFFC8E6C9).withOpacity(0.8), shape: BoxShape.circle))), const Positioned(right: 34, top: 22, child: Icon(Icons.location_on, color: Color(0xFFD32F2F), size: 18)), const Positioned(bottom: 6, left: 0, right: 0, child: Center(child: Text('A', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black38))))])),
                          ),
                        ],
                      ),
                    ),
                    VitalsReadinessCard(),
                    _whiteCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(langProvider.translate('Recenttrips'), style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 12),
                          _tripTile('Delhi to Hospital via Rajal Nagar', 'Today, 08:12', 'Completed'),
                          _tripTile('Delhi to AIIMS Medical College', 'Today, 06:42', 'Completed'),
                          _tripTile('Faridabad to City Hospital', 'Yesterday, 22:30', 'Completed'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }

  static Widget _whiteCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
      child: child,
    );
  }


  static Widget _tripTile(String route, String time, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade200), borderRadius: BorderRadius.circular(8)),
      child: Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(route, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)), Text(time, style: TextStyle(fontSize: 9, color: Colors.grey.shade500))])), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(12)), child: Text(status, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: Color(0xFF2E7D32))))]),
    );
  }
}

class _RoadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final road = Paint()..color = Colors.white..strokeWidth = 16..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    final border = Paint()..color = const Color(0xFFE0E0E0)..strokeWidth = 18..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    final path = Path()..moveTo(size.width * 0.15, size.height * 0.5)..lineTo(size.width * 0.70, size.height * 0.45)..lineTo(size.width * 0.85, size.height * 0.28);
    canvas.drawPath(path, border);
    canvas.drawPath(path, road);
    final vPath = Path()..moveTo(size.width * 0.38, size.height * 0.15)..lineTo(size.width * 0.42, size.height * 0.85);
    canvas.drawPath(vPath, border);
    canvas.drawPath(vPath, road);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}