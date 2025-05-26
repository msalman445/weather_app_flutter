import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/custom_colors.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/widgets/current_date.dart';
import 'package:weather_app/widgets/current_location.dart';
import 'package:weather_app/widgets/temperature_row.dart';
import 'package:weather_app/widgets/weather_elements_list.dart';
import 'package:weather_app/widgets/weather_forecast_list.dart';

class WeatherHomePage extends StatelessWidget {
  const WeatherHomePage({super.key, required this.weatherFutureData});
  final Future<WeatherForecastResponse>? weatherFutureData;

  String _dateFormatter(WeatherForecastResponse weatherForecastResponse) {
    final DateFormat dateFormat = DateFormat("E, MMM d");
    return dateFormat.format(weatherForecastResponse.list[0].dt);
  }

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    final WeatherProvider weatherProvider = context.watch<WeatherProvider>();

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
            child: Builder(
              builder: (context) {
                switch (weatherProvider.weatherState) {
                  case WeatherState.initial:
                    return Text("Please Enter Your City");
                  case WeatherState.loading:
                    return CircularProgressIndicator();
                  case WeatherState.error:
                    return Column(
                      children: [
                        Text(weatherProvider.errorMessage),
                        ElevatedButton(
                          onPressed: () {
                            weatherProvider.resetState();
                          },
                          child: Text("Retry"),
                        ),
                      ],
                    );
                  case WeatherState.loaded:
                    final weatherData = weatherProvider.weatherForecastResponse;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CurrentLocation(
                          location: weatherData?.city.name ?? "Lahore",
                        ),
                        SizedBox(height: 5),
                        CurrentDate(date: _dateFormatter(weatherData!)),

                        SizedBox(height: height * 0.03),
                        TemperatureRow(
                          temperature:
                              (weatherData.list[0].main.temp
                                  .toInt()
                                  .toString()),
                          iconCode: weatherData.list[0].weather[0].icon,
                          weatherCondition: weatherData.list[0].weather[0].main,
                        ),
                        SizedBox(height: height * 0.03),
                        WeatherElementsList(
                          feelsLikeTemp:
                              (weatherData.list[0].main.feelsLike
                                  .toInt()
                                  .toString()),
                          humidity:
                              (weatherData.list[0].main.humidity.toString()),
                          wind: (weatherData.list[0].wind.deg.toString()),
                        ),
                        SizedBox(height: height * 0.03),
                        WeatherForecastList(
                          weatherForecastResponse: weatherData,
                        ),
                      ],
                    );
                }
              },
            ),

            // FutureBuilder(
            //   future: weatherFutureData,
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.none) {
            //       return TemplateHomePage();
            //     } else if (snapshot.connectionState == ConnectionState.active ||
            //         snapshot.connectionState == ConnectionState.waiting) {
            //       return CircularProgressIndicator();
            //     } else if (snapshot.hasData) {
            //       WeatherForecastResponse weatherForecastResponse =
            //           snapshot.data!;
            //       return TemplateHomePage(
            //         weatherForecastResponse: weatherForecastResponse,
            //       );
            //     } else {
            //       return TemplateHomePage();
            //     }
            //   },
            // ),
          ),
        ),
      ),
    );
  }
}
