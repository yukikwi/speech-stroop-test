import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';

class FloatingButton extends StatefulWidget {
  bool isBack = true;
  bool isNext = true;
  final void Function() handler;
  FloatingButton(this.handler, [this.isBack = true, this.isNext = true]);

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(deviceHeight(context) * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.isBack
              ? SizedBox(
                  width: deviceHeight(context) * 0.06,
                  height: deviceHeight(context) * 0.06,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: secondaryColor, width: 1),
                      shape: BoxShape.circle,
                    ),
                    child: FloatingActionButton(
                      heroTag: null,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back,
                          size: deviceHeight(context) * 0.03,
                          color: secondaryColor),
                      backgroundColor: backgroundColor,
                      elevation: 0,
                    ),
                  ),
                )
              : const SizedBox(width: 0, height: 0),
          widget.isNext
              ? SizedBox(
                  width: deviceHeight(context) * 0.06,
                  height: deviceHeight(context) * 0.06,
                  child: FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      widget.handler();
                    },
                    child: Icon(
                      Icons.arrow_forward,
                      size: deviceHeight(context) * 0.03,
                    ),
                    backgroundColor: secondaryColor,
                    elevation: 0,
                  ),
                )
              : const SizedBox(
                  width: 0,
                  height: 0,
                )
        ],
      ),
    );
  }
}
