import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:t4g_weather/constants/t4glocationscoordinates.dart';
import 'package:t4g_weather/services/locationservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/weathermodel.dart';
import '../repositories/weatherrepository.dart';

class WeatherBloc {
  bool _isCelsius = true;

  WeatherRepository weatherRepository = WeatherRepository();
  LocationService locationService = LocationService();
  SharedPreferences sharedPrefs;

  final _locationTracker = PublishSubject<bool>();
  final _isCelsiusSubject = PublishSubject<bool>();
  final _weatherLocationIds = PublishSubject<Map<String, Coord>>();
  final _weatherItemsFetcher = PublishSubject<MapEntry<String, Coord>>();
  final _weatherItemsOutput =
      BehaviorSubject<Map<String, Future<WeatherModel>>>();

  WeatherBloc() {
    //Initialization of the User's preference for Temperature Meassure (C or F)
    SharedPreferences.getInstance().then(
      (instance) {
        sharedPrefs = instance;
        _isCelsius = sharedPrefs.getBool('isCelsius') ?? true;
        _isCelsiusSubject.sink.add(_isCelsius);
      },
    );
    _weatherItemsFetcher.stream
        .transform(_weatherItemsTransformer())
        .pipe(_weatherItemsOutput);
    locationService.isLocationAvailable().then(_locationTracker.sink.add);
  }
  WeatherBloc.forTest(
    this.sharedPrefs,
    this.locationService,
    this.weatherRepository,
  ) {
    _isCelsiusSubject.sink.add(true);
    _locationTracker.sink.add(false);
  }

  Function(MapEntry<String, Coord>) get fetchWeather =>
      _weatherItemsFetcher.sink.add;

  Observable<bool> get locationTracker => _locationTracker.stream;
  Observable<bool> get isCelsius => _isCelsiusSubject.stream;
  Observable<Map<String, Coord>> get t4gWeatherLocations =>
      _weatherLocationIds.stream;
  Observable<Map<String, Future<WeatherModel>>> get weatherItems =>
      _weatherItemsOutput.stream;

  //Toggles Location Tracking to display current user's location's weather
  Future toggleLocationTracking() async {
    var isAvailable = await locationService.isLocationAvailable();
    if (!isAvailable) {
      isAvailable = await locationService.getLocationPermission();
    }
    _locationTracker.sink.add(isAvailable);
    if (isAvailable) {
      fetchT4GWeatherLocations();
    }
  }

  //Toggles between C or F
  Future toggleCelsius() async {
    _isCelsius = !_isCelsius;
    //Whenever the Temperature Meassure is changed, we save to shared prefs
    await sharedPrefs.setBool('isCelsius', _isCelsius);
    _isCelsiusSubject.sink.add(_isCelsius);
  }

  //Refreshes the Temperature format (C or F) before building the Item (for first time load)
  Future<Null> tempFormat() async {
    await _isCelsiusSubject.sink.add(_isCelsius);
  }

  Future<Null> fetchT4GWeatherLocations() async {
    //TODO: Have a Locations Repository to fetch from the internet in case there are new locations
    var locations = new Map<String, Coord>();
    if (await locationService.isLocationAvailable()) {
      final loc = await locationService.getLastKnownLocation();
      if (loc != null) {
        locations['current'] = loc;
      }
    }
    locations.addAll(T4GLocationCoordinates);
    _weatherLocationIds.sink.add(locations);
  }

  _weatherItemsTransformer() {
    return ScanStreamTransformer(
      (Map<String, Future<WeatherModel>> cache,
          MapEntry<String, Coord> location, index) {
        cache[location.key] = weatherRepository.fetchWeatherForLocation(
            location.key, location.value);
        return cache;
      },
      <String, Future<WeatherModel>>{},
    );
  }

  dispose() {
    _weatherLocationIds.close();
    _weatherItemsFetcher.close();
    _weatherItemsOutput.close();
    _isCelsiusSubject.close();
    _locationTracker.close();
  }
}
