import 'package:flutter/material.dart';
import 'package:speech_stroop/components/button/primary_button.dart';
import 'package:speech_stroop/components/loading_screen.dart';
import 'package:speech_stroop/model/badge.dart';
import 'package:speech_stroop/model/test_module/history.dart';
import 'package:speech_stroop/screens/history/components/badge_section.dart';
import 'package:speech_stroop/screens/history/components/reaction_time_chart.dart';
import 'package:speech_stroop/screens/history/components/score_chart.dart';
import 'package:speech_stroop/screens/history_all/history_all_screen.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final formGlobalKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;

  @override
  void initState() {
    loading = true;
    super.initState();
    _loadHistoryData();
  }

  _loadHistoryData() async {
    await getHistory();
    await getBadge(true);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingScreen()
        : Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Image.asset('assets/images/his_trophy.png'),
                          PrimaryButton(
                              "ดูประวัติทั้งหมด",
                              () => {
                                    Navigator.pushNamed(
                                        context, HistoryAllScreen.routeName)
                                  }),
                          ScoreChartSection(userHistory, 7), //TODO: filter date
                          ReactionTimeChartSection(userHistory, 7),
                          const BadgeSection(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
