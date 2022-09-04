import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_stroop/components/loading_screen.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/model/precondition.dart';
import 'package:speech_stroop/model/update_user.dart';
import 'package:speech_stroop/model/user.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroopHelper/speech_check.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'package:speech_stroop/screens/auth/register.dart';
import 'package:speech_stroop/screens/precondition_test/reading_test/fail_reading_test.dart';
import 'package:speech_stroop/screens/precondition_test/reading_test/pass_reading_test.dart';

import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/components/microphone_test/fail_microphone_test.dart';
import 'package:speech_stroop/components/button/mic_button.dart';

import 'package:speech_stroop/theme.dart';
import 'package:tuple/tuple.dart';

class ReadingTestScreen extends StatefulWidget {
  const ReadingTestScreen({Key key}) : super(key: key);
  static String routeName = "/precondition_reading_test";

  @override
  _ReadingTestScreenState createState() => _ReadingTestScreenState();
}

class _ReadingTestScreenState extends State<ReadingTestScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;

  stt.SpeechToText speech;

  bool isListening = false;
  int answeredReadingTest = 0;
  int score = 0;

  bool isInterval = false;
  bool isCorrect = false;
  String feedback = '';
  String feedbackImg = '';
  // String correctAnswerText = '';
  String recogWordReadingTest = '';
  Color stroopBackgroundColor;
  Color problemWordColor = Colors.black;
  String problemWord = stroopColorsMap.keys.toList()[0];

  void setBackgroundColor() {
    if (answeredReadingTest >= 0) {
      switch (feedback) {
        case '':
          stroopBackgroundColor = const Color(0xFFF5F5F5);
          break;
        case 'ถูกต้อง':
          stroopBackgroundColor = const Color(0xFF6FC2A0);
          break;
        case 'ผิด':
          stroopBackgroundColor = const Color(0xFFDA4F2C);
          break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    setBackgroundColor();
    speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return loading
        ? LoadingScreen()
        : Scaffold(
            appBar: isInterval ? null : const CustomAppBar('การทดสอบการอ่าน'),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton:
                isInterval ? null : MicButton(isListening, listen),
            key: scaffoldKey,
            backgroundColor: stroopBackgroundColor,
            body: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                          child: isInterval
                              ? null
                              : Text(
                                  '${answeredReadingTest + 1}/7',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 36,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 100, 0, 0),
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Text(problemWord,
                                  style: TextStyle(
                                      color: problemWordColor,
                                      fontSize: 70,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        feedback != ''
                            ? Image.asset(
                                feedbackImg,
                                width: 100,
                                height: 100,
                              )
                            : Text(feedbackImg),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          feedback,
                          style: textTheme()
                              .headlineSmall
                              .apply(color: Colors.white),
                        ),
                        // Text(
                        //   correctAnswerText,
                        //   style: textTheme().headlineMedium,
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  void listen() async {
    if (!isListening) {
      bool available = await speech.initialize(
          // onStatus: (val) => print('onStatus: $val'),
          onError: (val) => {
                Navigator.pushNamed(
                    context, FailMicrophoneTestScreen.routeName),
                print('onError: $val'),
              });
      if (available) {
        setState(() => isListening = true);
        speech.listen(
            onResult: (val) => setState(() {
                  recogWordReadingTest = val.recognizedWords;
                }),
            localeId: 'th-TH',
            partialResults: true);
      }
    } else {
      setState(() {
        isListening = false;
      });
      speech.stop();
      navigatePage();
    }
  }

  void resetQuestion() {
    problemWordColor = stroopBackgroundColor;
  }

  void setNextQuestionValue() {
    recogWordReadingTest = '';
    // correctAnswerText = '';
    feedback = '';
    feedbackImg = '';
    answeredReadingTest++;
    problemWord = stroopColorsMap.keys.toList()[answeredReadingTest];
    problemWordColor = Colors.black;
  }

  void setFeedback(bool isCorrect) {
    if (answeredReadingTest >= 0) {
      if (isCorrect) {
        setState(() {
          score++;
          feedback = 'ถูกต้อง';
          feedbackImg = 'assets/images/correct.png';
          setBackgroundColor();
        });
      } else {
        setState(() {
          feedback = 'ผิด';
          feedbackImg = 'assets/images/wrong.png';
          setBackgroundColor();
        });
      }
    }
    isInterval = true;
  }

  void navigatePage() {
    var durationDelayInterval = (answeredReadingTest == -1)
        ? const Duration(milliseconds: 0)
        : const Duration(milliseconds: 1500);

    String correctAnswer = answeredReadingTest == -1
        ? ''
        : stroopColorsMap.keys.toList()[answeredReadingTest];
    Tuple2 t =
        checkAnswer(recogWordReadingTest, answeredReadingTest, correctAnswer);
    isCorrect = t.item1;
    recogWordReadingTest = t.item2;
    setFeedback(isCorrect);
    resetQuestion();

    if (answeredReadingTest < 6) {
      Future.delayed(durationDelayInterval, () {
        setState(() {
          isInterval = false;
          setNextQuestionValue();
          setBackgroundColor();
        });
      });
    } else {
      Future.delayed(durationDelayInterval, () async {
        if (score < 7) {
          Navigator.pushNamed(context, FailReadingTestScreen.routeName);
        } else {
          setState(() {
            loading = true;
          });
          await setPreconditionScore(score);
          setState(() {
            loading = false;
          });
          Navigator.pushNamed(context, PassReadingTestScreen.routeName);
        }
      });
    }
  }

  setPreconditionScore(int score) async {
    if (userProfile != null) {
      PreconditionScore updatedReadingAbilityTest =
          PreconditionScore(score, DateTime.now());
      Precondition update = Precondition(
          userProfile.precondition.isColorBlind,
          userProfile.precondition.colorVisibilityTest,
          updatedReadingAbilityTest,
          userProfile.precondition.isPassAll);

      await updateUserPrecondition(update);
    } else {
      precondition.readingAbilityTest.score = score;
      precondition.readingAbilityTest.date = DateTime.now();
    }
  }
}
