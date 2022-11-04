import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ScoreData {
  ScoreData(this.x, this.y);
  final String x;
  final int y;
}

class SummaryChart extends StatefulWidget {
  const SummaryChart(this.totalScore, {Key key}) : super(key: key);
  final int totalScore;

  @override
  SummaryChartState createState() => SummaryChartState();
}

class SummaryChartState extends State<SummaryChart> {
  List<ScoreData> scoreData;
  TooltipBehavior _tooltipBehavior;
  int totalScore = 0;
  List<ScoreData> getChartData() {
    final List<ScoreData> scoreData = [
      ScoreData('จำนวนข้อถูก', totalScore),
      ScoreData('จำนวนข้อผิด', stroopTotalQuestionsAmount - totalScore),
    ];
    return scoreData;
  }

  @override
  void initState() {
    totalScore = widget.totalScore;
    scoreData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SfCircularChart(
                palette: <Color>[secondaryColor, Colors.indigo[50]],
                //tooltipBehavior: TooltipBehavior(enable: true),
                // legend: Legend(
                //   isVisible: true,
                // ),
                tooltipBehavior: _tooltipBehavior,
                series: <CircularSeries>[
                  DoughnutSeries<ScoreData, String>(
                    cornerStyle: totalScore == 0 ||
                            totalScore == stroopTotalQuestionsAmount
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
                          '${(totalScore / stroopTotalQuestionsAmount * 100).round()}',
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
                          '$totalScore',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '/$stroopTotalQuestionsAmount',
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
