
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:t4g_weather/app.dart';
import 'package:t4g_weather/app_config.dart';
import 'package:t4g_weather/main_dev.dart';

main() async {
  enableFlutterDriverExtension();
  await registerDependencies();
  runApp(
    AppConfig(
      environment: Environment.development,
      child: App(),
    ),
  );
}
