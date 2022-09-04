import 'package:flutter/material.dart';
import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/components/button/floating_button.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/components/label_slider.dart';
import 'package:speech_stroop/screens/auth/register.dart';
import 'package:speech_stroop/theme.dart';
import '../precondition_test/introduction.dart';

class SleepRegisterScreen extends StatefulWidget {
  const SleepRegisterScreen({Key key}) : super(key: key);
  static String routeName = "/register_sleep";

  @override
  _SleepRegisterScreenState createState() => _SleepRegisterScreenState();
}

class _SleepRegisterScreenState extends State<SleepRegisterScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formGlobalKey = GlobalKey<FormState>();

  double _radioValue1 = 1;
  double _radioValue2 = 1;
  double _radioValue3 = 1;
  double _radioValue4 = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: const CustomAppBar('แบบสอบถามการนอนหลับ'),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
              child: SingleChildScrollView(
                child: Form(
                    key: formGlobalKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: Text(
                            'โปรดตอบความรู้สึกของคุณในรอบ 1 เดือนที่ผ่านมา ',
                            textAlign: TextAlign.center,
                            style: textTheme().titleLarge,
                          ),
                        ),
                        const Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Text(
                              '1. ฉันรู้สึกหลับยาก',
                              style: TextStyle(
                                color: Color(0xFF3F3F3F),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Slider(
                          activeColor: secondaryColor,
                          thumbColor: secondaryColor,
                          inactiveColor: tertiaryColor,
                          value: _radioValue1,
                          min: 1,
                          max: 4,
                          divisions: 3,
                          label: _radioValue1.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              _radioValue1 = value;
                            });
                          },
                        ),
                        LabelSlider.sleepSlider(),
                        const Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Text(
                              '2. ฉันรู้สึกตื่นง่ายเมื่อมีเสียงรบกวน',
                              style: TextStyle(
                                color: Color(0xFF3F3F3F),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Slider(
                          activeColor: secondaryColor,
                          thumbColor: secondaryColor,
                          inactiveColor: tertiaryColor,
                          value: _radioValue2,
                          min: 1,
                          max: 4,
                          divisions: 3,
                          label: _radioValue2.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              _radioValue2 = value;
                            });
                          },
                        ),
                        LabelSlider.sleepSlider(),
                        const Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Text(
                              '3. ฉันรู้สึกสดชื่นหลังตื่นนอน',
                              style: TextStyle(
                                color: Color(0xFF3F3F3F),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Slider(
                          activeColor: secondaryColor,
                          thumbColor: secondaryColor,
                          inactiveColor: tertiaryColor,
                          value: _radioValue3,
                          min: 1,
                          max: 4,
                          divisions: 3,
                          label: _radioValue3.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              _radioValue3 = value;
                            });
                          },
                        ),
                        LabelSlider.sleepSlider(),
                        const Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Text(
                              '4. ฉันรู้สึกชั่วโมงการนอนหลับของฉันเพียงพอ',
                              style: TextStyle(
                                color: Color(0xFF3F3F3F),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Slider(
                          activeColor: secondaryColor,
                          thumbColor: secondaryColor,
                          inactiveColor: tertiaryColor,
                          value: _radioValue4,
                          min: 1,
                          max: 4,
                          divisions: 3,
                          label: _radioValue4.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              _radioValue4 = value;
                            });
                          },
                        ),
                        LabelSlider.sleepSlider(),
                        Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 80, 0, 5),
                            child: FloatingButton(() async {
                              if (formGlobalKey.currentState.validate()) {
                                formGlobalKey.currentState.save();

                                userHealthScores.sleep = (_radioValue1 +
                                        _radioValue2 +
                                        _radioValue3 +
                                        _radioValue4)
                                    .toInt();
                                registerReq.healthScores = userHealthScores;

                                Navigator.pushNamed(
                                    context, IntroductionScreen.routeName);
                              }
                            })),
                      ],
                    )),
              ),
            ),
            // Expanded(
            //   child: Align(
            //     alignment: const AlignmentDirectional(0, 1),
            //     child: Image.asset(
            //       'assets/images/motivation-amico.png',
            //       width: MediaQuery.of(context).size.width,
            //       height: MediaQuery.of(context).size.height * 0.55,
            //       fit: BoxFit.fitHeight,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
