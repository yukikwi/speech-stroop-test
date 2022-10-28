import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/components/button/primary_button.dart';
import 'package:speech_stroop/components/loading_screen.dart';
import 'package:speech_stroop/model/audio.dart';
// import 'package:speech_stroop/model/audio.dart';
import 'package:speech_stroop/model/test_module/experimental_history.dart';
import 'package:speech_stroop/screens/stroop/result/result_screen.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroop_test.dart';
import 'package:speech_stroop/utils/directory.dart';
// import 'package:speech_stroop/utils/directory.dart';

class Body extends StatefulWidget {
  const Body(this.appbarTitle, {Key key}) : super(key: key);
  final String appbarTitle;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;

  @override
  void initState() {
    loading = false;
    super.initState();
  }

  void endQuiz() async {
    setState(() {
      loading = true;
    });
    sectionNumber = 0;
    answered = -1;

    // website is not support audio record due to storage is not exist
    if (!kIsWeb) {
      var tempDir = await getDir();
      String tempDirPath = tempDir.path;
      print(tempDir.path);

      var i = 0;
      for (var s in sections) {
        String url = await uploadFile(
            tempDirPath, recordAudioDateTime, feedbackTypes[feedbackNumber], i);
        s.audioUrl = url;
        i++;
      }
    }

    recordAudioDateTime = "";

    print(sections);
    await setHistory(currentExperimentee.id, totalScore, sections,
        feedbackTypes[feedbackNumber]);

    setState(() {
      loading = true;
    });
    sections = [];
    totalScore = 0;

    Navigator.pushNamed(context, ResultScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return loading
        ? LoadingScreen()
        : Scaffold(
            appBar: CustomAppBar(widget.appbarTitle),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            key: scaffoldKey,
            body: SafeArea(
              child: Align(
                alignment: Alignment.center,
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  const SizedBox(
                    height: 60,
                  ),
                  PrimaryButton('แสดงผลลัพธ์', () => endQuiz())
                ]),
              ),
            ),
          );
  }
}
