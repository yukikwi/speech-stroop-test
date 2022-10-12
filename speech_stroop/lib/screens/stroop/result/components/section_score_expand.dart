import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/utils/date_format.dart';

class SectionScoreExpand extends StatefulWidget {
  const SectionScoreExpand(this.section, this.score, this.reactionTime,
      {Key key})
      : super(key: key);
  final int section;
  final int score;
  final double reactionTime;

  @override
  _SectionScoreExpandState createState() => _SectionScoreExpandState();
}

class _SectionScoreExpandState extends State<SectionScoreExpand> {
  final formGlobalKey = GlobalKey<FormState>();
  // int section;
  // int score;
  // double reactionTime;

  bool expanded;
  bool canExpaned;

  @override
  void initState() {
    expanded = false;
    canExpaned = false;

    super.initState();
  }

  double _getHeight() {
    double height = 130;
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
      width: 800,
      height: _getHeight(),
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      decoration: BoxDecoration(
          color: softPrimaryColor, borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
          const Spacer(),
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
                child: Row(children: [
                  Text("data"),
                  Text("data"),
                ]), //TODO: this is mock data
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
