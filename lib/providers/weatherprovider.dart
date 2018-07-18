import 'package:flutter/material.dart';

import '../blocs/weatherbloc.dart';

export '../blocs/weatherbloc.dart';

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
