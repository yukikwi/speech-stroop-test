// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/enums.dart';
import 'package:speech_stroop/theme.dart';

// typedef void HandleFunc();

class SecondaryButton extends StatelessWidget {
  final String text;
  // final HandleFunc handler;
  final ButtonType buttonType;
  final void Function() handler;

  SecondaryButton(this.text, this.handler,
      [this.buttonType = ButtonType.small]);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  side: BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              minimumSize:
                  MaterialStateProperty.all(buttonStyle[buttonType].item1),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              backgroundColor: MaterialStateProperty.all(Colors.transparent)),
          onPressed: () {
            handler();
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Text(text, style: buttonStyle[buttonType].item2),
          ),
        ));
  }
}
