import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/components/button/floating_button.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/components/label_slider.dart';
import 'package:speech_stroop/screens/auth/register.dart';
import 'package:speech_stroop/screens/auth/register_sleep.dart';
import 'package:flutter/material.dart';
import 'package:speech_stroop/theme.dart';

class StressRegisterScreen extends StatefulWidget {
  const StressRegisterScreen({Key key}) : super(key: key);
  static String routeName = "/register_stress";

  @override
  _StressRegisterScreenState createState() => _StressRegisterScreenState();
}

int stressScore = 0;

class _StressRegisterScreenState extends State<StressRegisterScreen> {
  double _radioValue1 = 1;
  double _radioValue2 = 1;
  double _radioValue3 = 1;
  double _radioValue4 = 1;
  double _radioValue5 = 1;
  double _radioValue6 = 1;
  double _radioValue7 = 1;
  double _radioValue8 = 1;
  double _radioValue9 = 1;
  double _radioValue10 = 1;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: const CustomAppBar('แบบสอบถามด้านความเครียด'),
      body: SafeArea(
        child: Padding(
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
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          '1. บ่อยแค่ไหนที่คุณรู้สึกไม่สบายใจเพราะมีสิ่งที่เกิดขึ้นอย่างไม่คาดคิด?',
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
                      max: 5,
                      divisions: 4,
                      label: _radioValue1.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _radioValue1 = value;
                        });
                      },
                    ),
                    LabelSlider.stressSlider(),
                    const Align(
                      alignment: AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          '2. บ่อยแค่ไหนที่คุณรู้สึกว่าคุณไม่สามารถควบคุมเรื่องสำคัญ ๆ ในชีวิตของคุณได้?',
                          textAlign: TextAlign.start,
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
                      max: 5,
                      divisions: 4,
                      label: _radioValue2.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _radioValue2 = value;
                        });
                      },
                    ),
                    LabelSlider.stressSlider(),
                    const Align(
                      alignment: AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          '3. บ่อยแค่ไหนที่คุณรู้สึกกระสับกระส่าย และ ตึงเครียด?',
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
                      max: 5,
                      divisions: 4,
                      label: _radioValue3.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _radioValue3 = value;
                        });
                      },
                    ),
                    LabelSlider.stressSlider(),
                    const Align(
                      alignment: AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          '4. บ่อยแค่ไหนที่คุณรู้สึกว่าคุณควบคุมสถานการณ์ต่าง ๆ ได้?',
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
                      max: 5,
                      divisions: 4,
                      label: _radioValue4.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _radioValue4 = value;
                        });
                      },
                    ),
                    LabelSlider.stressSlider(),
                    const Align(
                      alignment: AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          '5. บ่อยแค่ไหนที่คุณรู้สึกมั่นใจในความสามารถของตนเองที่จะรับมือกับปัญหาส่วนตัวทั้งหลายได้?',
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
                      value: _radioValue5,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: _radioValue5.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _radioValue5 = value;
                        });
                      },
                    ),
                    LabelSlider.stressSlider(),
                    const Align(
                      alignment: AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          '6. บ่อยแค่ไหนที่คุณรู้สึกว่าสิ่งทั้งหลายเป็นไปในทิศทางที่คุณต้องการ?',
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
                      value: _radioValue6,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: _radioValue6.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _radioValue6 = value;
                        });
                      },
                    ),
                    LabelSlider.stressSlider(),
                    const Align(
                      alignment: AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          '7. บ่อยแค่ไหนที่คุณรู้สึกว่าคุณไม่สามารถจัดการกับสิ่งทั้งหลายทั้งที่เป็นสิ่งที่ล้วนเคยทำมาแล้ว?',
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
                      value: _radioValue7,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: _radioValue7.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _radioValue7 = value;
                        });
                      },
                    ),
                    LabelSlider.stressSlider(),
                    const Align(
                      alignment: AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          '8. บ่อยแค่ไหนที่คุณรู้สึกว่าสามารถควบคุมสิ่งทั้งหลายที่มากวนใจได้?',
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
                      value: _radioValue8,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: _radioValue8.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _radioValue8 = value;
                        });
                      },
                    ),
                    LabelSlider.stressSlider(),
                    const Align(
                      alignment: AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          '9. บ่อยแค่ไหนที่คุณโกรธอันเนื่องมาจากสิ่งที่นอกเหนือการควบคุมของคุณ?',
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
                      value: _radioValue9,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: _radioValue9.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _radioValue9 = value;
                        });
                      },
                    ),
                    LabelSlider.stressSlider(),
                    const Align(
                      alignment: AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          '10. บ่อยแค่ไหนที่คุณรู้สึกว่าปัญหาต่างๆ ทับถมมากขึ้นจนคุณไม่สามารถแก้ไขได้หมด?',
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
                      value: _radioValue10,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: _radioValue10.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _radioValue10 = value;
                        });
                      },
                    ),
                    LabelSlider.stressSlider(),
                    Text("*โปรดตรวจสอบคำตอบให้ถูกต้องและครบถ้วน",
                        style: textTheme().bodyMedium),
                    Align(
                      alignment: const AlignmentDirectional(0.9, 0),
                      child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 5),
                          child: FloatingButton(() {
                            if (formGlobalKey.currentState.validate()) {
                              formGlobalKey.currentState.save();

                              userHealthScores.stress = (_radioValue1 +
                                      _radioValue2 +
                                      _radioValue3 +
                                      _radioValue4 +
                                      _radioValue5 +
                                      _radioValue6 +
                                      _radioValue7 +
                                      _radioValue8 +
                                      _radioValue9 +
                                      _radioValue10)
                                  .toInt();

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SleepRegisterScreen()));
                            }
                          })),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
