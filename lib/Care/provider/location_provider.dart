import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier {
  LatLng _position = const LatLng(28.6139, 77.2090);
  String _address = 'Fetching address...';
  bool _isLoading = false;
  List<Map<String, dynamic>> _searchResults = [];

  LatLng get position => _position;
  String get address => _address;
  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get searchResults => _searchResults;

  Future<void> getCurrentLocation() async {
    _isLoading = true;
    notifyListeners();
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _address = 'Location services disabled';
        _isLoading = false;
        notifyListeners();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _address = 'Permission denied';
          _isLoading = false;
          notifyListeners();
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        _address = 'Permission permanently denied';
        _isLoading = false;
        notifyListeners();
        return;
      }

      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      await updateAddressFromLatLng(LatLng(pos.latitude, pos.longitude));
    } catch (e) {
      debugPrint('getCurrentLocation error: $e');
      _address = 'Unable to get location';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchPlaces(String query) async {
    if (query.trim().length < 2) {
      _searchResults = [];
      notifyListeners();
      return;
    }
    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=5&countrycodes=in');
    try {
      final res = await http.get(url, headers: {'User-Agent': 'ElderCareApp'});
      if (res.statusCode == 200) {
        final List data = json.decode(res.body);
        _searchResults = data.map((e) {
          return {
            'place_id': e['place_id'].toString(),
            'lat': e['lat'],
            'lon': e['lon'],
            'description': e['display_name'],
            'structured_formatting': {
              'main_text': e['name'] ?? e['display_name'].split(',')[0],
              'secondary_text': e['display_name'],
            }
          };
        }).toList();
      }
      notifyListeners();
    } catch (e) {
      _searchResults = [];
      notifyListeners();
    }
  }

  Future<void> selectPlace(Map<String, dynamic> place) async {
    _position = LatLng(double.parse(place['lat']), double.parse(place['lon']));
    _address = place['description'];
    _searchResults = [];
    notifyListeners();
  }

  // FIXED FOR WEB + MOBILE - ONLY ADDRESS
  Future<void> updateAddressFromLatLng(LatLng pos) async {
    _position = pos;
    _isLoading = true;
    notifyListeners();

    try {
      if (kIsWeb) {
        // WEB: Use OSM Reverse Geocoding (geocoding package doesn't work on web)
        final url = Uri.parse(
            'https://nominatim.openstreetmap.org/reverse?lat=${pos.latitude}&lon=${pos.longitude}&format=json');
        final res = await http.get(url, headers: {'User-Agent': 'ElderCareApp'});
        if (res.statusCode == 200) {
          final data = json.decode(res.body);
          _address = data['display_name'] ?? 'Unknown location';
        } else {
          _address = 'Unable to fetch address';
        }
      } else {
        // MOBILE: Use geocoding package
        final placemarks = await placemarkFromCoordinates(pos.latitude, pos.longitude);
        if (placemarks.isNotEmpty) {
          final p = placemarks.first;
          final parts = [
            p.street,
            p.subLocality,
            p.locality,
            p.administrativeArea,
            p.postalCode,
          ].where((e) => e != null && e!.trim().isNotEmpty).toSet().toList();
          _address = parts.join(', ');
          if (_address.isEmpty) _address = p.name ?? 'Unknown location';
        }
      }
    } catch (e) {
      debugPrint('Reverse geocode error: $e');
      _address = 'Unable to fetch address';
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearSearch() {
    _searchResults = [];
    notifyListeners();
  }
}