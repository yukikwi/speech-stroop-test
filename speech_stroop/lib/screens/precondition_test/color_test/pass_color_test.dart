import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/components/button/primary_button.dart';
import 'package:speech_stroop/components/loading_screen.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/model/auth.dart';
import 'package:speech_stroop/model/user.dart';
import 'package:speech_stroop/screens/auth/register.dart';
import 'package:speech_stroop/screens/home/home_screen.dart';
import 'package:speech_stroop/screens/profile/profile_screen.dart';
import 'dart:convert';

import '../../../theme.dart';

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
                  child: isLogin
                      ? PrimaryButton('กลับสู่หน้าหลัก', () {
                          Navigator.pushNamed(context, ProfileScreen.routeName);
                        })
                      : PrimaryButton('เข้าสู่หน้าหลัก', () async {
                          setState(() {
                            loading = true;
                          });

                          precondition.isPassAll = true;
                          registerReq.precondition = precondition;

                          var res = await register(registerReq);

                          setState(() {
                            loading = false;
                          });

                          //TODO: login with this user
                          if (res.statusCode == 200) {
                            auth = Auth.fromJson(jsonDecode(res.body));
                            print("login success");
                            Navigator.pushNamed(context, HomeScreen.routeName);
                          }
                        }),
                )
              ],
            ));
  }
}
