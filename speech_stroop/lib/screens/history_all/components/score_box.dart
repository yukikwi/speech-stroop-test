import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/model/badge.dart';
import 'package:speech_stroop/model/test_module/history.dart';
import 'package:speech_stroop/model/test_module/section.dart';
import 'dart:async';

import 'package:speech_stroop/screens/history_all/components/section_box.dart';
import 'package:speech_stroop/screens/history_all/components/type_score_box.dart';
import 'package:speech_stroop/utils/date_format.dart';

class ScoreBox extends StatefulWidget {
  const ScoreBox(this.historyData, {Key key}) : super(key: key);
  final History historyData;

  @override
  _ScoreBoxState createState() => _ScoreBoxState();
}

class _ScoreBoxState extends State<ScoreBox> {
  final formGlobalKey = GlobalKey<FormState>();
  bool expanded;
  bool canExpaned;
  History historyData;

  int sumCongruentScore = 0;
  int sumIncongruentScore = 0;

  void calculateTypeScore() {
    for (Section s in historyData.sections) {
      sumCongruentScore = sumCongruentScore + s.score["congruent"];
      sumIncongruentScore = sumIncongruentScore + s.score["incongruent"];
    }
  }

  @override
  void initState() {
    historyData = widget.historyData;

    calculateTypeScore();
    expanded = false;
    canExpaned = false;

    super.initState();
  }

  Widget getScoreWidget() {
    List<Widget> list = [];
    for (var s in historyData.sections) {
      list.add(Expanded(
        child: SectionBox(
            s.section,
            s.score["congruent"] + (s.score["incongruent"] ?? 0),
            s.avgReactionTimeMs),
      ));
      if (s.section != 3) {
        list.add(const SizedBox(
          width: 5,
        ));
      }
    }
    return Row(children: list);
  }

  double _getHeight() {
    double height = 130;
    if (expanded) {
      if (historyData.badge != null && historyData.badge.isNotEmpty) {
        height = 675;
      } else {
        height = 540;
      }
    }
    return height;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
      width: 800,
      height: _getHeight(),
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      decoration: BoxDecoration(
          color: softPrimaryColor, borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        Row(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "${historyData.totalScore}",
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    .apply(color: secondaryColor),
              ),
              Text(
                "คะแนนรวม",
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    .apply(color: formText),
              ),
            ]),
            const Spacer(),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(
                convertDateTime(historyData.createdAt),
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleSmall,
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
          ],
        ),
        if (canExpaned == true)
          Column(
            children: [
              Divider(
                color: primaryColor.withOpacity(0.3),
                height: 25,
                thickness: 1,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "คะแนนแต่ละส่วน",
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      .apply(color: formText),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: getScoreWidget(),
              ),
              Divider(
                color: primaryColor.withOpacity(0.3),
                height: 25,
                thickness: 1,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "คะแนนแต่ละประเภท",
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      .apply(color: formText),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Expanded(
                      child: TypeScoreBox(
                        "Congruent",
                        "สีที่แสดงตรงกับคำอ่าน",
                        sumCongruentScore,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: TypeScoreBox(
                        "Incongruent",
                        "สีที่แสดงไม่ตรงกับคำอ่าน",
                        sumIncongruentScore,
                      ),
                    ),
                  ],
                ),
              ),
              if (historyData.badge != null && historyData.badge.isNotEmpty)
                Column(
                  children: [
                    Divider(
                      color: primaryColor.withOpacity(0.3),
                      height: 25,
                      thickness: 1,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "รางวัลที่ได้รับ",
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            .apply(color: formText),
                      ),
                    ),
                  ],
                ),
              Container(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: historyData.badge != null
                    ? Row(
                        children: [
                          for (String b in historyData.badge)
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                badgesMap[b].imgPath,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                        ],
                      )
                    : null,
              ),
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
