import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:t4g_weather/constants/weather_icons_map.dart';
import 'package:t4g_weather/models/weather_model.dart';
import 'package:t4g_weather/providers/weather_provider.dart';
import 'package:t4g_weather/utils/converters.dart';

class WeatherTile extends StatelessWidget {
  final MapEntry<String, Coord> weatherId;
  final int tileIndex;

  WeatherTile({this.weatherId, this.tileIndex});

  @override
  Widget build(BuildContext context) {
    final bloc = WeatherProvider.of(context);
    return StreamBuilder<Map<String, Future<WeatherModel>>>(
      stream: bloc.weatherItems,
      builder:
          (context, AsyncSnapshot<Map<String, Future<WeatherModel>>> snapshot) {
        if (snapshot.hasError) {
          return tileIndex == 0 ? _buildErrorTile(snapshot.error) : Container();
        }
        if (!snapshot.hasData) {
          return _buildLoadingTile();
        }
        return FutureBuilder(
            future: snapshot.data[weatherId.key],
            builder: (context, AsyncSnapshot<WeatherModel> itemSnapshot) {
              if (itemSnapshot.hasError) {
                return tileIndex == 0
                    ? _buildErrorTile(itemSnapshot.error)
                    : Container();
              }
              if (!itemSnapshot.hasData) {
                return _buildLoadingTile();
              }
              return _buildWeatherCard(context, itemSnapshot.data);
            });
      },
    );
  }

  Widget _buildErrorTile(error) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(
          Icons.error,
          color: Colors.redAccent,
        ),
        title: Text('Oops! There was an error...'),
        subtitle: Text('$error'),
      ),
    );
  }

  Widget _buildLoadingTile() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: ListTile(
        title: Container(
          color: Colors.grey[200],
          height: 20.0,
          width: 100.0,
          margin: EdgeInsets.only(
            top: 5.0,
            bottom: 5.0,
          ),
        ),
        subtitle: Container(
          color: Colors.grey[200],
          height: 15.0,
          width: 75.0,
          margin: EdgeInsets.only(
            top: 5.0,
            bottom: 5.0,
          ),
        ),
        leading: Container(
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
        ),
        trailing: Column(
          children: <Widget>[
            Container(
              height: 30.0,
              width: 30.0,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
            ),
            Container(
              color: Colors.grey[200],
              height: 15.0,
              width: 30.0,
              margin: EdgeInsets.only(
                top: 2.0,
                bottom: 2.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherCard(BuildContext context, WeatherModel weatherInfo) {
    final bloc = WeatherProvider.of(context);
    String dn = weatherInfo.weather.first.icon.contains('d') ? 'day' : 'night';
    String iconName = iconMap['owm-$dn-${weatherInfo.weather.first.id}'];
    bloc.tempFormat();
    return Container(
      padding: EdgeInsets.all(8.0),
      child: ListTile(
        title: weatherId.key == 'current'
            ? Text('${weatherInfo.name.toUpperCase()}')
            : Text('${weatherId.key.toUpperCase()}'),
        subtitle:
            Text('${weatherInfo.weather.first.description.toUpperCase()}'),
        leading: Container(
          padding: EdgeInsets.all(4.0),
          child: SizedBox(
            height: 50.0,
            width: 50.0,
            child: SvgPicture.asset(
              'assets/svg/wi-$iconName.svg',
              color: Colors.blueAccent,
            ),
          ),
        ),
        trailing: StreamBuilder(
          stream: bloc.isCelsius,
          builder: (BuildContext contex, AsyncSnapshot<bool> snapshot) {
            int temp, min, max;
            //This probably can be changed to a better approach using higher operators
            if (!snapshot.hasData || snapshot.data) {
              temp = kelvinToCelsius(weatherInfo.main.temp);
              min = kelvinToCelsius(weatherInfo.main.tempMin);
              max = kelvinToCelsius(weatherInfo.main.tempMax);
            } else {
              temp = kelvinToFahrenheit(weatherInfo.main.temp);
              min = kelvinToFahrenheit(weatherInfo.main.tempMin);
              max = kelvinToFahrenheit(weatherInfo.main.tempMax);
            }
            return Column(
              children: <Widget>[
                Text(
                  '$temp°',
                  style: TextStyle(fontSize: 30.0),
                ),
                Text('min: $min° max: $max°'),
              ],
            );
          },
        ),
      ),
    );
  }
}
