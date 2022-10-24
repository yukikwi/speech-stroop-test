import 'dart:convert';

import 'package:speech_stroop/constants.dart';
import 'package:http/http.dart' as http;
import 'package:speech_stroop/screens/stroop/stroop_test/stroop_test.dart';
import './section.dart';

class ExperimentalHistory {
  String _id;
  String experimenteeId;
  int totalScore;
  List<Section> sections;
  DateTime createdAt;
  String feedbackType;

  ExperimentalHistory(
      this.experimenteeId, this.totalScore, this.sections, this.feedbackType,
      [this.createdAt]);

  factory ExperimentalHistory.fromJson(dynamic json) {
    List<Section> sections = List<Section>.from(
        json['sections'].map((data) => Section.fromJson(data)));

    return ExperimentalHistory(
      json['experimentee'],
      json['totalScore'] as int,
      sections,
      json['feedbackType'],
      DateTime.parse(json['createdAt']).toLocal(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "experimentee": experimenteeId,
      "totalScore": totalScore,
      "sections": sections,
      "feedbackType": feedbackType
    };
  }
}

Future<int> setHistory(
  String experimenteeId,
  int totalScore,
  List<Section> sections,
  String feedbackType,
) async {
  latestExperimentalTestData =
      ExperimentalHistory(experimenteeId, totalScore, sections, feedbackType);
  print(jsonEncode(latestExperimentalTestData));
  var res = await http.post(
      Uri.parse("${APIPath.baseUrl}/experimental/submit_result"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(latestExperimentalTestData));
  print("post: /experimental/submit_result " + res.statusCode.toString());
  return res.statusCode;
}
