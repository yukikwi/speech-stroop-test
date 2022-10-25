import 'package:flutter/material.dart';
import 'package:speech_stroop/components/button/primary_button.dart';
import 'package:speech_stroop/enums.dart';
import 'package:speech_stroop/model/test_module/experimental_history.dart';
import 'package:speech_stroop/model/test_module/history.dart';
import 'package:speech_stroop/screens/home/home_screen.dart';
import 'package:speech_stroop/screens/stroop/feedback_section/components/feedback_score.dart';
import 'package:speech_stroop/screens/stroop/feedback_section/components/total_score.dart';
import 'package:speech_stroop/screens/stroop/healthRating/break_screen.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroop_test.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final formGlobalKey = GlobalKey<FormState>();
  ExperimentalHistory latestTestData;
  List<History> history;
  bool showBadgeModal = false;

  @override
  void initState() {
    latestTestData = latestExperimentalTestData;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
            child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              TotalScore(sections[sectionNumber - 1].score["congruent"] +
                  sections[sectionNumber - 1].score["incongruent"]),
              const SizedBox(height: 5),
              const FeedbackScore(),
              const SizedBox(height: 5),
              PrimaryButton(
                  "ไปยังส่วนถัดไป",
                  () => {Navigator.pushNamed(context, BreakScreen.routeName)},
                  ButtonType.medium)
            ],
          ),
        )));
  }
}
