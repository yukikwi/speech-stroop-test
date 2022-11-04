import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_stroop/components/button/mic_button.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/model/test_module/question.dart';
import 'package:speech_stroop/screens/stroop/feedback_section/feedback_section_screen.dart';
import 'package:speech_stroop/screens/stroop/healthRating/break_screen.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/components/flutter_sound.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroopHelper/stroop_background.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroopHelper/stroop_combination.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroopHelper/stroop_template.dart';
import 'package:speech_stroop/theme.dart';
import 'package:speech_stroop/utils/logger.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroopHelper/speech_check.dart';
import 'package:speech_stroop/utils/time.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:tuple/tuple.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroop_test.dart';
import 'dart:core';
import 'package:animated_text_kit/animated_text_kit.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  stt.SpeechToText speech;

  bool isListening = false;
  String feedback = '';
  String feedbackImg = '';
  String problem = '';
  Color problemColor = backgroundColor;
  List<Color> stroopBackgroundColor;

  // testText for test speech-to-text on Android
  String testText = '';
  String textErr = '';

  @override
  void initState() {
    super.initState();
    stroopBackgroundColor = setBackgroundColor(answered, feedback);
    speech = stt.SpeechToText();

    // record on non-website platform only
    if (!kIsWeb) {
      if (recordAudioDateTime == "") {
        recordAudioDateTime = getAudioFileDateFormat(DateTime.now());
      }
      recordAudio = RecordAudio(
          sectionNumber, recordAudioDateTime, feedbackTypes[feedbackNumber]);

      loggerNoStack.d("init state", {
        "sectionNumber": recordAudio.section,
        "recordAudioDateTime": recordAudio.datetime,
      });

      recordAudio.openRecorder();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: answered >= 0 && isListening == true
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
                        child: answered >= 0
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
                                  testTemplate =
                                      buildTest(false, sectionNumber);
                                  initQuestions(testTemplate);
                                  stopwatchAudio.reset();
                                  stopwatchAudio.start();
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
                      : Text(feedbackImg,
                          style: textTheme()
                              .headlineSmall
                              .apply(color: primaryColor)),
                  const SizedBox(
                    height: 30,
                  ),
                  feedback != ''
                      ? Text(
                          feedback,
                          style: textTheme()
                              .headlineSmall
                              .apply(color: Colors.white),
                        )
                      : const SizedBox(
                          height: 5,
                        ),
                  // Text(
                  //   'test: $testText, err: $textErr',
                  //   style: textTheme().headlineSmall.apply(color: Colors.white),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // for db
  void initQuestions(List<StroopQuestion> template) {
    questions = [];
    var i = 0;
    for (var q in template) {
      i++;
      questions.add(Question(i, {"color": q.color, "word": q.word}, q.condition,
          q.color, null, null, null, null, false));
    }
  }

  Future<void> listen() async {
    if (!isListening) {
      bool available = await speech.initialize(
        // onStatus: (val) => print('onStatus: $val'),
        onError: (val) => {textErr = val.toString()},
      );
      if (available) {
        setState(() => isListening = true);
        speech.listen(
          onResult: (val) => setState(() {
            stopwatchRT.stop();
            recogWord = val.recognizedWords;
            confidence = val.confidence;
            // set questions[anwser]
            if (answered >= 0 &&
                questions[answered].answerAt == null &&
                questions[answered].reactionTimeMs == null) {
              questions[answered].answerAt =
                  toReadableTime(stopwatchAudio.elapsedMilliseconds);
              questions[answered].reactionTimeMs =
                  stopwatchRT.elapsedMilliseconds;
            }
          }),
          localeId: 'th-TH',
          partialResults: true,
        );
      }
    }
  }

  void setFeedback(bool isCorrect) {
    setState(() {
      if (feedbackTypes[feedbackNumber] == "afterQuestion") {
        if (isCorrect) {
          feedback = 'ถูกต้อง';
          feedbackImg = 'assets/images/correct.png';
        } else if (!isCorrect && recogWord == "") {
          feedback = 'หมดเวลา';
          feedbackImg = 'assets/images/timeout.png';
        } else {
          feedback = 'ผิด';
          feedbackImg = 'assets/images/wrong.png';
        }
      } else {
        feedback = 'ได้รับคำตอบแล้ว';
        feedbackImg = 'assets/images/check_submit.png';
      }
      testText = recogWord;
      stroopBackgroundColor = setBackgroundColor(answered, feedback);
    });
  }

  void resetQuestion() {
    problem = '';
    problemColor = backgroundColor;
    stopwatchRT.reset();
  }

  void setNextQuestionValue() {
    confidence = 0;
    recogWord = '';
    feedback = '';
    testText = '';
    feedbackImg = '';
    answered++;
    problem = testTemplate[answered].word;
    problemColor = stroopColorsMap[testTemplate[answered].color];
  }

  void startNextQuestion() {
    // set startAt timestamp of next question
    if (answered >= 0) {
      questions[answered].startAt =
          toReadableTime(stopwatchAudio.elapsedMilliseconds);
    }
    listen();
    stopwatchRT.start();
    navigatePage();
  }

  void navigatePage() {
    var durationDelay = (answered == -1)
        ? const Duration(milliseconds: 500)
        : Duration(milliseconds: stroopQuestionDurationMs);
    var durationDelayInterval = (answered == -1)
        ? const Duration(milliseconds: 0)
        : Duration(milliseconds: stroopIntervalDurationMs);

    Future.delayed(durationDelay, () {
      // end of each questions
      speech.stop();
      setState(() {
        isListening = false;
      });

      String correctAnswer = answered == -1 ? '' : testTemplate[answered].color;
      Tuple2<bool, String> checkAnswerOutput =
          checkAnswer(recogWord, answered, correctAnswer);
      bool isCorrect = checkAnswerOutput.item1;
      String finalRecogWord = checkAnswerOutput.item2;

      if (answered >= 0) {
        // count stack
        if (isCorrect) {
          correctStack++;
        } else {
          highestCorrectStack = correctStack > highestCorrectStack
              ? correctStack
              : highestCorrectStack;
          correctStack = 0;
        }

        setFeedback(isCorrect);
        scoreCounting(isCorrect);
        questions[answered].userAnswer = finalRecogWord;
        questions[answered].isCorrect = isCorrect;

        if (questions[answered].userAnswer == '' ||
            questions[answered].userAnswer == null) {
          questions[answered].reactionTimeMs = null;
          questions[answered].answerAt = null;
        }

        loggerNoStack.d({
          'sectionNumber': sectionNumber,
          'sections': sections,
          'answered': answered,
          'isCorrect': isCorrect,
          'recogWord': recogWord,
          'userAnswer': finalRecogWord,
          "correctAnswer": testTemplate[answered].color,
        });
      }

      resetQuestion();

      // prepare for the next question
      if (answered < stroopQuestionsAmount - 1) {
        Future.delayed(durationDelayInterval, () async {
          setState(() {
            setNextQuestionValue();
            stroopBackgroundColor = setBackgroundColor(answered, feedback);
          });
          startNextQuestion();
        });
      }
      // end of each sections
      else if (answered == stroopQuestionsAmount - 1) {
        stopwatchAudio.stop();
        if (!kIsWeb) {
          recordAudio.getRecorderFn()();
        }

        highestCorrectStack = correctStack > highestCorrectStack
            ? correctStack
            : highestCorrectStack;

        scores = {"congruent": 0, "incongruent": 0};
        Future.delayed(durationDelayInterval, () async {
          if (feedbackTypes[feedbackNumber] != "afterAllSection") {
            Navigator.pushNamed(context, FeedbackSection.routeName);
          } else {
            Navigator.pushNamed(context, BreakScreen.routeName);
          }
        });
      }
    });
  }
}
