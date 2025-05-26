import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/weather_api_service.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherApiService _weatherApiService = WeatherApiService();
  WeatherForecastResponse? _weatherForecastResponse;
  WeatherState _weatherState = WeatherState.initial;
  String _errorMessage = "";

  // Getters to access private fields
  WeatherForecastResponse? get weatherForecastResponse =>
      _weatherForecastResponse;

  WeatherState get weatherState => _weatherState;

  String get errorMessage => _errorMessage;

  // Method to access data from API
  Future<void> getWeatherData(String city) async {
    if (city.isEmpty) {
      _weatherState = WeatherState.error;
      _errorMessage = "City must be provided";
      notifyListeners();
      return;
    }

    _weatherState = WeatherState.loading;
    _weatherForecastResponse = null;
    _errorMessage = "";
    notifyListeners();

    try {
      _weatherForecastResponse = await _weatherApiService.fetchWeatherData(
        city: city,
      );
      _weatherState = WeatherState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _weatherState = WeatherState.error;
    } finally {
      notifyListeners();
    }
  }

  // Method to reset all
  void resetState() {
    _weatherForecastResponse = null;
    _weatherState = WeatherState.initial;
    _errorMessage = "";
    notifyListeners();
  }
}

enum WeatherState { initial, loading, loaded, error }
