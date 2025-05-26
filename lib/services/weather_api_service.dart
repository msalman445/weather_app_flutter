import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:weather_app/models/weather.dart';

class WeatherApiService {
  static const String _baseUrl = "api.openweathermap.org";
  final String _apiUrl = "/data/2.5/forecast";
  static final String _apiKey = dotenv.env["OpenWeather_API_Key"]!;
  final String _defaultUnits = "metric";

  /// Builds the complete API request URL
  Uri _buildUri({required String city, String? units}) {
    return Uri.https(_baseUrl, _apiUrl, {
      "q": city,
      "appid": _apiKey,
      "units": units,
      // to get temperature in Celsius
    });
  }

  /// Fetch weather data from OpenWeatherMap API
  Future<WeatherForecastResponse> fetchWeatherData({
    required String city,
    String? units,
  }) async {
    final selectedUnits = units ?? _defaultUnits;
    final uri = _buildUri(city: city, units: selectedUnits);
    try {
      final response = await get(uri);

      if (response.isSuccessful) {
        final Map<String, dynamic> decodedJson = jsonDecode(response.body);
        return WeatherForecastResponse.fromMap(decodedJson);
      } else if (response.statusCode == 404) {
        throw Exception("City Not Found");
      } else if (response.statusCode == 401) {
        throw Exception("Invalid API Key");
      } else {
        throw Exception("Failed to load weather data: ${response.statusCode}");
      }
    } catch (e) {
      if (e is Exception && e.toString().contains('Failed host lookup')) {
        throw Exception(
          'Network error: Please check your internet connection.',
        );
      }
      rethrow;
    }
  }
}

extension ResposeModification on Response {
  bool get isSuccessful => statusCode == 200 || statusCode == 201;
}
