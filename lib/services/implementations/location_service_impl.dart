import 'dart:async';

import 'package:geolocation/geolocation.dart';
import 'package:t4g_weather/models/weather_model.dart';
import 'package:t4g_weather/services/location_service.dart';

class LocationServiceImpl implements LocationService {
  final LocationPermission permission;

  LocationServiceImpl()
      : permission = LocationPermission(
            android: LocationPermissionAndroid.fine,
            ios: LocationPermissionIOS.whenInUse) {
    // Enable this during DEBUG
    //Geolocation.loggingEnabled = true;
  }

  Future<Coord> getLastKnownLocation() async {
    final currentLocation =
        await Geolocation.lastKnownLocation(permission: permission);

    return currentLocation.error != null
        ? null
        : Coord(currentLocation.location.latitude,
            currentLocation.location.longitude);
  }

  Future<bool> getLocationPermission() async {
    final loc = await Geolocation.lastKnownLocation(permission: permission);

    return loc.isSuccessful;
  }

  Future<bool> isLocationAvailable() async {
    final result =
        await Geolocation.isLocationOperational(permission: permission);

    return result.isSuccessful;
  }
}
