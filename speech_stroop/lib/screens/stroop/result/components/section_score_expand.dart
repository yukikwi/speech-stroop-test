import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/utils/date_format.dart';
import 'package:speech_stroop/model/test_module/question.dart';

class SectionScoreExpand extends StatefulWidget {
  const SectionScoreExpand(
      this.section, this.score, this.reactionTime, this.questions,
      {Key key})
      : super(key: key);
  final int section;
  final int score;
  final double reactionTime;
  final List<Question> questions;

  @override
  _SectionScoreExpandState createState() => _SectionScoreExpandState();
}

class _SectionScoreExpandState extends State<SectionScoreExpand> {
  final formGlobalKey = GlobalKey<FormState>();

  bool expanded;
  bool canExpaned;

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
    expanded = false;
    canExpaned = false;

    super.initState();
  }

  double _getHeight() {
    double height = 50;
    if (expanded) {
      height = 540;
    }
    return height;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(5, 0, 0, 5),
      // padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
      height: _getHeight(),
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      decoration: BoxDecoration(
          color: softPrimaryColor, borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(
            "ส่วนที่ ${widget.section}",
            style: Theme.of(context)
                .textTheme
                .titleSmall
                .apply(color: Colors.black),
          ),
          Text(
            "${(widget.reactionTime / 1000).toStringAsFixed(2)} วินาที",
            style:
                Theme.of(context).textTheme.labelSmall.apply(color: formText),
          ),
          // const Spacer(),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              '${((widget.score / stroopQuestionsAmount) * 100).round()}',
              style: TextStyle(
                color: secondaryColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              '%',
              style: TextStyle(
                color: secondaryColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${widget.score}',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                '/$stroopQuestionsAmount',
                style: TextStyle(
                  color: primaryColor.withOpacity(0.4),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              setState(() {
                expanded = !expanded;

                Future.delayed(
                    !expanded
                        ? const Duration(milliseconds: 0)
                        : const Duration(milliseconds: 400),
                    () => {
                          setState(() {
                            canExpaned = !canExpaned;
                          }),
                        });
              });
            },
            icon: expanded
                ? Image.asset("assets/images/up.png")
                : Image.asset("assets/images/down.png"),
          ),
        ]),
        if (canExpaned == true)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Divider(
                color: primaryColor.withOpacity(0.3),
                height: 25,
                thickness: 2,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "โจทย์",
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        .apply(color: formText),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "คำตอบของคุณ",
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        .apply(color: formText),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "เวลา",
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        .apply(color: formText),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
              ]),
              Divider(
                color: primaryColor.withOpacity(0.3),
                height: 25,
                thickness: 2,
              ),
              for (int i = 0; i < stroopQuestionsAmount; i++)
                Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            widget.questions[i].problem["word"],
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.labelLarge.apply(
                                color: stroopColorsMap[
                                    widget.questions[i].problem["color"]]),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: widget.questions[i].userAnswer == null ||
                                  widget.questions[i].userAnswer.isEmpty
                              ? Text(
                                  "ไม่ได้ตอบ",
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      .apply(color: formText),
                                )
                              : Text(
                                  widget.questions[i].userAnswer,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      .apply(color: formText),
                                ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: widget.questions[i].reactionTimeMs == null
                              ? Text(
                                  "ไม่ได้ตอบ",
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      .apply(color: formText),
                                )
                              : Text(
                                  "${widget.questions[i].reactionTimeMs / 1000} วินาที",
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      .apply(color: formText),
                                ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: widget.questions[i].isCorrect
                              ? Text(
                                  "ถูก",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      .apply(color: formText),
                                )
                              : Text(
                                  "ผิด",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      .apply(color: formText),
                                ),
                        ),
                      ]),
                  Divider(
                    color: primaryColor.withOpacity(0.3),
                    height: 25,
                    thickness: 1,
                  ),
                ]),
            ],
          )
        else
          const SizedBox(
            width: 0,
          ),
      ]),
    );
  }
}
