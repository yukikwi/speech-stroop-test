import 'package:flutter/material.dart';

typedef void handleFunc(int x);

class StressRadioButtons extends StatelessWidget {
  final int value;
  final handleFunc handleChange;
  StressRadioButtons(this.value, this.handleChange);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio(
          value: 1,
          groupValue: value,
          onChanged: handleChange,
        ),
        const Text(
          '1',
          style: TextStyle(fontSize: 16.0),
        ),
        Radio(
          value: 2,
          groupValue: value,
          onChanged: handleChange,
        ),
        const Text(
          '2',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        Radio(
          value: 3,
          groupValue: value,
          onChanged: handleChange,
        ),
        const Text(
          '3',
          style: TextStyle(fontSize: 16.0),
        ),
        Radio(
          value: 4,
          groupValue: value,
          onChanged: handleChange,
        ),
        const Text(
          '4',
          style: TextStyle(fontSize: 16.0),
        ),
        Radio(
          value: 5,
          groupValue: value,
          onChanged: handleChange,
        ),
        const Text(
          '5',
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}
