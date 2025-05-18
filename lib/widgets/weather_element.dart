import 'package:flutter/material.dart';

class WeatherElement extends StatelessWidget {
  const WeatherElement({
    super.key,
    required this.iconPath,
    required this.title,
    this.value,
  });
  final String iconPath;
  final String title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Container(
      height: 55,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 150),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: width * 0.03),
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 201, 201, 201),
                      spreadRadius: 1,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Center(child: Image.asset(iconPath, width: 24)),
              ),
              SizedBox(width: width * 0.04),
              Text(title, style: TextStyle(fontSize: 15)),
            ],
          ),
          if (value != null)
            Padding(
              padding: EdgeInsets.only(right: width * 0.03),
              child: Text(value!, style: TextStyle(fontSize: 15)),
            ),
        ],
      ),
    );
  }
}
