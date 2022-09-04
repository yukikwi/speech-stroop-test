import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/theme.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroopHelper/speech_check.dart';

class ExampleBox extends StatelessWidget {
  final String text;
  final String color;
  ExampleBox(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              text,
              style: textTheme()
                  .displaySmall
                  .apply(color: stroopColorsMap[color], fontWeightDelta: 3),
              textAlign: TextAlign.center,
            ),
            Text(
              'คำตอบ: $color',
              style: textTheme().titleMedium.apply(color: Colors.grey[800]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )),
      width: 170,
      height: 114,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );
  }
}
