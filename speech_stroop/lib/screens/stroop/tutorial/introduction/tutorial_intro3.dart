import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/components/button/floating_button.dart';
import 'package:speech_stroop/components/button/primary_button.dart';
import 'package:speech_stroop/components/microphone_test/microphone_test.dart';
import 'package:speech_stroop/screens/home/components/body.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroop_test.dart';
import 'package:speech_stroop/screens/stroop/tutorial/components/sliderExample_box.dart';
import 'package:speech_stroop/theme.dart';

class TutorialIntroduction3Screen extends StatefulWidget {
  const TutorialIntroduction3Screen({Key key}) : super(key: key);
  static String routeName = "/tutorial_introduction_3";
  @override
  _TutorialIntroduction3State createState() => _TutorialIntroduction3State();
}

class _TutorialIntroduction3State extends State<TutorialIntroduction3Screen> {
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
              Text(
                'เมื่อจบแต่ละส่วนจะมีเวลาให้',
                style: textTheme()
                    .titleMedium
                    .apply(color: Colors.black, fontSizeDelta: 2),
                textAlign: TextAlign.center,
              ),
              Text(
                'พักโดยไม่กำหนดเวลา',
                style: textTheme().titleMedium.apply(
                    color: Colors.black, fontWeightDelta: 1, fontSizeDelta: 2),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Text(
                'ตอนเริ่ม พัก และสิ้นสุดแบบทดสอบ จะมี',
                style: textTheme()
                    .titleMedium
                    .apply(color: Colors.black, fontSizeDelta: 2),
                textAlign: TextAlign.center,
              ),
              Text(
                'แบบสอบถามด้านความเครียดและการตื่นตัว',
                style: textTheme().titleMedium.apply(
                    color: Colors.black, fontWeightDelta: 1, fontSizeDelta: 2),
                textAlign: TextAlign.center,
              ),
              sliderExampleBox(),
              PrimaryButton(
                  'เริ่มทดลองทำ',
                  () => {
                        dstMicTest = 'tutorial',
                        Navigator.pushNamed(
                            context, MicrophoneTestScreen.routeName)
                      }),
              FloatingButton(() {}, true, false),
            ],
          ),
        ));
  }
}
