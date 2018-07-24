import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t4g_weather/blocs/weather_bloc.dart';
import 'package:t4g_weather/client/mocked/mock_weather_api_impl.dart';
import 'package:t4g_weather/client/weather_api.dart';
import 'package:t4g_weather/constants/responses.dart';
import 'package:t4g_weather/service_locator.dart';
import 'package:t4g_weather/services/location_service.dart';
import 'package:t4g_weather/services/mocked/mock_location_service_impl.dart';

void main() {
  final _mockSharedPrefs = MockSharedPreferences();
  setUpAll(
    () {
      ServiceLocator.reset();
      when(_mockSharedPrefs.getBool(typed(any))).thenReturn(true);
      when(_mockSharedPrefs.setBool(typed(any), typed(any)))
          .thenAnswer((_) => Future<bool>.value(true));
      ServiceLocator.registerSingleton<SharedPreferences>(_mockSharedPrefs);
      ServiceLocator.registerSingleton<LocationService>(MockLocationService());
      ServiceLocator.registerSingleton<WeatherApi>(
        MockWeatherApi(
          MockClient(
            (request) async => await Response(weatherJsonResponse, 200),
          ),
          "",
        ),
      );
    },
  );
  group(
    'WeatherBloc Tests',
    () {
      test(
        'fetchT4GWeatherLocations() - Case: Success',
        () async {
          final _bloc = WeatherBloc();
          _bloc.fetchT4GWeatherLocations();

          //Tests for Stream are complicated
          //TODO: learn how to test streams and complete test for Bloc
          _bloc.t4gWeatherLocations.listen(
            expectAsync1(
              (locations) {
                expect(locations, isNotNull);
              },
              count: 1,
            ),
          );
        },
      );
    },
  );
}

class MockSharedPreferences extends Mock implements SharedPreferences {}
