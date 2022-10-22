import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';

List<Color> setBackgroundColor(int answered, String feedback) {
  List<Color> stroopBackgroundColor = [];
  print('${answered} : ${feedback}');
  if (answered >= 0) {
    switch (feedback) {
      case '':
        stroopBackgroundColor = [
          const Color(0xFFF5F5F5),
          const Color(0xFFF5F5F5)
        ];
        break;
      case 'ถูกต้อง':
        stroopBackgroundColor = [
          const Color(0xFF6FC2A0),
          const Color(0xFF6FC2A0)
        ];
        break;
      case 'ผิด':
        stroopBackgroundColor = [
          const Color(0xFFDA4F2C),
          const Color(0xFFDA4F2C)
        ];
        break;
      case 'หมดเวลา':
        stroopBackgroundColor = [
          const Color(0xFFFFE355),
          const Color(0xFFFFE355)
        ];
        break;
    }
  } else {
    stroopBackgroundColor = [brightPrimaryColor, secondaryColor];
  }
  return stroopBackgroundColor;
}
