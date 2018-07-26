import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:t4g_weather/blocs/weather_bloc.dart';
import 'package:t4g_weather/models/weather_model.dart';
import 'package:t4g_weather/providers/localizationservice.dart';
import 'package:t4g_weather/providers/weather_provider.dart';
import 'package:t4g_weather/widgets/refresh_widget.dart';
import 'package:t4g_weather/widgets/weather_tile.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = WeatherProvider.of(context);
    bloc.fetchT4GWeatherLocations();
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationsProvider.of(context).title),
        actions: <Widget>[
          InkWell(
              key: Key('temp-scale-button'),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: StreamBuilder(
                  stream: bloc.isCelsius,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (!snapshot.hasData) {
                      return SvgPicture.asset(
                        'assets/svg/wi-thermometer.svg',
                        color: Colors.white,
                        height: 50.0,
                        width: 50.0,
                        key: Key('thermometer-icon'),
                      );
                    }
                    if (snapshot.data) {
                      return SvgPicture.asset(
                        'assets/svg/wi-celsius.svg',
                        color: Colors.white,
                        height: 50.0,
                        width: 50.0,
                        key: Key('celsius-icon'),
                      );
                    } else {
                      return SvgPicture.asset(
                        'assets/svg/wi-fahrenheit.svg',
                        color: Colors.white,
                        height: 50.0,
                        width: 50.0,
                        key: Key('fahrenheit-icon'),
                      );
                    }
                  },
                ),
              ),
              onTap: bloc.toggleCelsius),
          InkWell(
            key: Key('gps-track-button'),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: StreamBuilder(
                stream: bloc.locationTracker,
                builder: (context, AsyncSnapshot<bool> snapshot) {
                  if (!snapshot.hasData) {
                    return Icon(
                      Icons.gps_off,
                      key: Key('gps-off-icon'),
                    );
                  }
                  return snapshot.data
                      ? Icon(
                          Icons.gps_fixed,
                          key: Key('gps-fixed-icon'),
                        )
                      : Icon(
                          Icons.gps_off,
                          key: Key('gps-off-icon'),
                        );
                },
              ),
            ),
            onTap: bloc.toggleLocationTracking,
          ),
        ],
        elevation: 0.0,
      ),
      body: buildWeatherList(bloc),
    );
  }

  Widget buildWeatherList(WeatherBloc bloc) {
    return StreamBuilder(
      stream: bloc.t4gWeatherLocations,
      builder: (context, AsyncSnapshot<Map<String, Coord>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Refresh(
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, int index) {
              bloc.fetchWeather(snapshot.data.entries.elementAt(index));
              return WeatherTile(
                weatherId: snapshot.data.entries.elementAt(index),
                tileIndex: index,
              );
            },
          ),
        );
      },
    );
  }
}
