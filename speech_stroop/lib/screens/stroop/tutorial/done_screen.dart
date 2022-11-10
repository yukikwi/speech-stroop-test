import 'package:flutter/material.dart';

import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/components/button/primary_button.dart';
import 'package:speech_stroop/components/button/secondary_button.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/screens/home/home_screen.dart';
import 'package:speech_stroop/screens/stroop/healthRating/break_screen.dart';

class TutorialDoneScreen extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TutorialDoneScreen({Key key}) : super(key: key);
  static String routeName = "/tutorial_done";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar('เสร็จสิ้น'),
      key: scaffoldKey,
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Image.asset('assets/images/test-end2.png',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    fit: BoxFit.cover,
                    color: Colors.white.withOpacity(0.3),
                    colorBlendMode: BlendMode.modulate),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    8, 8, 8, deviceHeight(context) * 0.04),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/test-end.png',
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.5,
                          fit: BoxFit.cover),
                      PrimaryButton('เริ่มทดสอบ', () {
                        Navigator.pushNamed(context, BreakScreen.routeName);
                      }),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
