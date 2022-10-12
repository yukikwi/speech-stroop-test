import 'package:flutter/material.dart';
import 'package:speech_stroop/model/test_module/section.dart';
import 'package:speech_stroop/screens/stroop/result/components/section_score_box.dart';
import 'package:speech_stroop/theme.dart';
import 'package:speech_stroop/screens/stroop/result/components/section_score_expand.dart';

class SectionScore extends StatelessWidget {
  const SectionScore(this.sections, {Key key}) : super(key: key);
  final List<Section> sections;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(5, 0, 0, 5),
            alignment: Alignment.topLeft,
            child: Text(
              'คะแนนแต่ละส่วน',
              style: textTheme().titleMedium,
            ),
          ),
          Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              for (var s in sections)
                Container(
                  // child: SectionScoreBox(
                  //     s.section,
                  //     s.score["congruent"] + (s.score["incongruent"] ?? 0),
                  //     s.avgReactionTimeMs ?? 0),
                  child: SectionScoreExpand(
                      s.section,
                      s.score["congruent"] + (s.score["incongruent"] ?? 0),
                      s.avgReactionTimeMs ?? 0),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
