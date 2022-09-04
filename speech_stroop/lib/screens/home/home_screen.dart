import 'package:flutter/material.dart';
import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/components/custom_bottom_nav_bar.dart';
import 'package:speech_stroop/enums.dart';
import 'package:speech_stroop/screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
      appBar: CustomAppBar('Speech Stroop', false),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
