import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';

class TypeScoreBox extends StatelessWidget {
  TypeScoreBox(this.questionType, this.label, this.score);

  final String questionType;
  final String label;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      width: 93,
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFF211338).withOpacity(0.03),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              questionType,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  .apply(color: Colors.black),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style:
                  Theme.of(context).textTheme.labelSmall.apply(color: formText),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${((score / (stroopTotalQuestionsAmount / 2)) * 100).round()}',
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
                  '/${(stroopTotalQuestionsAmount / 2).round()}',
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
