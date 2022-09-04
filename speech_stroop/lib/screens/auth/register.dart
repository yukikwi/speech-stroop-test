import 'package:flutter/material.dart';
import 'package:speech_stroop/components/loading_screen.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/model/auth.dart';
import 'package:http/http.dart' as http;

import 'package:speech_stroop/screens/auth/components/text_form_field.dart';
import 'package:speech_stroop/screens/auth/register2.dart';

import 'package:speech_stroop/components/button/floating_button.dart';
import 'package:speech_stroop/components/custom_appbar.dart';

import 'package:speech_stroop/model/precondition.dart';
import 'package:speech_stroop/model/user.dart';
import 'package:speech_stroop/theme.dart';

UserHealthScore userHealthScores = UserHealthScore(0, 0);
PreconditionScore colorVisibilityTest = PreconditionScore(0, DateTime.now());
PreconditionScore readingAbilityTest = PreconditionScore(0, DateTime.now());
Precondition precondition =
    Precondition(true, colorVisibilityTest, readingAbilityTest, false);
User registerReq = User('', '', '', '', '', '', DateTime.now(), '', '',
    userHealthScores, precondition);

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);
  static String routeName = "/register_1";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formGlobalKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;

  TextEditingController telController;
  TextEditingController passwordController;
  TextEditingController confirmPasswordController;
  bool passwordVisibility;
  bool confirmPasswordVisibility;

  String validateTel = '';

  @override
  void initState() {
    loading = false;
    super.initState();
    telController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
    confirmPasswordController = TextEditingController();
    confirmPasswordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingScreen()
        : Form(
            key: formGlobalKey,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              key: scaffoldKey,
              appBar: const CustomAppBar('สมัครสมาชิก'),
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        deviceWidth(context) * 0.03,
                        deviceHeight(context) * 0.02,
                        deviceWidth(context) * 0.03,
                        0),
                    // padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              """การสมัครสมาชิกจะประกอบไปด้วย 
            • การกรอกข้อมูลสำหรับเข้าสู่ระบบ
            • การกรอกข้อมูลเบื้องต้น
            • การกรอกข้อมูลด้านความเครียด
            • การกรอกข้อมูลด้านการนอนหลับ
            • การเตรียมความพร้อมก่อนทดสอบ""",
                              style: TextStyle(fontSize: 16, height: 2.0),
                            )),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0, deviceHeight(context) * 0.02, 0, 0),
                          // padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: TextFormFieldCustom(
                            telController,
                            'เบอร์โทรศัพท์',
                            TextInputType.phone,
                            (val) {
                              //TODO: check if it's already been used
                              if (val.isEmpty) {
                                return 'โปรดระบุเบอร์โทรศัพท์';
                              }
                              if (val.length != 10) {
                                return 'เบอร์โทรศัพท์ประกอบไปด้วย 10 ตัวอักษร';
                              }
                              if (int.tryParse(val) == null) {
                                return 'โปรดกรอกตัวเลขเท่านั้น';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0, deviceHeight(context) * 0.02, 0, 0),
                          // padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: !passwordVisibility,
                            decoration: InputDecoration(
                              labelText: 'รหัสผ่าน',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFFA7A5A5),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFFA7A5A5),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () =>
                                      passwordVisibility = !passwordVisibility,
                                ),
                                child: Icon(
                                  passwordVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: const Color(0xFF757575),
                                  size: 22,
                                ),
                              ),
                            ),
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            validator: (val) {
                              if (val.length >= 8) {
                                return null;
                              } else {
                                return 'รหัสผ่านต้องมีความยาวอย่างน้อย 8 ตัวอักษร';
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0,
                              deviceHeight(context) * 0.02,
                              0,
                              deviceHeight(context) * 0.2),
                          // padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 140),
                          child: TextFormField(
                            controller: confirmPasswordController,
                            obscureText: !confirmPasswordVisibility,
                            decoration: InputDecoration(
                              labelText: 'ยืนยันรหัสผ่าน',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFFA7A5A5),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFFA7A5A5),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => confirmPasswordVisibility =
                                      !confirmPasswordVisibility,
                                ),
                                child: Icon(
                                  confirmPasswordVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: const Color(0xFF757575),
                                  size: 22,
                                ),
                              ),
                            ),
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            validator: (val) {
                              if (val == passwordController.text) {
                                return null;
                              } else {
                                return 'ยืนยันรหัสผ่านไม่ถูกต้อง';
                              }
                            },
                          ),
                        ),
                        Text(
                          validateTel,
                          style: textTheme().bodyMedium.apply(
                                color: const Color(0xFFDA4F2C),
                              ),
                        ),
                        // Align(
                        //     alignment: const AlignmentDirectional(0.9, 0),
                        // child:
                        // Stack(children: [
                        //   Positioned(
                        //     top: 50,
                        //     bottom: 80,
                        //     left: 50,
                        //     right: 20,
                        //     child:
                        FloatingButton(() async {
                          if (formGlobalKey.currentState.validate()) {
                            formGlobalKey.currentState.save();
                            setState(() {
                              loading = true;
                            });
                            if (await isTelNotExists(telController.text)) {
                              if (passwordController.text ==
                                  confirmPasswordController.text) {
                                setUserData();
                                setState(() {
                                  loading = false;
                                });

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Register2Screen()));
                              }
                            } else {
                              setState(() {
                                loading = false;
                                validateTel =
                                    'เบอร์โทรศัพท์นี้ถูกใช้แล้ว โปรดใช้เบอร์โทรศัพท์อื่น';
                              });
                            }
                          }
                        }),
                        // ),
                        // ])
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Future<bool> isTelNotExists(String tel) async {
    http.Response user = await getUserByTel(tel);

    return user.body == "null" ? true : false;
  }

  setUserData() {
    registerReq.tel = telController.text;
    registerReq.password = passwordController.text;
  }
}
