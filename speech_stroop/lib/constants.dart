import 'package:flutter/material.dart';
import 'package:speech_stroop/enums.dart';
import 'package:speech_stroop/theme.dart';
import 'package:tuple/tuple.dart';

// Color
Map<int, Color> color = {
  50: const Color.fromRGBO(4, 131, 184, .1),
  100: const Color.fromRGBO(4, 131, 184, .2),
  200: const Color.fromRGBO(4, 131, 184, .3),
  300: const Color.fromRGBO(4, 131, 184, .4),
  400: const Color.fromRGBO(4, 131, 184, .5),
  500: const Color.fromRGBO(4, 131, 184, .6),
  600: const Color.fromRGBO(4, 131, 184, .7),
  700: const Color.fromRGBO(4, 131, 184, .8),
  800: const Color.fromRGBO(4, 131, 184, .9),
  900: const Color.fromRGBO(4, 131, 184, 1),
};

MaterialColor primaryColorMaterial = MaterialColor(0xFF37265F, color);
Color primaryColor = const Color(0xFF37265F);
Color brightPrimaryColor = const Color(0xff503B7F);

Color secondaryColor = const Color(0xFFEB8D8D);

Color softPrimaryColor = const Color(0xFFF4F4F9);

Color tertiaryColor = const Color(0xFFFFE7E2);

Color backgroundColor = const Color(0xFFFBFBFF);

Color formText = const Color(0xFF525252);

Color formBorder = const Color(0xFFA7A5A5);

//Screen
double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
/* 
  ex. deviceHeight(context) * 0.3 simply means 30% of screen height
  note: deviceHeight(context) * 0.05 ~ 30
        deviceHeight(context) * 0.03 ~ 10-15
        deviceHeight(context) * 0.01 ~ 5
*/

// Button
Map<ButtonType, Tuple2<Size, TextStyle>> buttonStyle = {
  ButtonType.small: Tuple2(const Size(350, 42), textTheme().titleMedium),
  ButtonType.medium: Tuple2(const Size(350, 60), textTheme().titleLarge),
  ButtonType.large: Tuple2(const Size(350, 72), textTheme().titleLarge)
};

// API path
class APIPath {
  /// dev : http://localhost:3000
  /// prod: https://speech-stroop.herokuapp.com
  static const baseUrl = "http://192.168.1.6:3000";
  static const user = "/user";
}

// Register
List<DropdownMenuItem<dynamic>> genderList = const [
  DropdownMenuItem(child: Text("เพศชาย"), value: "เพศชาย"),
  DropdownMenuItem(child: Text("เพศหญิง"), value: "เพศหญิง"),
  DropdownMenuItem(child: Text("อื่น ๆ"), value: "อื่น ๆ"),
];
String educationValue;
List<DropdownMenuItem<dynamic>> educationList = const [
  DropdownMenuItem(
      child: Text("ต่ำกว่ามัธยมศึกษาตอนต้น"), value: "ต่ำกว่ามัธยมศึกษาตอนต้น"),
  DropdownMenuItem(child: Text("มัธยมศึกษาตอนต้น"), value: "มัธยมศึกษาตอนต้น"),
  DropdownMenuItem(child: Text("ปวช."), value: "ปวช."),
  DropdownMenuItem(
      child: Text("มัธยมศึกษาตอนปลาย"), value: "มัธยมศึกษาตอนปลาย"),
  DropdownMenuItem(child: Text("ปวส."), value: "ปวส."),
  DropdownMenuItem(child: Text("อนุปริญญา"), value: "อนุปริญญา"),
  DropdownMenuItem(child: Text("ปริญญาตรี "), value: "ปริญญาตรี"),
  DropdownMenuItem(child: Text("ปริญญาโท"), value: "ปริญญาโท"),
  DropdownMenuItem(child: Text("ปริญญาเอก"), value: "ปริญญาเอก"),
  DropdownMenuItem(child: Text("อื่น ๆ"), value: "อื่น ๆ"),
];

// Tutorial
int tutorialQuestionsAmount = 5;

// Stroop
int stroopQuestionsAmount = 2;
int stroopSectionAmount = 3;
int stroopTotalQuestionsAmount = stroopQuestionsAmount * stroopSectionAmount;
int stroopQuestionDurationMs = 5000; //2500;
int stroopIntervalDurationMs = 2000; //1500;
Map<String, Color> stroopColorsMap = {
  'แดง': const Color(0xFFD30000),
  'ดำ': const Color(0xFF000000),
  'เหลือง': const Color(0xFFFFDF00),
  'เขียว': const Color(0xFF25CF55),
  'ส้ม': const Color(0xFFFF6000),
  'ฟ้า': const Color(0xFF72C4FF),
  'ม่วง': const Color(0xFF8F00FF)
};
List<String> stroopColorsName = stroopColorsMap.keys.toList();
List<Color> stroopColorsCode = stroopColorsMap.values.toList();

// Chart
Map<int, String> dateLabel = {
  1: 'จ.',
  2: 'อ.',
  3: 'พ.',
  4: 'พฤ.',
  5: 'ศ.',
  6: 'ส.',
  7: 'อา.',
};

/// can be used to improve speech-to-text performance
Map<String, List<String>> similarWords = {
  'ฟ้า': [
    'ฟ้า',
    'สีฟ้า',
    'ป๊า',
    'ป๋า',
    'ร้า',
    'สา',
    'ฝา',
    'ปา',
    'ปลา',
    'พระ',
    'น้า',
    'บ้า'
  ],
  'เขียว': ['เขียว', 'สีเขียว', 'เดี๋ยว', 'เหมียว'],
  'เหลือง': [
    'เหลือง',
    'สีเหลือง',
    'เหลือ',
    'เรื่อง',
    'หลวง',
    'เมือง',
    'เหนียง',
    'หนัง',
  ],
  'ส้ม': ['ส้ม', 'สีส้ม', 'ส่ง', 'ซ่อม', 'ส้อม', 'ต้ม', 'ซ่อง'],
  'แดง': ['แดง', 'สีแดง', 'แรง', 'แบ่ง', 'แพง', 'แนง', 'แมง'],
  'ดำ': [
    'ดำ',
    'สีดำ',
    'ดาม',
    'นำ',
    'จำ',
    'ดอม',
    'รำ',
    'นำ',
    'ตำ',
    'นาม',
    'ดาบ',
    'ดัง'
  ],
  'ม่วง': ['ม่วง', 'สีม่วง', 'ง่วง', 'มั่ว'],
};

// [[แดง, สีแดง], [แดง, แรง], ..., [ดำ, สีดำ], ...]
List<Tuple2<String, String>> allSimilarWords = similarWords.values
    .toList()
    .map((arr) => arr.map((word) => Tuple2(arr[0], word)).toList())
    .toList()
    .expand((element) => element)
    .toList();
