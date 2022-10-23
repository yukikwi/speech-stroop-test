import 'dart:convert';

import 'package:speech_stroop/constants.dart';
import 'package:http/http.dart' as http;
import 'package:speech_stroop/screens/stroop/stroop_test/stroop_test.dart';
import './section.dart';

class ExperimentalHistory {
  String _id;
  String userId;
  int totalScore;
  List<Section> sections;
  DateTime createdAt;

  ExperimentalHistory(this.totalScore, this.sections, [this.createdAt]);

  factory ExperimentalHistory.fromJson(dynamic json) {
    List<Section> sections = List<Section>.from(
        json['sections'].map((data) => Section.fromJson(data)));

    return ExperimentalHistory(
      json['totalScore'] as int,
      sections,
      DateTime.parse(json['createdAt']).toLocal(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "totalScore": totalScore,
      "sections": sections,
    };
  }
}

Future<int> setHistory(
  String experimentee,
  int totalScore,
  List<Section> sections,
) async {
  latestExperimentalTestData = ExperimentalHistory(totalScore, sections);
  var res = await http.post(Uri.parse("${APIPath.baseUrl}/history"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(latestExperimentalTestData));
  print("post: /history " + res.statusCode.toString());
  return res.statusCode;
}
