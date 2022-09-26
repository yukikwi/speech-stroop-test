class ExperimentalToken {
  String runingNumber;

  ExperimentalToken({
    this.runingNumber,
  });

  factory ExperimentalToken.fromJson(Map<String, dynamic> json) {
    return ExperimentalToken(
      runingNumber: json['runingNumber'],
    );
  }
}
