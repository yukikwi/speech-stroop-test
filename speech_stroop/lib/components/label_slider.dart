import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/theme.dart';

class LabelSlider {
  static stressSlider() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'ไม่เคย',
            style: textTheme().labelSmall.apply(color: secondaryColor),
          ),
          Text(
            'แทบจะไม่',
            style: textTheme().labelSmall.apply(color: secondaryColor),
          ),
          Text(
            'บางครั้ง',
            style: textTheme().labelSmall.apply(color: secondaryColor),
          ),
          Text(
            'ค่อนข้างบ่อย',
            style: textTheme().labelSmall.apply(color: secondaryColor),
          ),
          Text(
            'บ่อยมาก',
            style: textTheme().labelSmall.apply(color: secondaryColor),
          )
        ],
      ),
    );
  }

  static sleepSlider() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'ไม่เคย',
            style: textTheme().labelSmall.apply(color: secondaryColor),
          ),
          Text(
            'บางครั้ง',
            style: textTheme().labelSmall.apply(color: secondaryColor),
          ),
          Text(
            'บ่อยครั้ง',
            style: textTheme().labelSmall.apply(color: secondaryColor),
          ),
          Text(
            'ทุกครั้ง',
            style: textTheme().labelSmall.apply(color: secondaryColor),
          )
        ],
      ),
    );
  }

  static healthStressSlider() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'ผ่อนคลาย',
            style: textTheme().labelSmall.apply(color: secondaryColor),
          ),
          Text(
            'ค่อนข้างผ่อนคลาย',
            style: textTheme().labelSmall.apply(color: secondaryColor),
          ),
          Text(
            'ค่อนข้างเครียด',
            style: textTheme().labelSmall.apply(color: secondaryColor),
          ),
          Text(
            'เครียด',
            style: textTheme().labelSmall.apply(color: secondaryColor),
          ),
        ],
      ),
    );
  }

  static healthArouselSlider() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'ผ่อนคลาย',
            style: textTheme().labelSmall.apply(color: secondaryColor),
          ),
          Text(
            'ค่อนข้างผ่อนคลาย',
            style: textTheme().labelSmall.apply(color: secondaryColor),
          ),
          Text(
            'ค่อนข้างตื่นตัว',
            style: textTheme().labelSmall.apply(color: secondaryColor),
          ),
          Text(
            'ตื่นตัว',
            style: textTheme().labelSmall.apply(color: secondaryColor),
          ),
        ],
      ),
    );
  }
}
