class Precondition {
  bool isColorBlind;
  PreconditionScore colorVisibilityTest;
  PreconditionScore readingAbilityTest;
  bool isPassAll;

  Precondition(
    this.isColorBlind,
    this.colorVisibilityTest,
    this.readingAbilityTest,
    this.isPassAll,
  );

  factory Precondition.fromJson(dynamic json) {
    return Precondition(
        json['isColorBlind'] as bool,
        PreconditionScore.fromJson(json['colorVisibilityTest']),
        PreconditionScore.fromJson(json['readingAbilityTest']),
        json['isPassAll'] as bool);
  }

  Map<String, dynamic> toJson() {
    return {
      "isColorBlind": isColorBlind,
      "colorVisibilityTest": colorVisibilityTest,
      "readingAbilityTest": readingAbilityTest,
      "isPassAll": isPassAll,
    };
  }
}

class PreconditionScore {
  int score;
  DateTime date;

  PreconditionScore(this.score, this.date);

  factory PreconditionScore.fromJson(dynamic json) {
    return PreconditionScore(
      json['score'] as int,
      DateTime.parse(json['date'] as String).toLocal(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "score": score,
      "date": date.toIso8601String(),
    };
  }
}
