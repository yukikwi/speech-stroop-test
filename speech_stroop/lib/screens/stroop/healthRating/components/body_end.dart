import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_stroop/components/custom_appbar.dart';
import 'package:speech_stroop/components/button/primary_button.dart';
import 'package:speech_stroop/components/loading_screen.dart';
// import 'package:speech_stroop/model/audio.dart';
import 'package:speech_stroop/model/badge.dart';
import 'package:speech_stroop/model/test_module/health_scores.dart';
import 'package:speech_stroop/model/test_module/history.dart';
import 'package:speech_stroop/model/update_user.dart';
import 'package:speech_stroop/model/user.dart';
import 'package:speech_stroop/screens/stroop/healthRating/components/health_slider.dart';
import 'package:speech_stroop/screens/stroop/result/result_screen.dart';
import 'package:speech_stroop/screens/stroop/stroop_test/stroop_test.dart';
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
    stress.end = stressLevel.toInt();
    arousel.end = arouselLevel.toInt();
    healthScores = HealthScores(stress, arousel);

    // var tempDir = await getDir();
    // String tempDirPath = tempDir.path;

    // var audioUrls = await uploadAudio(tempDirPath, recordAudioDateTime);

    recordAudioDateTime = "";

    // var i = 0;
    // for (var s in sections) {
    //   if (audioUrls.urls != null) {
    //    String url = audioUrls.urls[i];
    //     s.audioUrl = url;
    //     i++;
    //   }
    // }

    List<String> userBadges = userProfile.badge;
    List<String> newUserBadge = [];

    // day stack
    DateTime testDate = DateTime.now();
    int dayStack = 0;
    if (checkLatestTestMakeDayStack(testDate)) {
      dayStack = testDayStack.item2;
    }
    // add badge
    badgesMap.forEach((key, value) {
      if (value.type == 'correctStack' &&
          highestCorrectStack >= value.condition) {
        if (!userBadges.contains(key)) {
          newUserBadge.add(key);
        }
      }
      if (value.type == 'testDayStack' && dayStack >= value.condition) {
        if (!userBadges.contains(key)) {
          newUserBadge.add(key);
        }
      }
    });

    List<String> userBadgeValue = [...userBadges, ...newUserBadge];

    var resBadge = await updateUserBadge(userBadgeValue);

    print(resBadge);

    var resHistory = await setHistory(
      totalScore,
      sections,
      healthScores,
      newUserBadge,
    );
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
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                const HealthSlider(),
                const SizedBox(
                  height: 60,
                ),
                PrimaryButton('แสดงผลลัพธ์', () => endQuiz())
              ]),
            ),
          );
  }
}
