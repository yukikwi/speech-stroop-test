import 'package:flutter/material.dart';
import 'package:speech_stroop/components/loading_screen.dart';
import 'package:speech_stroop/model/auth.dart';
import 'package:speech_stroop/model/update_user.dart';
import 'package:speech_stroop/model/user.dart';
import 'package:speech_stroop/screens/auth/login.dart';
import 'package:speech_stroop/screens/home/components/body.dart';
import 'package:speech_stroop/screens/profile/components/precondition_box.dart';
import 'package:speech_stroop/screens/profile/components/profile_form.dart';
import 'package:speech_stroop/screens/profile/components/profile_pic.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  UpdateUser updateUser = UpdateUser(
    tel: userProfile.tel,
    name: userProfile.name,
    email: userProfile.email,
    dateOfBirth: userProfile.dateOfBirth,
    gender: userProfile.gender,
    education: userProfile.education,
    precondition: userProfile.precondition,
  );
  @override
  void initState() {
    getUserProfile(false);
    updateUser = UpdateUser(
      tel: userProfile.tel,
      username: userProfile.username,
      name: userProfile.name,
      surname: userProfile.surname,
      email: userProfile.email,
      dateOfBirth: userProfile.dateOfBirth,
      gender: userProfile.gender,
      education: userProfile.education,
      precondition: userProfile.precondition,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingScreen()
        : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
                child: Column(
              children: [
                const ProfilePic(),
                const SizedBox(height: 20),
                Text(
                  userProfile.username,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
                ),
                const SizedBox(height: 5),
                ProfileForm(updateUser),
                const SizedBox(height: 30),
                PreconditionBox("ทดสอบการจำแนกสี",
                    userProfile.precondition.colorVisibilityTest),
                PreconditionBox("ทดสอบการอ่าน",
                    userProfile.precondition.readingAbilityTest),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () async {
                    print('log out');
                    setState(() {
                      loading = true;
                    });
                    await logout();
                    userName = '';
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: Text(
                    'ออกจากระบบ',
                    style: Theme.of(context).textTheme.titleMedium.apply(
                          color: Colors.red,
                          decoration: TextDecoration.underline,
                        ),
                  ),
                )
              ],
            )));
  }
}
