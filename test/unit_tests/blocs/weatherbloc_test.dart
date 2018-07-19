import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t4g_weather/blocs/weatherbloc.dart';

import '../repositories/weatherrepository_test.dart';
import '../services/locationservice_test.dart';

void main() {
  group(
    'WeatherBloc Tests',
    () {
      final _bloc = WeatherBloc.forTest(
        MockSharedPreferences(),
        MockLocationService(),
        MockWeatherRepository(),
      );

      test(
        'fetchT4GWeatherLocations() - Case: Success',
        () async {
          when(_bloc.sharedPrefs.getBool(typed(any)))
              .thenAnswer((_) => Future.value(true));
          when(_bloc.sharedPrefs.setBool(typed(any), typed(any)))
              .thenAnswer((_) => Future.value(true));
          when(_bloc.locationService.isLocationAvailable())
              .thenAnswer((_) => Future.value(false));
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
