import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/model/test_module/history.dart';
import 'package:speech_stroop/utils/date_format.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SectionLatesScoreChart extends StatefulWidget {
  const SectionLatesScoreChart(this.historyData, this.range, {Key key})
      : super(key: key);
  final List<History> historyData;
  final int range;

  @override
  _SectionLatesScoreChartState createState() => _SectionLatesScoreChartState();
}

class _SectionLatesScoreChartState extends State<SectionLatesScoreChart> {
  final formGlobalKey = GlobalKey<FormState>();
  List<ScoreChartData> chartData;
  int avgScorePerWeek = 0;
  int testedDays = 0;
  List<ScoreChartData> scoreChartData;

  @override
  void initState() {
    scoreChartData = getScoreChartData(widget.historyData, widget.range);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 0, 5),
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
              height: 5,
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
                                  borderRadius: BorderRadius.circular(20),
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

class ScoreChartData {
  ScoreChartData(this.x, this.y);

  final String x; // date
  final int y; // percent score
}

List<ScoreChartData> getScoreChartData(List<History> historyData, int range) {
  List<ScoreChartData> data = [];
  if (historyData != null && historyData.isNotEmpty) {
    for (History h in historyData) {
      if (data.length == range) {
        break;
      }
      data.add(ScoreChartData(convertDateTime(h.createdAt), h.totalScore));
    }
    //TODO: fix same day
  }
  data = data.reversed.toList();
  return data;
}
