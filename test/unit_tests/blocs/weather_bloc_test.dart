import 'package:flutter_test/flutter_test.dart';
import 'package:t4g_weather/blocs/weather_bloc.dart';
import 'package:t4g_weather/main_dev.dart';

void main() {
  setUpAll(
    () async {
      await registerDependencies();
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
