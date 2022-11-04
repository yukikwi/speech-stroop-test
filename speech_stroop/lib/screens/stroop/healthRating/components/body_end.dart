import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/components/button/primary_button.dart';
import 'package:speech_stroop/components/loading_screen.dart';
import 'package:speech_stroop/model/audio.dart';
import 'package:speech_stroop/model/test_module/experimental_history.dart';
import 'package:speech_stroop/screens/stroop/result/result_screen.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroop_test.dart';
import 'package:speech_stroop/utils/directory.dart';

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

    if (!kIsWeb) {
      var tempDir = await getDir();
      String tempDirPath = tempDir.path;

      var audioUrls = await uploadAudio(tempDirPath, recordAudioDateTime);

      recordAudioDateTime = "";

      var i = 0;
      for (var s in sections) {
        if (audioUrls.urls != null) {
          String url = audioUrls.urls[i];
          s.audioUrl = url;
          i++;
        }
      }
    }

    print(sections);
    // TODO: get experimentee ObjectId from experimentee api and match feedback Type
    await setHistory(
        '63539c56496127a5db0e7fea', totalScore, sections, 'afterQuestion');

    setState(() {
      loading = true;
    });

    Navigator.pushNamed(context, ResultScreen.routeName);

    sections = [];
    totalScore = 0;
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
