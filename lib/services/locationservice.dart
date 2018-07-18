import 'dart:async';
import 'package:geolocation/geolocation.dart';

class LocationService {
  LocationService() {
    Geolocation.loggingEnabled = false;
  }

  Future<bool> isLocationAvailable() async {
    try {
      final result = await Geolocation.isLocationOperational();
      return result.error != null ? false : result.isSuccessful;
    } on Exception catch (e) {
      //TODO: Send error to AppCenter
      print(e);
      return false;
    }
  }

  Future<Location> getLastKnownLocation() async {
    final currentLocation = await Geolocation.lastKnownLocation(
      permission: LocationPermission(
          android: LocationPermissionAndroid.fine,
          ios: LocationPermissionIOS.whenInUse),
    );

    return currentLocation.error != null ? null : currentLocation.location;
  }

  Future<bool> getLocationPermission() async {
    final loc = await Geolocation.lastKnownLocation(
      permission: LocationPermission(
          android: LocationPermissionAndroid.fine,
          ios: LocationPermissionIOS.whenInUse),
    );
    return loc.isSuccessful;
  }
}
