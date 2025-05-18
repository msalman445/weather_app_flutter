import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CurrentLocation extends StatelessWidget {
  const CurrentLocation({super.key, this.location = "Dahranwala,Punjab"});

  final String location;

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);

    return Align(
      alignment: Alignment.centerLeft,
      child: AutoSizeText(
        location,
        minFontSize: 14,
        maxFontSize: 22,
        style: TextStyle(fontSize: width * 0.058, fontWeight: FontWeight.bold),
      ),
    );
  }
}
