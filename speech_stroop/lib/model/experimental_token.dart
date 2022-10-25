import 'dart:convert';

import 'package:speech_stroop/constants.dart';
import 'package:http/http.dart' as http;
import 'package:speech_stroop/model/test_module/feedback_order.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroop_test.dart';
import './test_module/section.dart';

class ExperimentalToken {
  String runingNumber;
  FeedbackOrder feedbackOrder;

  ExperimentalToken(this.runingNumber);

  ExperimentalToken.withFeedbackOrder(this.runingNumber, this.feedbackOrder);

  factory ExperimentalToken.fromJson(Map<String, dynamic> json) {
    return ExperimentalToken.withFeedbackOrder(
        json['runingNumber'], FeedbackOrder.fromJson(json['feedbackOrder']));
  }

  Map<String, dynamic> toJson() {
    return {"runingNumber": runingNumber, "feedbackOrder": feedbackOrder};
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
  print("parse " + parse.toString());
  currentExperimentee = ExperimentalToken.fromJson(parse);
  List<int> order = [0, 0, 0];
  order[0] = currentExperimentee.feedbackOrder.afterQuestion;
  order[1] = currentExperimentee.feedbackOrder.afterSection;
  order[2] = currentExperimentee.feedbackOrder.afterAllSection;
  feedbackTypes[order[0] - 1] = "afterQuestion";
  feedbackTypes[order[1] - 1] = "afterSection";
  feedbackTypes[order[2] - 1] = "afterAllSection";
  print("feedbackTypes " + feedbackTypes.toString());
  print("post: /experimental/submit_result " + res.statusCode.toString());
  return res.statusCode;
}
