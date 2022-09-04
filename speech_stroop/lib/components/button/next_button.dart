import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final String text;
  final void Function() handler;
  NextButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
        child: SizedBox(
            width: 90,
            height: 42,
            child: ElevatedButton(
                onPressed: () {
                  handler();
                },
                child: Text(
                  text,
                ),
                style: ElevatedButton.styleFrom(
                  // side: const BorderSide(width: 1.0, color: Color(0xff503B7F)),
                  shape: const StadiumBorder(),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF381E73),
                    fontFamily: 'BaiJamjuree',
                  ),
                ))));
  }
}
