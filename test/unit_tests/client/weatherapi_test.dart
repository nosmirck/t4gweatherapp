import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:t4g_weather/client/mocked/mock_weather_api_impl.dart';
import 'package:t4g_weather/constants/responses.dart';
import 'package:t4g_weather/models/weather_model.dart';

void main() {
  group(
    'WeatherApi Tests',
    () {
      final torontoCoord = Coord(43.6, -79.3);

      test(
        'fetchWeatherForLocation() - Case: Success',
        () async {
          final _weatherApi = MockWeatherApi(
            MockClient(
              (request) async => Response(weatherJsonResponse, 200),
            ),
            "",
          );

          final weatherInfo =
              await _weatherApi.fetchWeatherForLocation(torontoCoord);
          expect(weatherInfo, isNotNull);
        },
      );

      test(
        'fetchWeatherForLocation() - Case: Fail',
        () async {
          final _weatherApi = MockWeatherApi(
            MockClient(
              (request) async => Response(weatherJsonResponse, 404,
                  reasonPhrase: 'Not Found.'),
            ),
            "",
          );

          final weatherInfo = _weatherApi.fetchWeatherForLocation(torontoCoord);
          expect(weatherInfo, throwsException);
        },
      );
    },
  );
}
