import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/components/button/primary_button.dart';
import 'package:speech_stroop/screens/precondition_test/color_test/color_test.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroop_test.dart';

import '../../../theme.dart';

class FailColorTestScreen extends StatefulWidget {
  const FailColorTestScreen({Key key}) : super(key: key);
  static String routeName = "/precondition_fail_color";
  @override
  _FailColorTestState createState() => _FailColorTestState();
}

class _FailColorTestState extends State<FailColorTestScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
        key: scaffoldKey,
        appBar: CustomAppBar('ไม่ผ่านการทดสอบการจำแนกสี', false,
            currentExperimentee.runingNumber),
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
                'โปรดตรวจสอบระดับความสว่างและการแสดงผลหน้าจอที่มีผลต่อสี และโปรดตอบเพียงชื่อสีโดยไม่มีคำว่าสี เช่น แดง เขียว เป็นต้น',
                style: textTheme().titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 80),
              child: PrimaryButton('ทดสอบอีกครั้ง', () {
                Navigator.pushNamed(context, ColorTestScreen.routeName);
              }),
            )
          ],
        ));
  }
}
