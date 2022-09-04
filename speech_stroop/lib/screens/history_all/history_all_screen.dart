import 'package:flutter/material.dart';
import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/components/custom_bottom_nav_bar.dart';
import 'package:speech_stroop/enums.dart';
import 'package:speech_stroop/screens/history_all/components/body.dart';

class HistoryAllScreen extends StatelessWidget {
  const HistoryAllScreen({Key key}) : super(key: key);
  static String routeName = "/history_all";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
      appBar: CustomAppBar('ประวัติการทดสอบทั้งหมด', true),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.history),
    );
  }
}
