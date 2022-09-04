import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_stroop/components/button/primary_button.dart';
import 'package:speech_stroop/screens/precondition_test/color_test/color_test.dart';
import 'package:speech_stroop/theme.dart';

class IntroColorTestScreen extends StatefulWidget {
  const IntroColorTestScreen({Key key}) : super(key: key);
  static String routeName = "/precondition_intro_color";
  @override
  _IntroColorTestScreenState createState() => _IntroColorTestScreenState();
}

class _IntroColorTestScreenState extends State<IntroColorTestScreen> {
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
                'การทดสอบการจำแนกสี',
                style: textTheme().headlineLarge,
              ),
              const SizedBox(height: 30),
              Text(
                'วิธีการทดสอบ:\n พูดสีที่ปรากฏบนกล่องสี่เหลี่ยม',
                style: textTheme().headlineSmall.apply(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              PrimaryButton('เริ่มทดสอบ', () {
                Navigator.pushNamed(context, ColorTestScreen.routeName);
              })
            ],
          ),
        ));
  }
}
