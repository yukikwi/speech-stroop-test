class FeedbackOrder {
  int afterQuestion;
  int afterSection;
  int afterAllSection;

  FeedbackOrder(this.afterQuestion, this.afterSection, this.afterAllSection);

  factory FeedbackOrder.fromJson(dynamic json) {
    return FeedbackOrder(
      json['afterQuestion'] as int,
      json['afterSection'] as int,
      json['afterAllSection'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "afterQuestion": afterQuestion,
      "afterSection": afterSection,
      "afterAllSection": afterAllSection,
    };
  }
}
