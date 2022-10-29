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
    expanded = false;
    canExpaned = false;

    super.initState();
  }

  double _getHeight() {
    double height = 50;
    if (expanded) {
      height = (height + 40) * (stroopQuestionsAmount + 1);
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
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Row(children: [
          const Spacer(flex: 1),
          Container(
            alignment: Alignment.center,
            width: 100.0,
            height: 40.0,
            child: Text(
              "ส่วนที่ ${widget.section}",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  .apply(color: Colors.black),
            ),
          ),
          const Spacer(flex: 1),
          Container(
            alignment: Alignment.center,
            width: 100.0,
            height: 40.0,
            child: Text(
              "${(widget.reactionTime / 1000).toStringAsFixed(2)} วินาที",
              style:
                  Theme.of(context).textTheme.labelSmall.apply(color: formText),
            ),
          ),
          const Spacer(flex: 4),
          Container(
            alignment: Alignment.center,
            width: 100.0,
            height: 40.0,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          ),
          const Spacer(flex: 1),
          Container(
            alignment: Alignment.center,
            width: 100.0,
            height: 40.0,
            child: Row(
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
          ),
          const Spacer(flex: 3),
          Container(
            alignment: Alignment.center,
            width: 100.0,
            height: 40.0,
            child: IconButton(
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
          ),
          const Spacer(flex: 1),
        ]),
        if (canExpaned == true)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Divider(
                color: primaryColor.withOpacity(0.3),
                height: 25,
                thickness: 3,
              ),
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
          )
        else
          const SizedBox(
            width: 0,
          ),
      ]),
    );
  }
}
