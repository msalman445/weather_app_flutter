import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({
    super.key,
    this.iconCode = "01d",
    required this.width,
    required this.height,
  });
  final String? iconCode;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      getLottieAnimationForWeather(iconCode!),
      width: width,
      height: height,
    );
  }

  String getLottieAnimationForWeather(String iconCode) {
    switch (iconCode) {
      // Clear Sky - Day
      case '01d':
        return 'assets/lottie/sunny_day.json';

      // Few Clouds - Day
      case '02d':
        return 'assets/lottie/partly_cloudy_day.json';

      // Broken Clouds / Overcast - Day
      case '03d' || '04d' || '03n' || '04n':
        return 'assets/lottie/cloudy_day.json'; // Grouping these under one 'cloudy day'

      case '10d' || '09d': // Rain
        return 'assets/lottie/rainy_day.json';

      // Thunderstorm - Day -night
      case '11d' || '11n':
        return 'assets/lottie/thunderstorm.json';

      // Snow - Day
      case '13d' || '13n':
        return 'assets/lottie/snow_day.json';

      // Mist, Fog, Haze, etc. - Day
      case '50d' || '50n':
        return 'assets/lottie/fog.json';

      // NIGHTTIME CODES

      // Clear Sky - Night
      case '01n':
        return 'assets/lottie/clear_night.json';

      // Few Clouds - Night
      case '02n':
        return 'assets/lottie/partly_cloudy_night.json';

      // Shower Rain / Rain - Night
      case '10n' || '09n':
        return 'assets/lottie/rainy_night.json';

      default:
        return 'assets/lottie/default.json';
    }
  }
}
