import 'package:flutter/material.dart';
import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/components/custom_bottom_nav_bar.dart';
import 'package:speech_stroop/enums.dart';
import 'package:speech_stroop/screens/profile/components/body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar('ข้อมูลส่วนตัว'),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
