import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t4g_weather/app.dart';
import 'package:t4g_weather/app_config.dart';
import 'package:t4g_weather/client/implementations/weather_api_impl.dart';
import 'package:t4g_weather/client/weather_api.dart';
import 'package:t4g_weather/service_locator.dart';
import 'package:t4g_weather/services/implementations/location_service_impl.dart';
import 'package:t4g_weather/services/location_service.dart';

main() async {
  await registerDependencies();
  runApp(
    AppConfig(
      environment: Environment.production,
      child: App(),
    ),
  );
}

registerDependencies() async {
  ServiceLocator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  ServiceLocator.registerSingleton<LocationService>(LocationServiceImpl());
  ServiceLocator.registerSingleton<WeatherApi>(WeatherApiImpl());
}
