import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/model/test_module/history.dart';
import 'package:speech_stroop/utils/date_format.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ScoreChartSection extends StatefulWidget {
  const ScoreChartSection(this.historyData, this.range, {Key key})
      : super(key: key);
  final List<History> historyData;
  final int range;

  @override
  _ScoreChartSectionState createState() => _ScoreChartSectionState();
}

class _ScoreChartSectionState extends State<ScoreChartSection> {
  final formGlobalKey = GlobalKey<FormState>();
  List<ScoreChartData> chartData;
  int avgScorePerWeek = 0;
  int testedDays = 0;
  List<ScoreChartData> scoreChartData;
  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    scoreChartData = getScoreChartData(widget.historyData, widget.range);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "กราฟคะแนนย้อนหลัง",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: softPrimaryColor,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.fromLTRB(30, 40, 30, 25),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 400,
                      child: SfCartesianChart(
                        tooltipBehavior: TooltipBehavior(enable: true),
                        primaryXAxis: CategoryAxis(
                          labelRotation: 60,
                          maximumLabels: widget.range,
                          labelStyle:
                              Theme.of(context).textTheme.labelLarge.apply(
                                    color: formText,
                                  ),
                        ),
                        primaryYAxis: NumericAxis(
                          minimum: 0,
                          maximum: 100,
                          interval: 10,
                          labelStyle:
                              Theme.of(context).textTheme.labelLarge.apply(
                                    color: formText,
                                  ),
                        ),
                        series: scoreChartData.isNotEmpty
                            ? <ChartSeries<ScoreChartData, String>>[
                                ColumnSeries<ScoreChartData, String>(
                                  dataSource: scoreChartData,
                                  xValueMapper: (ScoreChartData data, _) =>
                                      data.x,
                                  yValueMapper: (ScoreChartData data, _) =>
                                      data.y,
                                  color: secondaryColor,
                                  width: 0.5,
                                  borderRadius: BorderRadius.circular(15),
                                  enableTooltip: true,
                                ),
                              ]
                            : null,
                        plotAreaBorderWidth: 0,
                      ),
                    ),
                  ]),
            )
          ]),
    );
  }
}

///  x = date, y = percent score
class ScoreChartData {
  ScoreChartData(this.x, this.y);

  final String x;
  final double y;
}

List<ScoreChartData> getScoreChartData(List<History> historyData, int range) {
  List<ScoreChartData> data = [];
  double percentAvgScorePerDay = 0.0;
  int sumPerDay = 0;
  int countTestPerDay = 0;
  int diff = 0;
  if (historyData != null && historyData.isNotEmpty && historyData[0] != null) {
    String currDate = convertDateTime(historyData[0].createdAt);
    String prevDate = currDate;
    String chartDate = currDate;

    for (int i = 0; i < historyData.length; i++) {
      History h = historyData[i];
      currDate = convertDateTime(h.createdAt);

      if (prevDate == currDate) {
        countTestPerDay++;
        sumPerDay += h.totalScore;
        chartDate = currDate;
      } else {
        diff++;
        chartDate = prevDate;

        // calculate avg score per day
        percentAvgScorePerDay = _calPercentAvgScore(
            sumPerDay, countTestPerDay, stroopTotalQuestionsAmount);
        data.add(ScoreChartData(chartDate, percentAvgScorePerDay));

        // clear
        countTestPerDay = 0;
        sumPerDay = 0;

        countTestPerDay++;
        sumPerDay += h.totalScore;
      }

      // last data
      if (i == historyData.length - 1 || diff == range - 1) {
        diff++;
        // calculate avg score per day
        chartDate = currDate;
        percentAvgScorePerDay = _calPercentAvgScore(
            sumPerDay, countTestPerDay, stroopTotalQuestionsAmount);
        data.add(ScoreChartData(chartDate, percentAvgScorePerDay));
        break;
      }
      prevDate = currDate;
    }
  }

  data = data.reversed.toList();
  for (var d in data) {
    print("x: ${d.x}, score: ${d.y}");
  }
  return data;
}

double _calPercentAvgScore(int sum, int count, int max) {
  double percentAvg = 0.0;
  double avg = 0.0;
  avg = (sum / count);
  percentAvg = avg / max * 100;
  return percentAvg;
}
