import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/custom_colors.dart';
import 'package:weather_app/pages/weather_data_column.dart';
import 'package:weather_app/providers/weather_api_provider.dart';
import 'package:weather_app/providers/weather_db_provider.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  late WeatherDbProvider _weatherDbProvider;
  late WeatherApiProvider _weatherApiProvider;

  bool isRefresh = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<WeatherDbProvider>().getWeatherDataFromDb();
    });
  }

  Future<void> _onRefresh() async {
    isRefresh = true;
    await _weatherDbProvider.getWeatherDataFromDb();
    return _weatherApiProvider.getWeatherData(
      _weatherDbProvider.weatherForecastResponse!.city.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);

    // Providers
    _weatherDbProvider = context.watch<WeatherDbProvider>();
    _weatherApiProvider = context.watch<WeatherApiProvider>();

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
      child: SafeArea(
        bottom: false,
        minimum: EdgeInsets.all(13),
        child: Builder(
          builder: (context) {
            switch (_weatherApiProvider.weatherState) {
              case WeatherState.initial:
                if (_weatherDbProvider.weatherForecastResponse == null) {
                  return Center(
                    widthFactor: width,
                    heightFactor: height,
                    child: Text("Please Enter Your Location..."),
                  );
                } else {
                  return WeatherDataColumn(
                    weatherForecastResponse:
                        _weatherDbProvider.weatherForecastResponse!,
                    onRefresh: _onRefresh,
                  );
                }
              case WeatherState.loading:
                if (isRefresh) {
                  isRefresh = false;
                  return WeatherDataColumn(
                    weatherForecastResponse:
                        _weatherDbProvider.weatherForecastResponse!,
                    onRefresh: _onRefresh,
                  );
                }
                return SizedBox(
                  width: width,
                  height: height - kToolbarHeight - 26,
                  child: Center(child: CircularProgressIndicator()),
                );

              case WeatherState.error:
                return Column(
                  children: [
                    Text(_weatherApiProvider.errorMessage),
                    ElevatedButton(
                      onPressed: () {
                        _weatherApiProvider.resetState();
                      },
                      child: Text("Retry"),
                    ),
                  ],
                );
              case WeatherState.loaded:
                final weatherData = _weatherApiProvider.weatherForecastResponse;

                return WeatherDataColumn(
                  weatherForecastResponse: weatherData!,
                  onRefresh: _onRefresh,
                );
            }
          },
        ),
      ),
    );
  }
}
