import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/weather_db_service.dart';

class WeatherDbProvider extends ChangeNotifier {
  final WeatherDbService _weatherDbService = WeatherDbService();
  WeatherForecastResponse? _weatherForecastResponse;

  WeatherForecastResponse? get weatherForecastResponse =>
      _weatherForecastResponse;

  Future<void> getWeatherDataFromDb() async {
    String previousWeatherData = (await _weatherDbService.fetchDataFromDb())!;
    Map<String, dynamic> decodedJson = jsonDecode(previousWeatherData);
    _weatherForecastResponse = WeatherForecastResponse.fromMap(decodedJson);
    notifyListeners();
  }
}
