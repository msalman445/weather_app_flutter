import 'package:flutter/material.dart';
import 'package:weather_app/widgets/weather_icon.dart';

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({
    super.key,
    required this.day,
    required this.iconCode,
    required this.temperature,
  });
  final String day;
  final String? iconCode;
  final String temperature;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 93,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 150),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              day,
              style: TextStyle(color: const Color.fromARGB(255, 136, 136, 136)),
            ),
            WeatherIcon(
              iconCode: iconCode,
              width: 35,
              height: 35,
              defaultIconPath: "assets/images/sun_24.png",
            ),
            Text(
              "$temperature°",
              style: TextStyle(color: const Color.fromARGB(255, 136, 136, 136)),
            ),
          ],
        ),
      ),
    );
  }
}
