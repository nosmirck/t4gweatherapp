import 'dart:async';

import '../client/weatherapi.dart';
import '../models/weathermodel.dart';

class WeatherRepository {
  WeatherApi _apiProvider;

  WeatherRepository() {
    _apiProvider = new WeatherApi();
  }

  Future<WeatherModel> fetchWeatherForLocation(
      String locationId, Coord coords) async {
    //TODO: Check for connectivity first, if there's no connection We'll fetch from DB, otherwise, we'll attempt to get from API
    final weather = await _apiProvider.fetchWeatherForLocation(coords);

    _updateWeatherForLocation(locationId, coords, weather);

    return weather;
  }
  //TODO: Update WeatherModel on DB

  _updateWeatherForLocation(
      String location, Coord coords, WeatherModel weather) {
    //Call to DBProvider and update database
  }
}
