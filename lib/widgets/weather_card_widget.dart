import 'package:flutter/material.dart';
import 'package:t4g_weather/constants/t4g_locations_coordinates.dart';
import 'package:t4g_weather/constants/weather_icons_map.dart';
import 'package:t4g_weather/models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel model;
  final MapEntry<String, Coord> entryData;
  final double parallaxPercent;

  WeatherCard({
    this.entryData,
    this.model,
    this.parallaxPercent = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    String dn = model.weather.first.icon.contains('d') ? 'd' : 'n';
    String dtime = dn == 'd' ? 'day' : 'night';
    String iconName = iconMap['owm-$dtime-${model.weather.first.id}'];
    String imageName = '${t4GLocationImageName[entryData.key]}-$dn.jpg';

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text('${model.name}')
          ],
        ),
      ),
    );
  }
}
