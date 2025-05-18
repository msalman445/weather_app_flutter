import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CurrentDate extends StatelessWidget {
  const CurrentDate({super.key, this.date = "Tue, June 30"});
  final String date;

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: AutoSizeText(
        date,
        minFontSize: 12,
        maxFontSize: 20,
        style: TextStyle(
          fontSize: width * 0.05,
          fontWeight: FontWeight.w500,
          color: const Color.fromARGB(255, 124, 124, 124),
        ),
      ),
    );
  }
}
