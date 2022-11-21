import 'package:flutter/material.dart';
import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/screens/stroop/feedback_section/components/body.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroop_test.dart';

class FeedbackSection extends StatelessWidget {
  FeedbackSection({Key key}) : super(key: key);
  static String routeName = "/feedback_section";

  final Map<int, PreferredSizeWidget> mapAppbarString = {
    1: CustomAppBar(
        "แบบทดสอบส่วนที่ 1", false, currentExperimentee.runingNumber),
    2: CustomAppBar(
        "แบบทดสอบส่วนที่ 2", false, currentExperimentee.runingNumber),
    3: CustomAppBar(
        "แบบทดสอบส่วนที่ 3", false, currentExperimentee.runingNumber),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mapAppbarString[sectionNumber],
      body: Body(),
    );
  }
}
