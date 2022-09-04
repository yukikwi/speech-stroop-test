import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_stroop/components/label_slider.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/screens/home/components/body.dart';

class HealthSlider extends StatefulWidget {
  const HealthSlider({Key key}) : super(key: key);
  @override
  HealthSliderState createState() => HealthSliderState();
}

double stressLevel = 1;
double arouselLevel = 1;

class HealthSliderState extends State<HealthSlider> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    stressLevel = 1;
    arouselLevel = 1;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Column(children: [
      Align(
        alignment: const AlignmentDirectional(-1, 0),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
          child: Text(
            'คุณ $userName รู้สึกเครียดอยู่ระดับไหน?',
            style: const TextStyle(
              color: Color(0xFF3F3F3F),
              fontSize: 16,
            ),
          ),
        ),
      ),
      Slider(
        activeColor: secondaryColor,
        thumbColor: secondaryColor,
        inactiveColor: tertiaryColor,
        value: stressLevel,
        min: 1,
        max: 4,
        divisions: 3,
        label: stressLevel.round().toString(),
        onChanged: (double value) {
          setState(() {
            stressLevel = value;
          });
        },
      ),
      LabelSlider.healthStressSlider(),
      Align(
        alignment: const AlignmentDirectional(-1, 0),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
          child: Text(
            'คุณ $userName รู้สึกตื่นตัวอยู่ระดับไหน?',
            style: const TextStyle(
              color: Color(0xFF3F3F3F),
              fontSize: 16,
            ),
          ),
        ),
      ),
      Slider(
        activeColor: secondaryColor,
        thumbColor: secondaryColor,
        inactiveColor: tertiaryColor,
        value: arouselLevel,
        min: 1,
        max: 4,
        divisions: 3,
        label: arouselLevel.round().toString(),
        onChanged: (double value) {
          setState(() {
            arouselLevel = value;
          });
        },
      ),
      LabelSlider.healthArouselSlider(),
    ]);
  }
}
