import 'package:flutter/material.dart';
import 'package:weather_app/custom_colors.dart';
import 'package:weather_app/models/weather_api_service.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/widgets/custom_search_bar.dart';
import 'package:weather_app/pages/weather_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WeatherApiService apiService = WeatherApiService();

  Future<WeatherForecastResponse>? weatherDataFuture;

  late TextEditingController _textEditingController;

  String? city;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  void onSearchButtonTapped() {
    setState(() {
      city = _textEditingController.text;
      if (city != null) {
        weatherDataFuture = apiService.fetchWeatherData(city: city!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: clrLightOrangeTheme,
        title: CustomSearchBar(
          textEditingController: _textEditingController,
          onSearchButtonTapped: onSearchButtonTapped,
        ),
      ),
      body: WeatherHomePage(weatherFutureData: weatherDataFuture),
    );
  }
}
