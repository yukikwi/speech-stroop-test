import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/components/button/primary_button.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/screens/precondition_test/reading_test/reading_test.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroop_test.dart';
import 'package:speech_stroop/theme.dart';

class FailReadingTestScreen extends StatefulWidget {
  const FailReadingTestScreen({Key key}) : super(key: key);
  static String routeName = "/precondition_fail_reading";
  @override
  _FailReadingTestState createState() => _FailReadingTestState();
}

class _FailReadingTestState extends State<FailReadingTestScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
        key: scaffoldKey,
        appBar: CustomAppBar(
            'ไม่ผ่านการทดสอบการอ่าน', false, currentExperimentee.runingNumber),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('เสียใจด้วย',
                  style:
                      textTheme().displayMedium.apply(color: secondaryColor)),
            ),
            Expanded(
              child: Align(
                alignment: const AlignmentDirectional(0, 1),
                child: Image.asset(
                  'assets/images/precondition-failed.png',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.55,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 80),
              child: PrimaryButton('ทดสอบอีกครั้ง', () {
                Navigator.pushNamed(context, ReadingTestScreen.routeName);
              }),
            )
          ],
        ));
  }
}
