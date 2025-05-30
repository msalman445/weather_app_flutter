import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/widgets/current_date.dart';
import 'package:weather_app/widgets/current_location.dart';
import 'package:weather_app/widgets/temperature_row.dart';
import 'package:weather_app/widgets/weather_elements_list.dart';
import 'package:weather_app/widgets/weather_forecast_list.dart';

class WeatherDataColumn extends StatelessWidget {
  const WeatherDataColumn({
    super.key,
    required this.weatherForecastResponse,
    required this.onRefresh,
  });
  final WeatherForecastResponse weatherForecastResponse;
  final Future<void> Function() onRefresh;

  String _dateFormatter(WeatherForecastResponse weatherForecastResponse) {
    final DateFormat dateFormat = DateFormat("E, MMM d");
    return dateFormat.format(weatherForecastResponse.list[0].dt);
  }

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: Colors.blue,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CurrentLocation(location: weatherForecastResponse.city.name),
            SizedBox(height: 5),
            CurrentDate(date: _dateFormatter(weatherForecastResponse)),

            SizedBox(height: height * 0.03),
            TemperatureRow(
              temperature:
                  (weatherForecastResponse.list[0].main.temp
                      .toInt()
                      .toString()),
              iconCode: weatherForecastResponse.list[0].weather[0].icon,
              weatherCondition: weatherForecastResponse.list[0].weather[0].main,
            ),
            SizedBox(height: height * 0.03),
            WeatherElementsList(
              feelsLikeTemp:
                  (weatherForecastResponse.list[0].main.feelsLike
                      .toInt()
                      .toString()),
              humidity:
                  (weatherForecastResponse.list[0].main.humidity.toString()),
              wind: (weatherForecastResponse.list[0].wind.deg.toString()),
            ),
            SizedBox(height: height * 0.03),
            WeatherForecastList(
              weatherForecastResponse: weatherForecastResponse,
            ),
          ],
        ),
      ),
    );
  }
}
