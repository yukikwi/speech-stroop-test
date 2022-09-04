import 'package:flutter/material.dart';
import 'package:speech_stroop/screens/stroop/result/components/type_score_box.dart';
import 'package:speech_stroop/theme.dart';

class TypeScore extends StatelessWidget {
  TypeScore(this.congruent, this.inCongruent);
  final int congruent;
  final int inCongruent;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                alignment: Alignment.topLeft,
                child: Text(
                  'คะแนนตามประเภทของคำถาม',
                  style: textTheme().titleMedium,
                ),
              ),
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Expanded(
                    child: TypeScoreBox(
                      "Congruent",
                      "สีที่แสดงตรงกับคำอ่าน",
                      congruent,
                    ),
                  ),
                  Expanded(
                    child: TypeScoreBox(
                      "Incongruent",
                      "สีที่แสดงไม่ตรงกับคำอ่าน",
                      inCongruent,
                    ),
                  ),
                  //if (s.section != 3) const SizedBox(width: 5),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
