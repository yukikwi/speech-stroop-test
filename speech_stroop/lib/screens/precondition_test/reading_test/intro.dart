import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_stroop/components/button/primary_button.dart';
import 'package:speech_stroop/screens/precondition_test/reading_test/reading_test.dart';
import 'package:speech_stroop/theme.dart';

class IntroReadingTestScreen extends StatefulWidget {
  const IntroReadingTestScreen({Key key}) : super(key: key);
  static String routeName = "/precondition_intro_reading";
  @override
  _IntroReadingTestScreenState createState() => _IntroReadingTestScreenState();
}

class _IntroReadingTestScreenState extends State<IntroReadingTestScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
        key: scaffoldKey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Text(
                'การทดสอบการอ่าน',
                style: textTheme().headlineLarge,
              ),
              const SizedBox(height: 30),
              Text(
                'วิธีทดสอบ:\nพูดคำที่ปรากฏ',
                style: textTheme().headlineSmall.apply(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              PrimaryButton('เริ่มทดสอบ', () {
                Navigator.pushNamed(context, ReadingTestScreen.routeName);
              })
            ],
          ),
        ));
  }
}
