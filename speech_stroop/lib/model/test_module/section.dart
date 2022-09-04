import './question.dart';

class Section {
  int section;
  Map<String, dynamic> score = {"congruent": null, "incongruent": null};
  double avgReactionTimeMs;
  List<Question> questions;
  String audioUrl;

  Section(
      [this.section,
      this.score,
      this.avgReactionTimeMs,
      this.questions,
      this.audioUrl]);

  factory Section.fromJson(dynamic json) {
    dynamic avgReactionTimeMs = json['avgReactionTimeMs'] ?? 0;
    List<Question> questions = json['questions'] != null
        ? List<Question>.from(
            json['questions'].map((data) => Question.fromJson(data)))
        : [];

    return Section(
      json['section'] as int,
      Map<String, dynamic>.from(json['score']),
      avgReactionTimeMs.toDouble() as double,
      questions,
      json['audioUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "section": section,
      "score": score,
      "avgReactionTimeMs": avgReactionTimeMs,
      "questions": questions,
      "audioUrl": audioUrl
    };
  }
}
