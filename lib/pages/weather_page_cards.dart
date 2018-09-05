import 'dart:async';

import 'package:flutter/material.dart';
import 'package:t4g_weather/blocs/weather_bloc.dart';
import 'package:t4g_weather/models/weather_model.dart';
import 'package:t4g_weather/providers/weather_provider.dart';
import 'package:t4g_weather/widgets/error_occurred_widget.dart';
import 'package:t4g_weather/widgets/weather_card_widget.dart';

class WeatherPageCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = WeatherProvider.of(context);
    bloc.fetchT4GWeatherLocations();
    bloc.tempFormat();
    return StreamBuilder(
      stream: bloc.t4gWeatherLocations,
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, Coord>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: ErrorOccurredWidget(errorMessage: snapshot.error.toString()),
          );
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final data = snapshot.data;
        return Stack(
          children: <Widget>[
            PageView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildWeatherCard(
                      context, index, bloc, data.entries.elementAt(index)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildWeatherCard(BuildContext context, int index, WeatherBloc bloc,
      MapEntry<String, Coord> itemData) {
    bloc.fetchWeather(itemData);

    return StreamBuilder(
      stream: bloc.weatherItems,
      builder: (BuildContext context,
          AsyncSnapshot<Map<String, Future<WeatherModel>>> snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return ErrorOccurredWidget(
            errorMessage: snapshot.error?.toString(),
          );
        }
        return Center(
          child: FutureBuilder<WeatherModel>(
            future: snapshot.data[itemData.key],
            initialData: null,
            builder: (BuildContext contex,
                AsyncSnapshot<WeatherModel> itemSnapshot) {
              if (itemSnapshot.hasError) {
                return ErrorOccurredWidget(
                  errorMessage: itemSnapshot.error?.toString(),
                );
              }
              if (!itemSnapshot.hasData || itemSnapshot.data == null) {
                return CircularProgressIndicator();
              }
              return WeatherCard(
                entryData: itemData,
                model: itemSnapshot.data,
              );
            },
          ),
        );
      },
    );
  }
}
