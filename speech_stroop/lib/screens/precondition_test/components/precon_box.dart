import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/theme.dart';

class PreconBox extends StatelessWidget {
  final String testName;
  final String testDescription;
  PreconBox(this.testName, this.testDescription);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              testName,
              style: textTheme().bodyLarge.apply(color: Colors.black, fontWeightDelta: 1),
              textAlign: TextAlign.center,
            ),
            Text(
              testDescription,
              style: textTheme().bodyMedium.apply(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )),
      width: 245,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: tertiaryColor,
      ),
    );
  }
}
