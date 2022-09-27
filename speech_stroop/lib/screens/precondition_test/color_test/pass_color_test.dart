import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/components/button/primary_button.dart';
import 'package:speech_stroop/components/loading_screen.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/model/user.dart';

import '../../../components/microphone_test/microphone_test.dart';
import '../../../theme.dart';
import '../../../utils/directory.dart';
import '../../../utils/permission.dart';
import '../../auth/experimental_settoken.dart';
import "package:speech_stroop/utils/no_import.dart"
    if (dart.library.html) "dart:html";

import '../../stroop/tutorial/test/tutorial_test.dart';

class PassColorTestScreen extends StatefulWidget {
  const PassColorTestScreen({Key key}) : super(key: key);
  static String routeName = "/precondition_pass_color";
  @override
  _PassColorTestState createState() => _PassColorTestState();
}

class _PassColorTestState extends State<PassColorTestScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;

  bool isLogin = (userProfile != null);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return loading
        ? LoadingScreen()
        : Scaffold(
            key: scaffoldKey,
            appBar: const CustomAppBar('ผ่านการทดสอบการจำแนกสี'),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: isLogin
                      ? null
                      : Text('ยินดีด้วย!',
                          style: textTheme()
                              .displayMedium
                              .apply(color: secondaryColor)),
                ),
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
                  padding: const EdgeInsets.all(10.0),
                  child: isLogin
                      ? null
                      : Text('ลงทะเบียนเสร็จสิ้น',
                          style: textTheme().headlineMedium),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 80),
                  child: PrimaryButton('เริ่มการทำแบบทดสอบ', () async {
                    setState(() {
                      loading = true;
                    });

                    precondition.isPassAll = true;
                    await startTest();
                    if (!mounted) return;
                    // TODO: teach how to do speech stroop test before go to tutorial test
                    Navigator.pushNamed(context, TutorialTestScreen.routeName);
                  }),
                )
              ],
            ));
  }

  startTest() async {
    if (!kIsWeb) {
      await getDir();
      await requsetPermission(Permission.microphone);
    } else {
      try {
        if (window != null)
          await window.navigator.mediaDevices.getUserMedia({"audio": true});
      } on Exception catch (_) {
        print('this method is for web only');
      }
    }
  }
}
