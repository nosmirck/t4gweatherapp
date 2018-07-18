import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../blocs/weatherbloc.dart';
import '../models/weathermodel.dart';
import '../providers/weatherprovider.dart';
import '../widgets/refreshwidget.dart';
import '../widgets/weathertile.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = WeatherProvider.of(context);
    bloc.fetchT4GWeatherLocations();
    return Scaffold(
      appBar: AppBar(
        title: Text('T4G Weather'),
        actions: <Widget>[
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: StreamBuilder(
                stream: bloc.isCelsius,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (!snapshot.hasData) {
                    return SvgPicture.asset(
                      'assets/svg/wi-celsius.svg',
                      color: Colors.white,
                      height: 50.0,
                      width: 50.0,
                    );
                  }
                  if (snapshot.data) {
                    return SvgPicture.asset(
                      'assets/svg/wi-celsius.svg',
                      color: Colors.white,
                      height: 50.0,
                      width: 50.0,
                    );
                  } else {
                    return SvgPicture.asset(
                      'assets/svg/wi-fahrenheit.svg',
                      color: Colors.white,
                      height: 50.0,
                      width: 50.0,
                    );
                  }
                },
              ),
            ),
            onTap: bloc.toggleCelsius
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: StreamBuilder(
                stream: bloc.locationTracker,
                builder: (context, AsyncSnapshot<bool> snapshot) {
                  if (!snapshot.hasData) {
                    return Icon(Icons.gps_off);
                  }
                  return snapshot.data
                      ? Icon(Icons.gps_fixed)
                      : Icon(Icons.gps_off);
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
