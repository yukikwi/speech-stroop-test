import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/theme.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroopHelper/speech_check.dart';

class colorListBox extends StatelessWidget {
  colorListBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'ม่วง',
                  style: textTheme().headlineSmall.apply(
                      color: stroopColorsMap['ม่วง'], fontWeightDelta: 1),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'ฟ้า',
                  style: textTheme()
                      .headlineSmall
                      .apply(color: stroopColorsMap['ฟ้า'], fontWeightDelta: 1),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'เขียว',
                  style: textTheme().headlineSmall.apply(
                      color: stroopColorsMap['เขียว'], fontWeightDelta: 1),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'เหลือง',
                  style: textTheme().headlineSmall.apply(
                      color: stroopColorsMap['เหลือง'], fontWeightDelta: 1),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'ส้ม',
                  style: textTheme()
                      .headlineSmall
                      .apply(color: stroopColorsMap['ส้ม'], fontWeightDelta: 1),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'แดง',
                  style: textTheme()
                      .headlineSmall
                      .apply(color: stroopColorsMap['แดง'], fontWeightDelta: 1),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Text(
              'ดำ',
              style: textTheme()
                  .headlineSmall
                  .apply(color: stroopColorsMap['ดำ'], fontWeightDelta: 1),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )),
      width: 243,
      height: 197,
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
