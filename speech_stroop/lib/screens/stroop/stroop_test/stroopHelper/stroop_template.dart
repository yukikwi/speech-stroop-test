import 'dart:math';

import 'package:speech_stroop/screens/stroop/stroop_test/stroopHelper/stroop_combination.dart';

List<int> stroopLevels = [];

List<StroopQuestion> buildTest(bool isTutorial, [int sectionNumber]) {
  int level = 0;

  Random rn = Random();
  int congruent = 0, incongruent = 0;

  List<StroopQuestion> template = [];

  // random level
  if (isTutorial) {
    level = 0;
  } else {
    do {
      level = rn.nextInt(4);
    } while (stroopLevels.contains(level) || level == 0);
    stroopLevels.add(level);
    if (sectionNumber == 3) {
      stroopLevels.clear();
    }
  }

  switch (level) {
    case 0:
      congruent = 2;
      incongruent = 3;
      break;
    case 1:
      congruent = 14;
      incongruent = 6;
      break;
    case 2:
      congruent = 10;
      incongruent = 10;
      break;
    case 3:
      congruent = 6;
      incongruent = 14;
      break;
    default:
  }

  template = randomTest(congruent, incongruent);
  template = shuffleTest(template);

  return template;
}

List<StroopQuestion> randomTest(int congruentAmount, int incongruentAmount) {
  final rn = Random();
  List<StroopQuestion> template = [];

  for (var i = 0; i < congruentAmount; i++) {
    var conQuestion =
        stroopCongruentQuestions[rn.nextInt(stroopCongruentQuestions.length)];
    template.add(conQuestion);
  }

  for (var i = 0; i < incongruentAmount; i++) {
    var inconQuestion = stroopIncongruentQuestions[
        rn.nextInt(stroopIncongruentQuestions.length)];

    if (!template.contains(inconQuestion)) {
      template.add(inconQuestion);
    } else {
      i--;
    }
  }
  return template;
}

List<StroopQuestion> shuffleTest(List<StroopQuestion> template) {
  List<StroopQuestion> shuffled = [];
  int curr = 0;
  int prev = -1;

  final rn = Random();

  template.shuffle();

  // prevent same question being next to each other
  for (StroopQuestion q in template) {
    curr = q.index;
    if (curr == prev) {
      // หยิบใหม่
      List<StroopQuestion> filtered = stroopAllQuestions
          .where((elem) =>
              (elem.condition == q.condition && elem.index != q.index))
          .toList();
      int randomIdx = rn.nextInt(filtered.length - 1);
      q = filtered[randomIdx];
      curr = q.index;
    }
    shuffled.add(q);
    prev = curr;
  }
  return shuffled;
}
