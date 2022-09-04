class Question {
  int questionNumber;
  Map<String, String> problem = {"color": null, "word": null};
  String condition;
  String expectedAnswer;
  String userAnswer;
  String startAt;
  String answerAt;
  int reactionTimeMs;
  bool isCorrect;

  Question(
    this.questionNumber,
    this.problem,
    this.condition,
    this.expectedAnswer,
    this.userAnswer,
    this.startAt,
    this.answerAt,
    this.reactionTimeMs,
    this.isCorrect,
  );

  factory Question.fromJson(dynamic json) {
    return Question(
      json['questionNumber'] as int,
      Map<String, String>.from(json['problem']),
      json['condition'] as String,
      json['expectedAnswer'] as String,
      json['userAnswer'] as String,
      json['startAt'] as String,
      json['answerAt'] as String,
      json['reactionTimeMs'] as int,
      json['isCorrect'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "questionNumber": questionNumber,
      "problem": problem,
      "condition": condition,
      "expectedAnswer": expectedAnswer,
      "userAnswer": userAnswer,
      "startAt": startAt,
      "answerAt": answerAt,
      "reactionTimeMs": reactionTimeMs,
      "isCorrect": isCorrect,
    };
  }
}
