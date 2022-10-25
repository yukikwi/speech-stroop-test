import 'package:flutter/material.dart';
import 'package:speech_stroop/model/test_module/section.dart';
import 'package:speech_stroop/screens/stroop/feedback_section/components/feedback_score_box.dart';
import 'package:speech_stroop/screens/stroop/result/components/section_score_box.dart';
import 'package:speech_stroop/theme.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroop_test.dart';

class FeedbackScore extends StatelessWidget {
  const FeedbackScore({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FeedbackScoreBox(
          sections[sectionNumber - 1].section,
          sections[sectionNumber - 1].avgReactionTimeMs,
          sections[sectionNumber - 1].questions),
    );
  }
}
