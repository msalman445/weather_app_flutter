import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/custom_colors.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/pages/template_home_page.dart';

class WeatherHomePage extends StatelessWidget {
  const WeatherHomePage({super.key, required this.weatherFutureData});
  final Future<WeatherForecastResponse>? weatherFutureData;

  String dateFormatter(WeatherForecastResponse weatherForecastResponse) {
    final DateFormat dateFormat = DateFormat("E, MMM d");
    return dateFormat.format(weatherForecastResponse.list[0].dt);
  }

  @override
  Widget build(BuildContext context) {
    // final Size(:width, :height) = MediaQuery.sizeOf(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [clrLightOrangeTheme, clrDarkOrangeTheme],
        ),
      ),
      child: SingleChildScrollView(
        child: Center(
          child: SafeArea(
            bottom: false,
            minimum: EdgeInsets.all(13),
            child: FutureBuilder(
              future: weatherFutureData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none) {
                  return TemplateHomePage();
                } else if (snapshot.connectionState == ConnectionState.active ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  WeatherForecastResponse weatherForecastResponse =
                      snapshot.data!;
                  return TemplateHomePage(
                    weatherForecastResponse: weatherForecastResponse,
                  );
                } else {
                  return TemplateHomePage();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
