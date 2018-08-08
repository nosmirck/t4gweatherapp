import 'dart:async';

import 'package:http/http.dart' show Client;
import 'package:t4g_weather/models/weather_model.dart';

abstract class WeatherApi {
  final Client client;
  final String url;

  WeatherApi(this.client, this.url);
  Future<WeatherModel> fetchWeatherForLocation(Coord location);
}
