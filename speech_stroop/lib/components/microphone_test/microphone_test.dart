import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/components/button/mic_button.dart';
import 'package:speech_stroop/screens/home/components/body.dart';
import 'package:speech_stroop/screens/stroop/healthRating/break_screen.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroop_test.dart';
import 'package:speech_stroop/screens/stroop/tutorial/introduction/tutorial_intro1.dart';
import 'package:speech_stroop/theme.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:tuple/tuple.dart';

import '../custom_appbar.dart';

class MicrophoneTestScreen extends StatefulWidget {
  const MicrophoneTestScreen({Key key}) : super(key: key);
  static String routeName = "/precondition_microphone_test";

  @override
  _MicrophoneTestScreenState createState() => _MicrophoneTestScreenState();
}

class _MicrophoneTestScreenState extends State<MicrophoneTestScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  stt.SpeechToText speech;

  bool isListening = false;
  String recogWord = '';
  String correctMicAnswer = 'ฟ้าเขียวเหลืองส้มแดงดำม่วง';
  bool isCorrect = false;
  String result = '';
  Color resultColor = backgroundColor;
  List<SpeechRecognitionWords> valAlternates;

  @override
  void initState() {
    super.initState();
    speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      appBar: CustomAppBar(
          'การทดสอบไมโครโฟน', true, currentExperimentee.runingNumber),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MicButton(isListening, listen),
      key: scaffoldKey,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                    'หมายเหตุ* การอยู่ในสถานที่ที่มีเสียงรบกวนน้อยจะยิ่งทำให้การทดสอบได้ประสิทธิภาพมากยิ่งขึ้น',
                    style: textTheme().bodyMedium),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                child: Column(
                  children: [
                    Text('ฟ้า เขียว เหลือง', style: textTheme().displayMedium),
                    Text('ส้ม แดง ดำ ม่วง', style: textTheme().displayMedium),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Text(
                  result,
                  style: textTheme().bodyLarge.apply(color: resultColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void listen() async {
    if (!isListening) {
      bool available = await speech.initialize(
          // onStatus: (val) => print('onStatus: $val'),
          onError: (val) => setState(() {
                result = 'โปรดลองใหม่อีกครั้ง';
                resultColor = const Color(0xFFDA4F2C);
                recogWord = '';
              }));
      if (available) {
        setState(() => {
              isListening = true,
              result = '',
              recogWord = '',
              isCorrect = false
            });
        speech.listen(
            onResult: onResultListen, localeId: 'th-TH', partialResults: true);
      }
    } else {
      setState(() {
        isListening = false;
      });
      Future.delayed(const Duration(milliseconds: 800), () {
        speech.stop();
        Tuple2 t = checkAnswer(recogWord, correctMicAnswer);
        isCorrect = t.item1;
        recogWord = t.item2;
        if (isCorrect) {
          setState(() {
            result = 'คุณผ่านการทดสอบไมโครโฟน';
            resultColor = const Color(0xFF6FC2A0);
            recogWord = '';
          });
          Future.delayed(const Duration(milliseconds: 1500), () {
            Navigator.pushNamed(context, TutorialIntroduction1Screen.routeName);
          });
        } else {
          setState(() {
            result = 'โปรดลองใหม่อีกครั้ง';
            resultColor = const Color(0xFFDA4F2C);
            recogWord = '';
          });
        }
      });
    }
  }

  Future<void> onResultListen(val) async {
    valAlternates = val.alternates;

    recogWord = valAlternates[0].recognizedWords;
  }

  Tuple2<bool, String> checkAnswer(String recogWord, String correctAnswer) {
    bool isCorrect = false;

    if (recogWord == correctAnswer) {
      isCorrect = true;
    } else {
      for (Tuple2 t in allSimilarWords) {
        if (!recogWord.contains(t.item1) && recogWord.contains(t.item2)) {
          recogWord = recogWord.replaceAll(t.item2, t.item1);
        }
      }
    }

    if (recogWord == correctAnswer) {
      isCorrect = true;
    }

    return Tuple2(isCorrect, recogWord);
  }
}
