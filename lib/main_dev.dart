import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t4g_weather/app.dart';
import 'package:t4g_weather/app_config.dart';
import 'package:t4g_weather/client/mocked/mock_weather_api_impl.dart';
import 'package:t4g_weather/client/weather_api.dart';
import 'package:t4g_weather/constants/responses.dart';
import 'package:t4g_weather/service_locator.dart';
import 'package:t4g_weather/services/location_service.dart';
import 'package:t4g_weather/services/mocked/mock_location_service_impl.dart';

main() async {
  await registerDependencies();
  runApp(
    AppConfig(
      environment: Environment.development,
      child: App(),
    ),
  );
}

registerDependencies() async {
  ServiceLocator.reset();
  final _mockSharedPrefs = MockSharedPreferences();

  when(_mockSharedPrefs.getBool(typed(any))).thenReturn(true);
  when(_mockSharedPrefs.setBool(typed(any), typed(any)))
      .thenAnswer((_) => Future.value(true));

  ServiceLocator.registerSingleton<SharedPreferences>(_mockSharedPrefs);
  ServiceLocator.registerSingleton<WeatherApi>(
    MockWeatherApi(
      MockClient(
        (request) async => await Response(weatherJsonResponse, 200),
      ),
      "",
    ),
  );

  ServiceLocator.registerSingleton<LocationService>(MockLocationService());
}

class MockSharedPreferences extends Mock implements SharedPreferences {}
