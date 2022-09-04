import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/components/button/floating_button.dart';
import 'package:speech_stroop/screens/stroop/tutorial/components/colorList_box.dart';
import 'package:speech_stroop/screens/stroop/tutorial/introduction/tutorial_intro3.dart';
import 'package:speech_stroop/theme.dart';

class TutorialIntroduction2Screen extends StatefulWidget {
  const TutorialIntroduction2Screen({Key key}) : super(key: key);
  static String routeName = "/tutorial_introduction_2";
  @override
  _TutorialIntroduction2State createState() => _TutorialIntroduction2State();
}

class _TutorialIntroduction2State extends State<TutorialIntroduction2Screen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
        key: scaffoldKey,
        appBar: const CustomAppBar('วิธีการทดสอบ'),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'แบบทดสอบจะแบ่งเป็น ',
                    style: textTheme()
                        .titleMedium
                        .apply(color: Colors.black, fontSizeDelta: 2),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '3 ส่วน',
                    style: textTheme().titleMedium.apply(
                        color: Colors.black,
                        fontSizeDelta: 2,
                        fontWeightDelta: 1),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ส่วนละ ',
                    style: textTheme()
                        .titleMedium
                        .apply(color: Colors.black, fontSizeDelta: 2),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '20 ข้อ',
                    style: textTheme().titleMedium.apply(
                        color: Colors.black,
                        fontSizeDelta: 2,
                        fontWeightDelta: 1),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    ' ข้อละ ',
                    style: textTheme()
                        .titleMedium
                        .apply(color: Colors.black, fontSizeDelta: 2),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '2.5 วินาที',
                    style: textTheme().titleMedium.apply(
                        color: Colors.black,
                        fontSizeDelta: 2,
                        fontWeightDelta: 1),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'โดยใช้สีทั้งหมด ',
                    style: textTheme()
                        .titleMedium
                        .apply(color: Colors.black, fontSizeDelta: 2),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '7 สี',
                    style: textTheme().titleMedium.apply(
                        color: Colors.black,
                        fontSizeDelta: 2,
                        fontWeightDelta: 1),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              colorListBox(),
              FloatingButton(() {
                Navigator.pushNamed(
                    context, TutorialIntroduction3Screen.routeName);
              }),
            ],
          ),
        ));
  }
}
