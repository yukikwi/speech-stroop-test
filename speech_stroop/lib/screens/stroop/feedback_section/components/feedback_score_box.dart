import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/utils/date_format.dart';
import 'package:speech_stroop/model/test_module/question.dart';

class FeedbackScoreBox extends StatefulWidget {
  const FeedbackScoreBox(this.section, this.reactionTime, this.questions,
      {Key key})
      : super(key: key);
  final int section;
  final double reactionTime;
  final List<Question> questions;

  @override
  _FeedbackScoreBoxState createState() => _FeedbackScoreBoxState();
}

class _FeedbackScoreBoxState extends State<FeedbackScoreBox> {
  final formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    for (int i = 0; i < stroopQuestionsAmount; i++) {
      print("questionNumber: ${widget.questions[i].questionNumber}");
      print("problem['color']: ${widget.questions[i].problem["color"]}");
      print("problem['word']: ${widget.questions[i].problem["word"]}");
      print("expectedAnswer: ${widget.questions[i].expectedAnswer}");
      print("userAnswer: ${widget.questions[i].userAnswer}");
      print("isCorrect: ${widget.questions[i].isCorrect}");
      print("reactionTimeMs: ${widget.questions[i].reactionTimeMs}");
      print("isCorrect: ${widget.questions[i].isCorrect}");
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(children: [
          Text(
            "เวลาเฉลี่ยที่ใช้",
            style:
                Theme.of(context).textTheme.titleSmall.apply(color: formText),
          ),
          widget.reactionTime != null
              ? Text(
                  "${(widget.reactionTime / 1000).toStringAsFixed(2)} วินาที",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      .apply(color: formText),
                )
              : Text(
                  "ไม่สามารถคำนวณได้",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      .apply(color: formText),
                ),
        ]),
        const SizedBox(height: 25),
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFFEEF0F3),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          height: deviceHeight(context) * 0.4,
          constraints: const BoxConstraints(
            maxHeight: double.infinity,
          ),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Container(
                  alignment: Alignment.center,
                  width: 100.0,
                  height: 40.0,
                  child: Text(
                    "ข้อที่",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        .apply(color: primaryColor),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 100.0,
                  height: 40.0,
                  child: Text(
                    "โจทย์",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        .apply(color: primaryColor),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 100.0,
                  height: 40.0,
                  child: Text(
                    "คำตอบที่ถูกต้อง",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        .apply(color: primaryColor),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 100.0,
                  height: 40.0,
                  child: Text(
                    "เวลา",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        .apply(color: primaryColor),
                  ),
                ),
                const SizedBox(
                  width: 100.0,
                  height: 40.0,
                ),
              ]),
              Divider(
                color: primaryColor.withOpacity(0.3),
                height: 25,
                thickness: 2,
                indent: 15,
                endIndent: 15,
              ),
              for (int i = 0; i < stroopQuestionsAmount; i++)
                Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 100.0,
                          height: 40.0,
                          child: Text(
                            widget.questions[i].questionNumber.toString(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                .apply(color: Colors.black),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 100.0,
                          height: 40.0,
                          child: Text(
                            widget.questions[i].problem["word"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: stroopColorsMap[
                                  widget.questions[i].problem["color"]],
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 100.0,
                          height: 40.0,
                          child: Text(
                            widget.questions[i].expectedAnswer,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                .apply(color: Colors.black),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 100.0,
                          height: 40.0,
                          child: widget.questions[i].reactionTimeMs == null
                              ? Text(
                                  "-",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      .apply(color: Colors.black),
                                )
                              : Text(
                                  "${(widget.questions[i].reactionTimeMs / 1000).toStringAsFixed(2)} วินาที",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      .apply(color: Colors.black),
                                ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 100.0,
                          height: 40.0,
                          child: widget.questions[i].isCorrect
                              ? const Text(
                                  "ถูก",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF6FC2A0),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : const Text(
                                  "ผิด",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFFDA4F2C),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ]),
                  Divider(
                    color: primaryColor.withOpacity(0.3),
                    height: 25,
                    thickness: 1,
                    indent: 15,
                    endIndent: 15,
                  ),
                ]),
            ],
          )),
        ),
      ],
    );
  }
}
