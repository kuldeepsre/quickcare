import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:patientapp/Care/provider/location_provider.dart';
import 'package:patientapp/utils/AppColors.dart';
import 'package:provider/provider.dart';

// ================= MAP WIDGET - FIXED MARKER MOVE =================

class RealMapPicker extends StatefulWidget {
  const RealMapPicker({super.key});
  @override
  State<RealMapPicker> createState() => _RealMapPickerState();
}
class _RealMapPickerState extends State<RealMapPicker> {
  late LatLng _tempPos;
  GoogleMapController? _mapController;
  LatLng? _lastPosition;
  @override
  void initState() {
    super.initState();
    // safe init - don't use context.read in initState with listen
    final pos = context.read<LocationProvider>().position;
    _tempPos = pos;
    _lastPosition = pos;
  }
  @override
  Widget build(BuildContext context) {
    // If still on windows target (without main.dart fix), show fallback
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.windows) {
      return Container(
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: const Center(child: Text("Map not supported on Windows desktop, use Chrome")),
      );
    }
    return Consumer<LocationProvider>(
      builder: (context, locProvider, _) {
        if (_lastPosition != locProvider.position) {
          _lastPosition = locProvider.position;
          _tempPos = locProvider.position;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _mapController?.animateCamera(
              CameraUpdate.newLatLngZoom(locProvider.position, 16),
            );
          });
        }
        return Container(
          height: 160,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: locProvider.position,
                  zoom: 16,
                ),
                onMapCreated: (controller) => _mapController = controller,
                onCameraMove: (pos) => _tempPos = pos.target,
                onCameraIdle: () {
                  if (!locProvider.isLoading) {
                    context.read<LocationProvider>().updateAddressFromLatLng(_tempPos);
                  }
                },
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                myLocationEnabled: false,
                mapToolbarEnabled: false,
                // Important for web
                webGestureHandling: kIsWeb ? WebGestureHandling.auto : WebGestureHandling.none,
              ),
              const IgnorePointer(
                child: Center(
                  child: Icon(Icons.location_on, color: Color(0xFFC4453C), size: 38),
                ),
              ),
              if (locProvider.isLoading)
                const Positioned(
                  top: 8,
                  right: 8,
                  child: SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}