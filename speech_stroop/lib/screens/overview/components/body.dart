import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/screens/auth/login.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => {
          Navigator.pushNamed(context, LoginScreen.routeName),
        },
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      0, deviceHeight(context) * 0.05, 0, 0),
                  child: Text(
                    'Speech Stroop',
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    deviceWidth(context) * 0.05,
                    deviceHeight(context) * 0.03,
                    deviceWidth(context) * 0.05,
                    0),
                child: const Text(
                  'แอปพลิเคชันนี้สร้างขึ้นเพื่อทดสอบและบ่งชี้ถึงประสิทธิภาพการทำงานของสมองในผู้สูงอายุ เพื่อนำไปเก็บเป็นข้อมูลสถิติภายในประเทศไทย ด้วยแบบทดสอบ Stroop ในรูปแบบเสียง ซึ่งมีความเกี่ยวข้องกับความจำและการตัดสินใจของผู้ทดสอบ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: 0.5,
                    height: 2.3,
                    color: Color(0xFF37265F),
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: const AlignmentDirectional(0, 1),
                  child: Image.asset(
                    'assets/images/overview-pink.png',
                    width: deviceWidth(context),
                    height: deviceHeight(context) * 0.55,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
