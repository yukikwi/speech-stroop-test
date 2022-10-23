import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_stroop/components/loading_screen.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/model/precondition.dart';
import 'package:speech_stroop/model/update_user.dart';
import 'package:speech_stroop/model/user.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'package:speech_stroop/screens/precondition_test/color_test/fail_color_test.dart';
import 'package:speech_stroop/screens/precondition_test/color_test/pass_color_test.dart';

import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/components/microphone_test/fail_microphone_test.dart';
import 'package:speech_stroop/components/button/mic_button.dart';

import 'package:speech_stroop/theme.dart';
import 'package:tuple/tuple.dart';
import '../../auth/experimental_settoken.dart';
import '../../stroop/stroop_test/stroopHelper/speech_check.dart';

class ColorTestScreen extends StatefulWidget {
  const ColorTestScreen({Key key}) : super(key: key);
  static String routeName = "/precondition_color_test";

  @override
  _ColorTestScreenState createState() => _ColorTestScreenState();
}

class _ColorTestScreenState extends State<ColorTestScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;

  stt.SpeechToText speech;

  bool isListening = false;
  int answeredColorTest = 0;
  int score = 0;
  int failCount = 0;
  List<int> numberList = [0, 1, 2, 3, 4, 5, 6];

  bool isInterval = false;
  bool isCorrect = false;
  String feedback = '';
  String feedbackImg = '';
  // String correctAnswerText = '';
  String recogWordColorTest = '';
  Color stroopBackgroundColor;
  Color problemColor;

  void setBackgroundColor() {
    if (answeredColorTest >= 0) {
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
    loading = false;
    super.initState();
    setBackgroundColor();
    speech = stt.SpeechToText();
    numberList.shuffle();
    problemColor =
        stroopColorsMap.values.toList()[numberList[answeredColorTest]];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return loading
        ? LoadingScreen()
        : Scaffold(
            appBar:
                isInterval ? null : const CustomAppBar('การทดสอบการจำแนกสี'),
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
                                  '${answeredColorTest + 1}/7',
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
                                0, 50, 0, 0),
                            child: SizedBox(
                              width: 200,
                              height: 200,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: problemColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
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
                  print("Color test: recog -> ${recogWordColorTest}");
                  recogWordColorTest = val.recognizedWords;
                }),
            localeId: 'th-TH',
            partialResults: true);
      }
    } else {
      setState(() {
        isListening = false;
      });
      speech.stop();
      // add delayed to wait speech 2 text process finished
      Future.delayed(Duration(milliseconds: 300), () {
        navigatePage();
      });
    }
  }

  void resetQuestion() {
    problemColor = stroopBackgroundColor;
  }

  void setNextQuestionValue() {
    recogWordColorTest = '';
    // correctAnswerText = '';
    feedback = '';
    feedbackImg = '';
    answeredColorTest++;
    problemColor =
        stroopColorsMap.values.toList()[numberList[answeredColorTest]];
  }

  void setSameQuestionValue() {
    recogWordColorTest = '';
    feedback = '';
    feedbackImg = '';
    problemColor =
        stroopColorsMap.values.toList()[numberList[answeredColorTest]];
  }

  void setFeedback(bool isCorrect) {
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
    isInterval = true;
  }

  void navigatePage() {
    var durationDelayInterval = (answeredColorTest == -1)
        ? const Duration(milliseconds: 0)
        : const Duration(milliseconds: 1500);

    String correctAnswer = answeredColorTest == -1
        ? ''
        : stroopColorsMap.keys.toList()[numberList[answeredColorTest]];
    Tuple2 t = checkAnswer(
        recogWordColorTest, numberList[answeredColorTest], correctAnswer);
    isCorrect = t.item1;
    recogWordColorTest = t.item2;
    setFeedback(isCorrect);
    resetQuestion();

    if (answeredColorTest < 6 && isCorrect == true) {
      Future.delayed(durationDelayInterval, () {
        setState(() {
          failCount = 0;
          isInterval = false;
          setNextQuestionValue();
          setBackgroundColor();
        });
      });
    } else {
      Future.delayed(durationDelayInterval, () {
        if (score < 7 && failCount == 6) {
          Navigator.pushNamed(context, FailColorTestScreen.routeName);
        } else if (score < 7 && failCount < 6) {
          setState(() {
            failCount++;
            isInterval = false;
            setSameQuestionValue();
            setBackgroundColor();
          });
        } else {
          setState(() {
            loading = true;
          });
          setPreconditionScore(score);
          setState(() {
            loading = false;
          });
          Navigator.pushNamed(context, PassColorTestScreen.routeName);
        }
      });
    }
  }

  setPreconditionScore(int score) async {
    if (userProfile != null) {
      PreconditionScore updatedColorAbilityTest =
          PreconditionScore(score, DateTime.now());
      Precondition update = Precondition(
          userProfile.precondition.isColorBlind,
          updatedColorAbilityTest,
          userProfile.precondition.readingAbilityTest,
          userProfile.precondition.isPassAll);

      await updateUserPrecondition(update);
    } else {
      precondition.colorVisibilityTest.score = score;
      precondition.colorVisibilityTest.date = DateTime.now();
    }
  }
}
