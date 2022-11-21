import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/components/button/floating_button.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroop_test.dart';
import 'package:speech_stroop/screens/stroop/tutorial/components/colorList_box.dart';
import 'package:speech_stroop/screens/stroop/tutorial/test/tutorial_test.dart';
import 'package:speech_stroop/theme.dart';
import 'package:speech_stroop/components/button/primary_button.dart';
import 'package:speech_stroop/screens/home/components/body.dart';

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
        appBar: CustomAppBar(
            'วิธีการทดสอบ', false, currentExperimentee.runingNumber),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'แบบทดสอบมีทั้งหมด ',
                    style: textTheme()
                        .titleMedium
                        .apply(color: Colors.black, fontSizeDelta: 2),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '3 แบบทดสอบ',
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
                    'โดยแต่ละแบบทดสอบจะประกอบด้วย ',
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
                    '60 ข้อ',
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
                    '5 วินาที',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'เมื่อจบแต่ละส่วนจะมีเวลาให้พักโดย ',
                    style: textTheme()
                        .titleMedium
                        .apply(color: Colors.black, fontSizeDelta: 2),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'ไม่กำหนดเวลา',
                    style: textTheme().titleMedium.apply(
                        color: Colors.black,
                        fontSizeDelta: 2,
                        fontWeightDelta: 1),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              PrimaryButton(
                  'แบบทดสอบต่อไป',
                  () => {
                        dstMicTest = 'tutorial',
                        Navigator.pushNamed(
                            context, TutorialTestScreen.routeName)
                      }),
              FloatingButton(() {}, true, false),
            ],
          ),
        ));
  }
}
