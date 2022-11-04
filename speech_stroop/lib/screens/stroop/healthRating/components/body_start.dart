import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/components/button/primary_button.dart';
import 'package:speech_stroop/model/test_module/health_scores.dart';
import 'package:speech_stroop/screens/stroop/healthRating/components/health_slider.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroop_test.dart';
import 'package:speech_stroop/theme.dart';
import 'package:speech_stroop/utils/permission.dart';

class Body extends StatefulWidget {
  final String appbarTitle;
  Body(this.appbarTitle, {Key key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState(appbarTitle);
}

class _BodyState extends State<Body> {
  final String appbarTitle;
  _BodyState(this.appbarTitle);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  void startQuiz() {
    print("startQuiz called");
    sectionNumber++;
    answered = -1;

    // await requsetPermission(Permission.microphone);
    if (!kIsWeb) {
      recordAudio.getRecorderFn()();
    }
    Navigator.pushNamed(context, StroopTestScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      appBar: CustomAppBar(appbarTitle, true),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      key: scaffoldKey,
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Text("ถ้าพร้อมแล้ว...",
                    style: textTheme().headlineMedium.apply(
                          color: const Color(0xFF3F3F3F),
                        )),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                    'เริ่มแบบทดสอบที่ ${feedbackNumber + 1} ส่วนที่ ${sectionNumber + 1}',
                    () => startQuiz())
              ]),
        ),
      ),
    );
  }
}
