import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/components/button/primary_button.dart';
import 'package:speech_stroop/model/test_module/health_scores.dart';
import 'package:speech_stroop/screens/stroop/healthRating/components/health_slider.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroop_test.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/components/body.dart';
import 'package:speech_stroop/theme.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroopHelper/speech_check.dart';
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
    print("Body_Break loaded");
    super.initState();
  }

  void startQuiz() {
    sectionNumber++;
    answered = -1;
    switch (sectionNumber) {
      case 2:
        stress.break1 = stressLevel.toInt();
        arousel.break1 = arouselLevel.toInt();
        break;
      case 3:
        stress.break2 = stressLevel.toInt();
        arousel.break2 = arouselLevel.toInt();
        break;
      default:
        break;
    }
    healthScores = HealthScores(stress, arousel);

    Navigator.pushNamed(context, StroopTestScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      appBar: CustomAppBar(appbarTitle),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      key: scaffoldKey,
      body: SafeArea(
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          const HealthSlider(),
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
              'เริ่มแบบทดสอบที่ ${sectionNumber + 1}', () => startQuiz())
        ]),
      ),
    );
  }
}
