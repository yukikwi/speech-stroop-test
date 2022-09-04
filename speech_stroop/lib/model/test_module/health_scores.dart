class HealthScores {
  HealthScore stress;
  HealthScore arousel;

  HealthScores(this.stress, this.arousel);

  factory HealthScores.fromJson(dynamic json) {
    return HealthScores(
      HealthScore.fromJson(json['stress']),
      HealthScore.fromJson(json['arousel']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "stress": stress,
      "arousel": arousel,
    };
  }
}

class HealthScore {
  int start;
  int break1;
  int break2;
  int end;

  HealthScore(this.start, this.break1, this.break2, this.end);

  factory HealthScore.fromJson(dynamic json) {
    return HealthScore(
      json['start'] as int,
      json['break1'] as int,
      json['break2'] as int,
      json['end'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "start": start,
      "break1": break1,
      "break2": break2,
      "end": end,
    };
  }
}
