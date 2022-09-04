import 'package:flutter/material.dart';
import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/screens/stroop/result/components/body.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key key}) : super(key: key);
  static String routeName = "/result";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar('ผลการทดสอบ'),
      body: Body(),
    );
  }
}
