import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/widgets/weather_icon.dart';

class TemperatureRow extends StatelessWidget {
  const TemperatureRow({
    super.key,
    this.temperature = "45",
    this.weatherCondition = "Sunny",
    this.iconCode = "01d",
  });
  final String temperature;
  final String weatherCondition;
  final String iconCode;
  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 300),
      child: FittedBox(
        child: Row(
          children: [
            SizedBox(
              width: width * 0.4,
              height: width * 0.4,
              child: WeatherIcon(
                iconCode: iconCode,
                width: width * 0.45,
                height: width * 0.45,
              ),
            ),
            SizedBox(
              width: width * 0.45,
              height: width * 0.45,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: width * 0.04,
                    child: AutoSizeText(
                      temperature,
                      style: TextStyle(fontSize: width * 0.2),
                    ),
                  ),
                  Positioned(
                    bottom: width * 0.04,
                    child: AutoSizeText(
                      weatherCondition,
                      style: TextStyle(fontSize: width * 0.08),
                    ),
                  ),
                  Positioned(
                    top: width * 0.1,
                    right: width * 0.06,
                    child: AutoSizeText(
                      "°C",
                      style: TextStyle(fontSize: width * 0.055),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
