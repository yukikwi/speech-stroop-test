import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/model/test_module/section.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroop_test.dart';
import 'package:tuple/tuple.dart';

var scores = {"congruent": 0, "incongruent": 0};

Tuple2<bool, String> checkAnswer(
    String recogWord, int answered, String correctAnswer) {
  bool isCorrect = false;
  if (answered >= 0) {
    // check entire recogWord
    if (similarWords[correctAnswer].contains(recogWord)) {
      isCorrect = true;
      recogWord = correctAnswer;
    } else {
      // check some part of recogWord
      for (Tuple2 t in allSimilarWords) {
        if (recogWord.contains(t.item2)) {
          recogWord = recogWord.replaceAll(t.item2, ' ${t.item1} ');
        }
      }
      List<String> splitRecogWord =
          recogWord.split(" ").where((e) => e != '').toList();

      recogWord = splitRecogWord.join();

      for (String word in splitRecogWord) {
        if (similarWords.keys.toList().contains(word)) {
          if (word == correctAnswer) {
            isCorrect = true;
          }
          break;
        }
      }
    }
  }
  return Tuple2(isCorrect, recogWord);
}

void scoreCounting(bool isCorrect) {
  // count score for each questions
  if (answered >= 0 && isCorrect) {
    String condition = testTemplate[answered].condition;
    scores[condition]++;
  }
  // count score for each sections
  if (answered == stroopQuestionsAmount - 1) {
    var totalScoreThisSection = scores["congruent"] + scores["incongruent"];
    totalScore += totalScoreThisSection;

    // culculate average reaction time
    var notEmptyReactionTime = questions
        .map((q) => q.reactionTimeMs)
        .where((rt) => rt != null)
        .toList();
    int notEmptyReactionTimeLength = notEmptyReactionTime.length;
    double avgReactionTime = notEmptyReactionTimeLength == 0
        ? null
        : (notEmptyReactionTime.reduce((a, b) => a + b)) /
            notEmptyReactionTimeLength;

    var section =
        Section(sectionNumber, scores, avgReactionTime, questions, "audioUrl");
    sections.add(section);
  }
}
