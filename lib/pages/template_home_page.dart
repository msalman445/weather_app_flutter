import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/widgets/current_date.dart';
import 'package:weather_app/widgets/current_location.dart';
import 'package:weather_app/widgets/temperature_row.dart';
import 'package:weather_app/widgets/weather_elements_list.dart';
import 'package:weather_app/widgets/weather_forecast_list.dart';

class TemplateHomePage extends StatelessWidget {
  const TemplateHomePage({super.key, this.weatherForecastResponse});
  final WeatherForecastResponse? weatherForecastResponse;

  String? dateFormatter(WeatherForecastResponse? weatherForecastResponse) {
    final DateFormat dateFormat = DateFormat("E, MMM d");
    if (weatherForecastResponse != null) {
      return dateFormat.format(weatherForecastResponse.list[0].dt);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CurrentLocation(
          location: weatherForecastResponse?.city.name ?? "Lahore",
        ),
        SizedBox(height: 5),
        CurrentDate(
          date: dateFormatter(weatherForecastResponse) ?? "Sun, May 18",
        ),

        SizedBox(height: height * 0.03),
        TemperatureRow(
          temperature:
              (weatherForecastResponse?.list[0].main.temp.toInt().toString()) ??
              "34",
          iconCode: weatherForecastResponse?.list[0].weather[0].icon ?? "01d",
          weatherCondition:
              weatherForecastResponse?.list[0].weather[0].main ?? "Sunny",
        ),
        SizedBox(height: height * 0.03),
        WeatherElementsList(
          feelsLikeTemp:
              (weatherForecastResponse?.list[0].main.feelsLike
                  .toInt()
                  .toString()) ??
              "34",
          humidity:
              (weatherForecastResponse?.list[0].main.humidity.toString()) ??
              "11",
          wind: (weatherForecastResponse?.list[0].wind.deg.toString()) ?? "170",
        ),
        SizedBox(height: height * 0.03),
        // if (weatherForecastResponse != null)
        WeatherForecastList(weatherForecastResponse: weatherForecastResponse),
      ],
    );
  }
}
