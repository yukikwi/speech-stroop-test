import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';

class SectionBox extends StatelessWidget {
  const SectionBox(this.section, this.score, this.reactionTime, {Key key})
      : super(key: key);
  final int section;
  final int score;
  final double reactionTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 93,
      height: 130,
      decoration: BoxDecoration(
        color: const Color(0xFF211338).withOpacity(0.03),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ส่วนที่ $section",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  .apply(color: Colors.black),
            ),
            const SizedBox(height: 2),
            Text(
              '${(reactionTime / 1000).toStringAsFixed(2)} วิ',
              style:
                  Theme.of(context).textTheme.labelSmall.apply(color: formText),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${((score / stroopQuestionsAmount) * 100).round()}',
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '%',
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$score',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  '/$stroopQuestionsAmount',
                  style: TextStyle(
                    color: primaryColor.withOpacity(0.4),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
