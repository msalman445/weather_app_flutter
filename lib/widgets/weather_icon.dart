import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({
    super.key,
    this.iconCode = "01d",
    required this.width,
    required this.height,
    this.defaultIconPath = "assets/images/sun.png",
  });
  final String? iconCode;
  final double width;
  final double height;
  final String defaultIconPath;

  @override
  Widget build(BuildContext context) {
    final String url = "http://openweathermap.org/img/wn/$iconCode@2x.png";
    return Image.network(
      url,
      width: width,
      height: height,
      errorBuilder:
          (context, error, stackTrace) => Image.asset(defaultIconPath),
    );
  }
}
