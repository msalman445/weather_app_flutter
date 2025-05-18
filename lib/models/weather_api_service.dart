import 'dart:convert';
import 'package:http/http.dart';
import 'package:weather_app/models/weather.dart';

class WeatherApiService {
  static const String _baseUrl = "api.openweathermap.org";
  final String _apiUrl = "/data/2.5/forecast";
  final String _apiKey = "7ac32416381a8029fe4d75efa1a0ea4f";
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
      } else {
        throw Exception("Failed to load weather data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("API call failed: $e");
    }
  }
}

extension ResposeModification on Response {
  bool get isSuccessful => statusCode == 200 || statusCode == 201;
}
