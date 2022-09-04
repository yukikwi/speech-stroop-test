import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/model/test_module/history.dart';
import 'package:speech_stroop/utils/date_format.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReactionTimeChartSection extends StatefulWidget {
  const ReactionTimeChartSection(this.historyData, this.range, {Key key})
      : super(key: key);
  final List<History> historyData;
  final int range;

  @override
  _ReactionTimeChartSectionState createState() =>
      _ReactionTimeChartSectionState();
}

class _ReactionTimeChartSectionState extends State<ReactionTimeChartSection> {
  final formGlobalKey = GlobalKey<FormState>();
  List<ReactionTimeChartData> scoreChartData;

  double avgReactionTimePerWeek = 0.0;
  int testedDays = 0;

  @override
  void initState() {
    scoreChartData = getReactionTimeChartData(widget.historyData, widget.range);
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
              "กราฟเวลาตอบสนอง",
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
                          labelStyle:
                              Theme.of(context).textTheme.labelLarge.apply(
                                    color: formText,
                                  ),
                        ),
                        primaryYAxis: NumericAxis(
                          minimum: 0,
                          maximum: 3, //TODO: use const
                          interval: 0.5,
                          labelStyle:
                              Theme.of(context).textTheme.labelLarge.apply(
                                    color: formText,
                                  ),
                        ),
                        series: <ChartSeries<ReactionTimeChartData, String>>[
                          ColumnSeries<ReactionTimeChartData, String>(
                            dataSource: scoreChartData,
                            xValueMapper: (ReactionTimeChartData data, _) =>
                                data.x,
                            yValueMapper: (ReactionTimeChartData data, _) =>
                                data.y,
                            color: secondaryColor,
                            width: 0.5,
                            borderRadius: BorderRadius.circular(15),
                            enableTooltip: true,
                          ),
                        ],
                        plotAreaBorderWidth: 0,
                      ),
                    ),
                  ]),
            )
          ]),
    );
  }
}

///  x = date, y = average reaction time
class ReactionTimeChartData {
  ReactionTimeChartData(this.x, this.y);

  final String x;
  final double y;
}

List<ReactionTimeChartData> getReactionTimeChartData(
  List<History> historyData,
  int range,
) {
  List<ReactionTimeChartData> data = [];
  double avgPerDay = 0;
  double sumPerDay = 0;
  double avgPerTest = 0;
  int countTestPerDay = 0;
  int diff = 0;

  if (historyData != null && historyData.isNotEmpty && historyData[0] != null) {
    String currDate = convertDateTime(historyData[0].createdAt);
    String prevDate = currDate;
    String chartDate = currDate;

    for (int i = 0; i < historyData.length; i++) {
      History h = historyData[i];
      currDate = convertDateTime(h.createdAt);

      // calculate avg reaction time per test
      List<double> reactionTimes =
          h.sections.map((s) => s.avgReactionTimeMs).toList();

      avgPerTest = calAvgReactionTimePerTest(reactionTimes);

      if (prevDate == currDate) {
        countTestPerDay++;
        sumPerDay += avgPerTest;
        chartDate = currDate;
      } else {
        diff++;
        chartDate = prevDate;

        // calculate avg reaction time per day
        avgPerDay = sumPerDay / countTestPerDay;
        data.add(ReactionTimeChartData(chartDate, avgPerDay));

        // clear
        countTestPerDay = 0;
        sumPerDay = 0;

        countTestPerDay++;
        sumPerDay += avgPerTest;
      }

      // last data
      if (i == historyData.length - 1 || diff == range - 1) {
        diff++;
        // calculate avg reaction time per day
        chartDate = currDate;
        avgPerDay = sumPerDay / countTestPerDay;
        data.add(ReactionTimeChartData(chartDate, avgPerDay));
        break;
      }
      prevDate = currDate;
    }
  }
  data = data.reversed.toList();
  for (var d in data) {
    print("x: ${d.x}, rt: ${d.y}");
  }
  return data;
}

/// reactionTimes in millisecond unit
double calAvgReactionTimePerTest(List<double> reactionTimes) {
  double avg = 0;
  List<double> nonZero = [];

  nonZero = reactionTimes.where((rt) => rt != null && rt > 0).toList();

  if (nonZero.isNotEmpty) {
    var sum = nonZero.reduce((value, element) => value + element) / 1000;
    avg = sum / nonZero.length;
  }
  return avg;
}
