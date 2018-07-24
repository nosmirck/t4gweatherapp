import 'package:flutter/material.dart';
import 'package:t4g_weather/blocs/weather_bloc.dart';

class WeatherProvider extends InheritedWidget {
  final WeatherBloc bloc;

  WeatherProvider({Key key, Widget child})
      : bloc = WeatherBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static WeatherBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(WeatherProvider)
            as WeatherProvider)
        .bloc;
  }
}
