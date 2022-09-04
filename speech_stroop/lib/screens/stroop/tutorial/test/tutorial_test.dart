import 'package:flutter/material.dart';
import 'package:speech_stroop/screens/stroop/tutorial/test/components/body.dart';

class TutorialTestScreen extends StatelessWidget {
  const TutorialTestScreen({Key key}) : super(key: key);
  static String routeName = "/tutorial_test";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
