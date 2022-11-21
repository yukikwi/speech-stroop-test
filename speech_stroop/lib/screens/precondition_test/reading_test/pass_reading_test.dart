import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/components/button/primary_button.dart';
import 'package:speech_stroop/model/user.dart';
import 'package:speech_stroop/screens/precondition_test/color_test/color_test.dart';
import 'package:speech_stroop/screens/precondition_test/color_test/intro.dart';
import 'package:speech_stroop/screens/profile/profile_screen.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroop_test.dart';

class PassReadingTestScreen extends StatefulWidget {
  const PassReadingTestScreen({Key key}) : super(key: key);
  static String routeName = "/precondition_pass_reading";
  @override
  _PassReadingTestState createState() => _PassReadingTestState();
}

class _PassReadingTestState extends State<PassReadingTestScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
        key: scaffoldKey,
        appBar: CustomAppBar(
            'ผ่านการทดสอบการอ่าน', false, currentExperimentee.runingNumber),
        body: Column(
          children: [
            Expanded(
              child: Align(
                alignment: const AlignmentDirectional(0, 1),
                child: Image.asset(
                  'assets/images/precondition-passed.png',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.55,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 80),
                child: userProfile != null
                    ? PrimaryButton('กลับสู่หน้าหลัก', () {
                        Navigator.pushNamed(context, ProfileScreen.routeName);
                      })
                    : PrimaryButton('ทำแบบทดสอบต่อไป', () {
                        Navigator.pushNamed(
                            context, IntroColorTestScreen.routeName);
                      }))
          ],
        ));
  }
}
