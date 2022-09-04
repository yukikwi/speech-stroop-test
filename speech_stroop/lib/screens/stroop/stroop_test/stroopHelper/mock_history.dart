import 'dart:math';

import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/model/test_module/health_scores.dart';
import 'package:speech_stroop/model/test_module/history.dart';
import 'package:speech_stroop/model/test_module/question.dart';
import 'package:speech_stroop/model/test_module/section.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroopHelper/stroop_combination.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroopHelper/stroop_template.dart';

mockHistory() {
  List<Section> sections = [];
  int totalScore = 0;
  HealthScores healthScores =
      HealthScores(HealthScore(1, 1, 1, 1), HealthScore(1, 1, 1, 1));

  for (int i = 0; i < stroopSectionAmount; i++) {
    List<StroopQuestion> testTemp = buildTest(false, i + 1);
    List<Question> questions = [];
    Section section = Section(
      i + 1,
      {"congruent": null, "incongruent": null},
      1000,
      questions,
      'audio',
    );

    int j = 0;
    for (StroopQuestion t in testTemp) {
      Question q = Question(
        j,
        {"color": t.color, "word": t.word},
        t.condition,
        t.color,
        t.color,
        "00:00",
        "00:00",
        1000,
        true,
      );
      questions.add(q);
      j++;
    }

    var c = questions.map((e) => e.condition).toList();
    int congruent = c.where((e) => e == "congruent").length;
    int incongruent = c.where((e) => e == "incongruent").length;

    Random rn = Random();
    int del = rn.nextInt(5);
    congruent -= del;

    del = rn.nextInt(5);
    incongruent -= del;

    totalScore = totalScore + (congruent + incongruent);

    section.questions = questions;
    section.score = {"congruent": congruent, "incongruent": incongruent};
    sections.add(section);
  }

  setHistory(
    totalScore,
    sections,
    healthScores,
    ['62752a995ec14f7d629ee0d9', '62752aaa5ec14f7d629ee0dc'],
  );
}
