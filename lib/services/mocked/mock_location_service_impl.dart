import 'dart:async';
import 'package:t4g_weather/models/weather_model.dart';
import 'package:t4g_weather/services/location_service.dart';

class MockLocationService implements LocationService {
  final permission;

  MockLocationService() : permission = null;

  Future<bool> isLocationAvailable() async {
    return true;
  }

  Future<Coord> getLastKnownLocation() async {
    return Coord(43.6, -79.3);
  }

  Future<bool> getLocationPermission() async {
    return true;
  }
}
