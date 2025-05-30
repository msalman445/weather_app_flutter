import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/custom_colors.dart';
import 'package:weather_app/providers/weather_api_provider.dart';
import 'package:weather_app/providers/weather_db_provider.dart';
import 'package:weather_app/widgets/custom_search_bar.dart';
import 'package:weather_app/pages/weather_home_page.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
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
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => WeatherApiProvider()),
          ChangeNotifierProvider(create: (context) => WeatherDbProvider()),
        ],
        child: MyHomePage(title: "Weather App"),
      ),
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

  void getCityWeather() {
    final String city = _textEditingController.text.trim();
    if (city.isNotEmpty) {
      context.read<WeatherApiProvider>().getWeatherData(city);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please enter your city")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: clrLightOrangeTheme,
        title: CustomSearchBar(
          textEditingController: _textEditingController,
          onSearchButtonTapped: getCityWeather,
        ),
      ),
      body: WeatherHomePage(),
    );
  }
}
