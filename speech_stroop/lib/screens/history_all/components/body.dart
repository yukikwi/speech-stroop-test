import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/model/test_module/history.dart';
import 'package:speech_stroop/screens/history_all/components/score_box.dart';
import 'package:speech_stroop/theme.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (userHistory.isNotEmpty) ...[
                        for (History history in userHistory) ScoreBox(history)
                      ] else ...[
                        Column(
                          children: [
                            Image.asset(
                              'assets/images/empty_data.png',
                            ),
                            Text(
                              "ยังไม่มีประวัติการทดสอบ",
                              style:
                                  textTheme().bodyMedium.apply(color: formText),
                            )
                          ],
                        )
                      ]
                    ],
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
