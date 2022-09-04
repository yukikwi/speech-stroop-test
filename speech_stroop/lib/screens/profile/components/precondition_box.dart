import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/model/precondition.dart';
import 'package:speech_stroop/screens/precondition_test/color_test/color_test.dart';
import 'package:speech_stroop/screens/precondition_test/color_test/intro.dart';
import 'package:speech_stroop/screens/precondition_test/introduction.dart';
import 'package:speech_stroop/screens/precondition_test/reading_test/intro.dart';
import 'package:speech_stroop/screens/precondition_test/reading_test/reading_test.dart';
import 'package:speech_stroop/utils/date_format.dart';

class PreconditionBox extends StatelessWidget {
  PreconditionBox(this.title, this.precondition, {Key key}) : super(key: key);
  final String title;
  final PreconditionScore precondition;
  String preconditionImage = 'assets/images/failed.png';
  String testRoute;
  bool isPass = true; // TODO: not hard code

  String getPreconditionImage() {
    (isPass
        ? preconditionImage = 'assets/images/pass.png'
        : 'assets/images/failed.png');
    return preconditionImage;
  }

  String getTestRoute() {
    switch (title) {
      case "ทดสอบการจำแนกสี":
        testRoute = IntroColorTestScreen.routeName;
        break;
      case "ทดสอบการอ่าน":
        testRoute = IntroReadingTestScreen.routeName;
        break;
      default:
        //TODO: handle err
        testRoute = IntroductionScreen.routeName;
    }
    return testRoute;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
          color: softPrimaryColor, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(30),
      margin: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style:
                Theme.of(context).textTheme.titleLarge.apply(color: formText),
          ),
          const SizedBox(height: 20),
          Image.asset(
            getPreconditionImage(),
            width: 31,
            height: 31,
          ),
          const SizedBox(height: 20),
          Text(
            "เมื่อวันที่ ${convertDateTime(precondition.date)}",
            style:
                Theme.of(context).textTheme.titleMedium.apply(color: formText),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, getTestRoute());
            },
            child: const Text('ทดสอบอีกครั้ง'),
            style: TextButton.styleFrom(
              shape: const StadiumBorder(),
              textStyle: Theme.of(context).textTheme.titleMedium.apply(
                    color: primaryColor,
                    decoration: TextDecoration.underline,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
