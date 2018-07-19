import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:t4g_weather/client/weatherapi.dart';
import 'package:t4g_weather/models/weathermodel.dart';

import '../consts.dart';

void main() {
  group(
    'WeatherApi Tests',
    () {
      final _weatherApi = WeatherApi();

      final torontoCoord = Coord(43.6, -79.3);

      test(
        'fetchWeatherForLocation() - Case: Success',
        () async {
          _weatherApi.client =
              MockClient((request) async => Response(jsonResponse, 200));
          final weatherInfo =
              await _weatherApi.fetchWeatherForLocation(torontoCoord);
          expect(weatherInfo, isNotNull);
        },
      );

      test(
        'fetchWeatherForLocation() - Case: Fail',
        () async {
          _weatherApi.client = MockClient((request) async =>
              Response(jsonResponse, 404, reasonPhrase: 'Not Found.'));
          final weatherInfo = _weatherApi.fetchWeatherForLocation(torontoCoord);
          expect(weatherInfo, throwsException);
        },
      );
    },
  );
}
