import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroopHelper/speech_check.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroopHelper/stroop_background.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroopHelper/stroop_combination.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroopHelper/stroop_template.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroop_test.dart';
import 'package:tuple/tuple.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:speech_stroop/screens/stroop/tutorial/done_screen.dart';

import 'package:speech_stroop/components/button/mic_button.dart';

import 'package:speech_stroop/model/test_module/question.dart';

import 'package:speech_stroop/utils/logger.dart';

import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/theme.dart';

List<StroopQuestion> testTemplateTutorial = [];
int answeredTutorial = -1;
String recogWordTutorial = '';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  stt.SpeechToText speech;

  bool isListening = false;
  String correctAnswerText = '';
  String feedback = '';
  String feedbackImg = '';
  String problem = '';
  Color problemColor = backgroundColor;
  List<Color> stroopBackgroundColor = [];

  @override
  void initState() {
    super.initState();
    testTemplateTutorial = [];
    answeredTutorial = -1;
    recogWordTutorial = '';
    stroopBackgroundColor = setBackgroundColor(answeredTutorial, feedback);
    speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: answeredTutorial >= 0 && isListening == true
          ? MicButton(isListening, () => {}, true)
          : null,
      key: scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: stroopBackgroundColor)),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Center(
                        child: answeredTutorial >= 0
                            ? Text(
                                problem,
                                style: TextStyle(
                                  color: problemColor,
                                  fontSize: 70,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              )
                            : AnimatedTextKit(
                                pause: const Duration(milliseconds: 150),
                                isRepeatingAnimation: false,
                                animatedTexts: [
                                  ScaleAnimatedText('3',
                                      textStyle: const TextStyle(
                                          fontSize: 144,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      duration:
                                          const Duration(milliseconds: 1500)),
                                  ScaleAnimatedText('2',
                                      textStyle: const TextStyle(
                                          fontSize: 144,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      duration:
                                          const Duration(milliseconds: 1500)),
                                  ScaleAnimatedText('1',
                                      textStyle: const TextStyle(
                                          fontSize: 144,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      duration:
                                          const Duration(milliseconds: 1500)),
                                ],
                                onFinished: () {
                                  testTemplateTutorial = buildTest(true);
                                  navigatePage();
                                },
                              )),
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
                  Text(feedback,
                      style:
                          textTheme().headlineSmall.apply(color: Colors.white)),
                  const SizedBox(
                    height: 30,
                  ),
                  answeredTutorial >= 0
                      ? Text("เฉลย:  $correctAnswerText",
                          style: textTheme()
                              .headlineSmall
                              .apply(color: backgroundColor))
                      : const Text('')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> listen() async {
    if (!isListening) {
      bool available = await speech.initialize(
          // onStatus: (val) => print('onStatus: $val'),
          // onError: (val) => print('onError: $val'),
          );
      if (available) {
        setState(() => isListening = true);
        speech.listen(
          onResult: (val) => setState(() {
            recogWordTutorial = val.recognizedWords;
          }),
          localeId: 'th-TH',
          partialResults: true,
        );
      }
    }
  }

  void setFeedback(bool isCorrect) {
    setState(() {
      if (isCorrect) {
        feedback = 'ถูกต้อง';
        feedbackImg = 'assets/images/correct.png';
      } else {
        feedback = 'ผิด';
        feedbackImg = 'assets/images/wrong.png';
      }
      correctAnswerText = testTemplateTutorial[answeredTutorial].color;
      stroopBackgroundColor = setBackgroundColor(answeredTutorial, feedback);
    });
  }

  void resetQuestion() {
    problem = '';
    problemColor = backgroundColor;
  }

  void setNextQuestionValue() {
    recogWordTutorial = '';
    correctAnswerText = '';
    feedback = '';
    feedbackImg = '';
    answeredTutorial++;
    problem = testTemplateTutorial[answeredTutorial].word;
    problemColor =
        stroopColorsMap[testTemplateTutorial[answeredTutorial].color];
  }

  void startNextQuestion() {
    listen();
    navigatePage();
  }

  void navigatePage() {
    var durationDelay = (answeredTutorial == -1)
        ? const Duration(milliseconds: 500)
        : Duration(milliseconds: stroopQuestionDurationMs);
    var durationDelayInterval = (answeredTutorial == -1)
        ? const Duration(milliseconds: 0)
        : Duration(milliseconds: stroopIntervalDurationMs);

    Future.delayed(durationDelay, () {
      // end of each questionsTutorial
      speech.stop();
      setState(() {
        isListening = false;
      });

      String correctAnswer = answeredTutorial == -1
          ? ''
          : testTemplateTutorial[answeredTutorial].color;
      Tuple2<bool, String> checkAnswerOutput =
          checkAnswer(recogWordTutorial, answeredTutorial, correctAnswer);
      bool isCorrect = checkAnswerOutput.item1;
      String finalRecogWord = checkAnswerOutput.item2;

      if (answeredTutorial >= 0) {
        setFeedback(isCorrect);
        loggerNoStack.d({
          'answeredTutorial': answeredTutorial,
          'isCorrect': isCorrect,
          'recogWord': recogWordTutorial,
          'userAnswer': finalRecogWord,
          "correctAnswer": testTemplateTutorial[answeredTutorial].color,
        });
      }
      resetQuestion();

      // prepare for the next question
      if (answeredTutorial < tutorialQuestionsAmount - 1) {
        Future.delayed(durationDelayInterval, () async {
          setState(() {
            setNextQuestionValue();
            stroopBackgroundColor =
                setBackgroundColor(answeredTutorial, feedback);
          });
          startNextQuestion();
        });
      }
      // end of each sections
      else if (answeredTutorial == tutorialQuestionsAmount - 1) {
        Future.delayed(durationDelayInterval, () async {
          Navigator.pushNamed(context, TutorialDoneScreen.routeName);
        });
      }
    });
  }
}
