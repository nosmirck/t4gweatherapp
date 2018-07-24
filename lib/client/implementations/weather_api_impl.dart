import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:t4g_weather/client/weather_api.dart';
import 'package:t4g_weather/constants/apikey.dart';
import 'package:t4g_weather/models/weather_model.dart';
import 'package:t4g_weather/providers/localizationservice.dart'
    show LocalizationService;


class WeatherApiImpl implements WeatherApi {
  final Client client;
  final String _url;

  WeatherApiImpl()
      : client = Client(),
        _url = 'https://api.openweathermap.org/data/2.5/weather?';

  Future<WeatherModel> fetchWeatherForLocation(Coord location) async {
    if (location == null) {
      throw Exception(
          "Error on Location provided. Check that <param>location</param> is not null");
    }
    final lang = LocalizationService.locale?.languageCode ?? 'en';
    final response = await client.get(_url +
        'lat=${location.lat}&lon=${location.lon}&appid=${API_KEY}&lang=$lang');

    if (response.statusCode == 200 && response.body != null) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      final exceptionMessage =
          "Statuscode: ${response.statusCode} StatusReason: ${response.reasonPhrase} Request= Coord: (${location.lat}, ${location.lon}) Language: $lang.";
      throw Exception(exceptionMessage);
    }
  }
}
