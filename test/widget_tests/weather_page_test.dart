// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:t4g_weather/app.dart';
import 'package:t4g_weather/main_dev.dart';
import 'package:t4g_weather/utils/converters.dart';
import 'package:t4g_weather/widgets/weather_tile.dart';

//TODO: Add tests.
void main() {
  setUpAll(
    () async {
      await registerDependencies();
    },
  );
  group(
    'Weather Page Tests - Widgets',
    () {
      final tempInKelvin = 297.45;
      final tempInCelsius = kelvinToCelsius(tempInKelvin);
      final tempInFahrenheit = kelvinToFahrenheit(tempInKelvin);
      testWidgets(
        'Changes from Celsius to Fahrenheit and vicerversa',
        (WidgetTester tester) async {
          // Build our app and trigger a frame.
          await registerDependencies();
          await tester.pumpWidget(new App());
          // Waits at elast 5 seconds for the UI to finish Loading
          await tester.pumpAndSettle(Duration(seconds: 5));
          // Expect to all elements of the AppBar
          expect(find.text('T4G Weather'), findsOneWidget);
          expect(find.byKey(Key('TemperatureIcon')), findsOneWidget);
          expect(find.byKey(Key('GpsIcon')), findsOneWidget);
          // Expect to show at least one WeaterTile
          expect(find.byType(WeatherTile), findsWidgets);
          // Expect Temperature in Celsius
          expect(find.text('$tempInCelsius°'), findsWidgets);
          // Tap Temperature Icon and expect to change the temperature to Fahrenheit
          await tester.tap(find.byKey(Key('TemperatureIcon')));
          await tester.pump();

          expect(find.text('$tempInFahrenheit°'), findsWidgets);
          // Tap Temperature Icon again and expect to change the temperature to Celsius
          await tester.tap(find.byKey(Key('TemperatureIcon')));
          await tester.pump();
          expect(find.text('$tempInCelsius°'), findsWidgets);
        },
      );

      testWidgets(
        'App Loads and shows mocked Data',
        (WidgetTester tester) async {
          // Build our app and trigger a frame.
          await registerDependencies();
          await tester.pumpWidget(new App());
          // Waits at elast 5 seconds for the UI to finish Loading
          await tester.pumpAndSettle(Duration(seconds: 5));
          // Expect to all elements of the AppBar
          expect(find.text('T4G Weather'), findsOneWidget);
          expect(find.byKey(Key('TemperatureIcon')), findsOneWidget);
          expect(find.byKey(Key('GpsIcon')), findsOneWidget);

          // Expect to show at least one WeaterTile
          expect(find.byType(WeatherTile), findsWidgets);
        },
      );
    },
  );
}
