import 'package:flutter/material.dart';
import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/screens/stroop/feedback_section/components/body.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroop_test.dart';

class FeedbackSection extends StatelessWidget {
  FeedbackSection({Key key}) : super(key: key);
  static String routeName = "/feedback_section";

  final Map<int, PreferredSizeWidget> mapAppbarString = {
    1: const CustomAppBar("แบบทดสอบที่ 1"),
    2: const CustomAppBar("แบบทดสอบที่ 2"),
    3: const CustomAppBar("แบบทดสอบที่ 3"),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mapAppbarString[sectionNumber],
      body: Body(),
    );
  }
}
