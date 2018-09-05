import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:t4g_weather/pages/weather_page_cards.dart';
import 'package:t4g_weather/providers/localizationservice.dart';

import 'providers/weather_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) =>
          LocalizationsProvider.of(context).title,
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('fr', ''),
      ],
      home: WeatherProvider(
        child: WeatherPageCards(),
      ),
    );
  }
}
