import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ScoreData {
  ScoreData(this.x, this.y);
  final String x;
  final int y;
}

class TotalScore extends StatefulWidget {
  const TotalScore(this.totalSectionScore, {Key key}) : super(key: key);
  final int totalSectionScore;

  @override
  TotalScoreState createState() => TotalScoreState();
}

class TotalScoreState extends State<TotalScore> {
  List<ScoreData> scoreData;
  TooltipBehavior _tooltipBehavior;
  int totalSectionScore = 0;
  List<ScoreData> getChartData() {
    final List<ScoreData> scoreData = [
      // ScoreData('congruent', widget.congruent),
      // ScoreData('incongruent', widget.inCongruent),
      ScoreData('จำนวนข้อถูก', totalSectionScore),
      ScoreData('จำนวนข้อผิด', stroopQuestionsAmount - totalSectionScore),
    ];
    return scoreData;
  }

  @override
  void initState() {
    totalSectionScore = widget.totalSectionScore;
    scoreData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SfCircularChart(
                palette: <Color>[
                  secondaryColor,
                  //primaryColor,
                  Colors.indigo[50]
                ],
                //tooltipBehavior: TooltipBehavior(enable: true),
                // legend: Legend(
                //   isVisible: true,
                // ),
                tooltipBehavior: _tooltipBehavior,
                series: <CircularSeries>[
                  DoughnutSeries<ScoreData, String>(
                    cornerStyle: totalSectionScore == 0 ||
                            totalSectionScore == stroopQuestionsAmount
                        ? CornerStyle.bothFlat
                        : CornerStyle.bothCurve,
                    radius: "120",
                    innerRadius: "100.0",
                    dataSource: scoreData,
                    xValueMapper: (ScoreData data, _) => data.x,
                    yValueMapper: (ScoreData data, _) => data.y,
                  ),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      'คะแนนรวม',
                      style: TextStyle(
                        color: primaryColor.withOpacity(0.4),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${(totalSectionScore / stroopQuestionsAmount * 100).round()}',
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '%',
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$totalSectionScore',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '/$stroopQuestionsAmount',
                          style: TextStyle(
                            color: primaryColor.withOpacity(0.4),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
