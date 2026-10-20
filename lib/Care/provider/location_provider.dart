import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class LocationProvider extends ChangeNotifier {
  LatLng _position = const LatLng(12.9784, 77.6408);
  String _address = '42, 12th Main Road, Indiranagar';
  bool _isLoading = false;
  List<Map<String, dynamic>> _searchResults = [];
  LatLng get position => _position;
  String get address => _address;
  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get searchResults => _searchResults;
  // FREE OSM SEARCH - No API key needed
  Future<void> searchPlaces(String query) async {
    if (query.trim().length < 2) {
      _searchResults = [];
      notifyListeners();
      return;
    }
    final url = Uri.parse('https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=5&countrycodes=in');
    try {
      final res = await http.get(url, headers: {'User-Agent': 'ElderCareApp'});
      debugPrint('SEARCH RESPONSE: ${res.body}');
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
      } else {
        _searchResults = [];
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Search error: $e');
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
  Future<void> updateAddressFromLatLng(LatLng pos) async {
    _position = pos;
    _isLoading = true;
    notifyListeners();
    try {
      final placemarks = await placemarkFromCoordinates(pos.latitude, pos.longitude);
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final parts = [p.street, p.subLocality, p.locality, p.administrativeArea].where((e) => e != null && e!.trim().isNotEmpty).toList();
        _address = parts.join(', ');
        if (_address.isEmpty) _address = p.name ?? 'Unknown';
      }
    } catch (_) {}
    _isLoading = false;
    notifyListeners();
  }
  void clearSearch() {
    _searchResults = [];
    notifyListeners();
  }
}