import 'dart:convert';

import 'package:speech_stroop/constants.dart';
import 'package:http/http.dart' as http;
import 'package:speech_stroop/screens/stroop/stroop_test/stroop_test.dart';
import './test_module/section.dart';

class ExperimentalToken {
  String runingNumber;
  Object feedbackOrder;

  ExperimentalToken(this.runingNumber);

  ExperimentalToken.withFeedbackOrder(this.runingNumber, this.feedbackOrder);

  factory ExperimentalToken.fromJson(Map<String, dynamic> json) {
    return ExperimentalToken.withFeedbackOrder(
      json['runingNumber'],
      json['feedbackOrder'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "runingNumber": runingNumber,
    };
  }
}

Future<int> setExperimentee(
  String runingNumber,
) async {
  currentExperimentee = ExperimentalToken(runingNumber);
  print(jsonEncode(currentExperimentee));
  var res = await http.post(
      Uri.parse("${APIPath.baseUrl}/experimental/submit_experimentee"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(currentExperimentee));
  final Map parse = json.decode(res.body);
  currentExperimentee = ExperimentalToken.fromJson(parse);
  print("post: /experimental/submit_result " + res.statusCode.toString());
  return res.statusCode;
}
