import 'dart:async';

import 'package:t4g_weather/client/weather_api.dart';
import 'package:t4g_weather/models/weather_model.dart';
import 'package:t4g_weather/service_locator.dart';

class WeatherRepository {
  final WeatherApi _api;

  WeatherRepository() : _api = ServiceLocator.get<WeatherApi>();

  Future<WeatherModel> fetchWeatherForLocation(
      String locationId, Coord coords) async {
    //TODO: Check for connectivity first, if there's no connection We'll fetch from DB, otherwise, we'll attempt to get from API
    final weather = await _api.fetchWeatherForLocation(coords);

    _updateWeatherForLocation(locationId, coords, weather);

    return weather;
  }
  //TODO: Update WeatherModel on DB

  _updateWeatherForLocation(
      String location, Coord coords, WeatherModel weather) {
    //Call to DBProvider and update database
  }
}
