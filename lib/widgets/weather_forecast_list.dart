import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/widgets/weather_forecast.dart';

class WeatherForecastList extends StatelessWidget {
  const WeatherForecastList({super.key, required this.weatherForecastResponse});
  final WeatherForecastResponse? weatherForecastResponse;
  final double gap = 10;

  String? dayFormat(DateTime? dateTime) {
    DateFormat dateFormat = DateFormat("E");
    if (dateTime != null) {
      return dateFormat.format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 93,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          WeatherForecast(
            day: dayFormat(weatherForecastResponse?.list[6].dt) ?? "Wed",
            iconCode: weatherForecastResponse?.list[6].weather[0].icon,
            temperature:
                weatherForecastResponse?.list[6].main.temp.toInt().toString() ??
                "34",
          ),
          SizedBox(width: gap),
          WeatherForecast(
            day: dayFormat(weatherForecastResponse?.list[14].dt) ?? "Wed",
            iconCode: weatherForecastResponse?.list[14].weather[0].icon,
            temperature:
                weatherForecastResponse?.list[14].main.temp
                    .toInt()
                    .toString() ??
                "34",
          ),
          SizedBox(width: gap),

          WeatherForecast(
            day: dayFormat(weatherForecastResponse?.list[22].dt) ?? "Wed",
            iconCode: weatherForecastResponse?.list[22].weather[0].icon,
            temperature:
                weatherForecastResponse?.list[22].main.temp
                    .toInt()
                    .toString() ??
                "34",
          ),
          SizedBox(width: gap),

          WeatherForecast(
            day: dayFormat(weatherForecastResponse?.list[30].dt) ?? "Wed",
            iconCode: weatherForecastResponse?.list[30].weather[0].icon,
            temperature:
                weatherForecastResponse?.list[30].main.temp
                    .toInt()
                    .toString() ??
                "34",
          ),
          SizedBox(width: gap),

          WeatherForecast(
            day: dayFormat(weatherForecastResponse?.list[38].dt) ?? "Wed",
            iconCode: weatherForecastResponse?.list[38].weather[0].icon,
            temperature:
                weatherForecastResponse?.list[38].main.temp
                    .toInt()
                    .toString() ??
                "34",
          ),
        ],
      ),
    );
  }
}
