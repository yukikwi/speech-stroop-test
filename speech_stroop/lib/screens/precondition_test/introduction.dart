import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/components/button/primary_button.dart';
import 'package:speech_stroop/screens/precondition_test/components/precon_box.dart';
import 'package:speech_stroop/screens/precondition_test/reading_test/intro.dart';
import 'package:speech_stroop/screens/precondition_test/reading_test/reading_test.dart';
import 'package:speech_stroop/theme.dart';

import '../../constants.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key key}) : super(key: key);
  static String routeName = "/precondition_introduction";
  @override
  _IntroductionState createState() => _IntroductionState();
}

class _IntroductionState extends State<IntroductionScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
        key: scaffoldKey,
        appBar: const CustomAppBar('เตรียมความพร้อมก่อนทดสอบ'),
        body: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(deviceWidth(context) * 0.025,
              0, deviceWidth(context) * 0.025, deviceHeight(context) * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 30),
              Text(
                'แบบทดสอบนี้ทำขึ้นเพื่อให้มั่นใจว่าคุณสามารถที่จะทำแบบทดสอบ Stroop test ได้อย่างไม่มีเงื่อนไขใด ๆ โดยเป็นการทำเพียงครั้งเดียวหลังการสมัครสมาชิก หากต้องการทำแบบทดสอบอีกครั้งสามารถเลือกทำได้ในหน้าโปรไฟล์ \nซึ่งการเตรียมความพร้อมก่อนการทดสอบ Stroop test จะประกอบไปด้วยการทดสอบที่จำเป็นต้องให้อนุญาตการเข้าถึงไมโครโฟน และใช้เสียงพูดในการตอบ ซึ่งผู้ทดสอบจะต้องตอบเพียงชื่อสีโดยไม่มีคำว่า สี เช่น แดง เขียว เป็นต้น',
                style: textTheme().bodyLarge.apply(color: Colors.black),
              ),
              const SizedBox(height: 50),
              // Wrap(
              //   direction: Axis.vertical,
              //   spacing: 25,
              //   children: [
              //     PreconBox('1. ทดสอบทักษะการอ่าน', 'พูดคำที่ปรากฏ'),
              //     PreconBox('2. ทดสอบทักษะการจำแนกสี', 'พูดสีที่ปรากฏ')
              //   ],
              // ),
              const SizedBox(height: 50),
              PrimaryButton('เริ่มการเตรียมความพร้อม', () {
                Navigator.pushNamed(context, IntroReadingTestScreen.routeName);
              })
            ],
          ),
        ));
  }
}
