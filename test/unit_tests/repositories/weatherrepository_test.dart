import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:t4g_weather/models/weathermodel.dart';
import 'package:t4g_weather/repositories/weatherrepository.dart';

import '../consts.dart';

void main() {
  group(
    'WeatherRepository Tests',
    () {
      final _weatherRepository = MockWeatherRepository();
      final torontoCoord = Coord(43.6, -79.3);
      test(
        'fetchWeatherForLocation() - Case: Success',
        () async {
          when(
            _weatherRepository.fetchWeatherForLocation(
              't4g toronto',
              torontoCoord,
            ),
          ).thenAnswer(
            (_) {
              final response = WeatherModel.fromJson(json.decode(jsonResponse));
              return Future.value(response);
            },
          );
          final weatherInfo = await _weatherRepository.fetchWeatherForLocation(
              't4g toronto', torontoCoord);
          expect(weatherInfo, isNotNull);
        },
      );

      test(
        'fetchWeatherForLocation() - Case: Fail',
        () async {
          when(
            _weatherRepository.fetchWeatherForLocation(
              't4g toronto',
              torontoCoord,
            ),
          ).thenAnswer(
            (_) {
              WeatherModel nullWeather = null;
              return Future.value(nullWeather);
            },
          );
          final weatherInfo = await _weatherRepository.fetchWeatherForLocation(
              't4g toronto', torontoCoord);
          expect(weatherInfo, isNull);
        },
      );
    },
  );
}

class MockWeatherRepository extends Mock implements WeatherRepository {}
