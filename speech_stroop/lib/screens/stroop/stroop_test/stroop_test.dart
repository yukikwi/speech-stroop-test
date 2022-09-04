import 'package:flutter/material.dart';
import 'package:speech_stroop/model/test_module/health_scores.dart';
import 'package:speech_stroop/model/test_module/history.dart';
import 'package:speech_stroop/model/test_module/question.dart';
import 'package:speech_stroop/model/test_module/section.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/components/body.dart';

import 'package:speech_stroop/screens/stroop/stroop_test/components/flutter_sound.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroopHelper/stroop_combination.dart';

//badge
int correctStack = 0;
int highestCorrectStack = 0;
// answer
int answered = -1;
// latest test
History latestTest;
// section
int sectionNumber = 0;
List<Section> sections = [];
// health scores
HealthScores healthScores;
HealthScore stress = HealthScore(0, 0, 0, 0);
HealthScore arousel = HealthScore(0, 0, 0, 0);

List<Question> questions = [];
int totalScore = 0;
// build test
List<StroopQuestion> testTemplate;
String recogWord = '';
double confidence = 0;
// stopwatch
Stopwatch stopwatchRT = Stopwatch();
Stopwatch stopwatchAudio = Stopwatch();
// audio
// RecordAudio recordAudio;
String recordAudioDateTime = "";

class StroopTestScreen extends StatelessWidget {
  const StroopTestScreen({Key key}) : super(key: key);
  static String routeName = "/stroop_test";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}

String getAudioFileDateFormat(DateTime date) {
  String dateFormatted =
      date.toString().replaceAll(":", "-").replaceAll(" ", "_").split(".")[0];

  return dateFormatted;
}
