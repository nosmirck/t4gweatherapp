import 'dart:async';

import 'package:geolocation/geolocation.dart';
import 'package:t4g_weather/models/weather_model.dart';

abstract class LocationService {
  final LocationPermission permission;
  LocationService(this.permission);
  Future<Coord> getLastKnownLocation();
  Future<bool> getLocationPermission();
  Future<bool> isLocationAvailable();
}
