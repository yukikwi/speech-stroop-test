import 'package:flutter/material.dart';
import 'package:speech_stroop/screens/overview/components/body.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({Key key}) : super(key: key);
  static String routeName = "/overview";
  @override
  Widget build(BuildContext context) {
    //have to call it on starting screen
    //SizeConfig().init(context);
    return const Scaffold(
      body: Body(),
    );
  }
}
