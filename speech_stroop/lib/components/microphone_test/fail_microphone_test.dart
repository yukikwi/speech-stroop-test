import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/components/button/primary_button.dart';
import 'package:speech_stroop/screens/auth/register.dart';
import 'package:speech_stroop/screens/precondition_test/color_test/color_test.dart';
import 'package:speech_stroop/screens/precondition_test/reading_test/reading_test.dart';
import 'package:speech_stroop/theme.dart';

class FailMicrophoneTestScreen extends StatefulWidget {
  const FailMicrophoneTestScreen({Key key}) : super(key: key);
  static String routeName = "/precondition_fail_microphone";
  @override
  _FailMicrophoneTestState createState() => _FailMicrophoneTestState();
}

class _FailMicrophoneTestState extends State<FailMicrophoneTestScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
        key: scaffoldKey,
        appBar: const CustomAppBar('โปรดตรวจสอบไมโครโฟน'),
        body: Column(
          children: [
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
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'โปรดตรวจสอบการเข้าถึงไมโครโฟนภายในการตั้งค่าอุปกรณ์ของคุณ และทำการทดสอบในสถานที่ที่ไม่มีเสียงรบกวน',
                style: textTheme().titleLarge,
              ),
            ),
            //TODO: (optional) add button to ask user for the microphone permission again
            // Padding(
            //   padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
            //   child: SecondaryButton('ให้อนุญาตการเข้าถึงไมโครโฟน', () async {
            //     await Permission.microphone.request();
            //   }),
            // ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 80),
              child: PrimaryButton('ทดสอบอีกครั้ง', () {
                (precondition.readingAbilityTest.score != 7)
                    ? Navigator.pushNamed(context, ReadingTestScreen.routeName)
                    : Navigator.pushNamed(context, ColorTestScreen.routeName);
              }),
            )
          ],
        ));
  }
}
