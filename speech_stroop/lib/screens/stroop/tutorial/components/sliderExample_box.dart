import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/screens/stroop/healthRating/components/health_slider.dart';

class sliderExampleBox extends StatelessWidget {
  sliderExampleBox();
  double value1 = 0;
  double value2 = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            AbsorbPointer(child: HealthSlider()),
          ],
        ),
      )),
      height: deviceHeight(context) * 0.3,
      width: deviceWidth(context) * 0.9,
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
