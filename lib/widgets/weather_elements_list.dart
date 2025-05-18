import 'package:flutter/material.dart';
import 'package:weather_app/widgets/weather_element.dart';

class WeatherElementsList extends StatelessWidget {
  const WeatherElementsList({
    super.key,
    this.feelsLikeTemp,
    this.humidity,
    this.wind,
  });
  final String? feelsLikeTemp;
  final String? humidity;
  final String? wind;

  final String humidityImage = "assets/images/humidity.png";

  final String temperatureImage = "assets/images/temperature.png";

  final String windImage = "assets/images/windy.png";

  @override
  Widget build(BuildContext context) {
    // final Size(:width, :height) = MediaQuery.sizeOf(context);

    return Column(
      spacing: 7,
      children: [
        WeatherElement(
          iconPath: temperatureImage,
          title: "Feels Like",
          value: "$feelsLikeTemp°C",
        ),
        WeatherElement(
          iconPath: humidityImage,
          title: "Humidity",
          value: "$humidity%",
        ),
        WeatherElement(iconPath: windImage, title: "Wind", value: "${wind}m/s"),
      ],
    );
  }
}
