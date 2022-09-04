import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:speech_stroop/constants.dart';

class LoadingScreen extends StatelessWidget {
  final List<Color> loadingColors = [
    secondaryColor,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(100),
        child: Center(
          child: SizedBox(
            height: 30,
            width: 80,
            child: LoadingIndicator(
              indicatorType: Indicator.ballPulseSync,
              colors: loadingColors,
              strokeWidth: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
