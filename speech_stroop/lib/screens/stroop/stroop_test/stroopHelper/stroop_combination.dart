import 'package:speech_stroop/constants.dart';

class StroopQuestion {
  final int index;
  final String word;
  final String color;
  final String condition;
  StroopQuestion({this.index, this.word, this.color, this.condition});
}

List<List<StroopQuestion>> stroopColorCombination() {
  int idx = 0;
  List<StroopQuestion> congruent = [];
  List<StroopQuestion> incongruent = [];
  List<StroopQuestion> all = [];
  for (var i = 0; i < stroopColorsName.length; i++) {
    var colorName = stroopColorsName[i];
    for (var j = 0; j < stroopColorsName.length; j++) {
      var colorCode = stroopColorsName[j];
      if (colorName == colorCode) {
        StroopQuestion q = StroopQuestion(
            index: idx,
            word: colorName,
            color: colorCode,
            condition: 'congruent');
        congruent.add(q);
      } else {
        StroopQuestion q = StroopQuestion(
            index: idx,
            word: colorName,
            color: colorCode,
            condition: 'incongruent');
        incongruent.add(q);
      }
      idx++;
    }
  }
  all = [...congruent, ...incongruent];
  return [congruent, incongruent, all];
}

List<List<StroopQuestion>> stroopQuestions = stroopColorCombination();
List<StroopQuestion> stroopCongruentQuestions = stroopQuestions[0];
List<StroopQuestion> stroopIncongruentQuestions = stroopQuestions[1];
List<StroopQuestion> stroopAllQuestions = stroopQuestions[2];
