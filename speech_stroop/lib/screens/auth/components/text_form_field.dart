import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';

class TextFormFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final String Function(String val) validator;
  final void Function(String val) onChanged;
  final bool enabled;
  final bool showBorder;
  final Icon icon;
  final void Function() onTap;

  TextFormFieldCustom(
      this.controller, this.labelText, this.keyboardType, this.validator,
      [this.onChanged,
      this.enabled = true,
      this.showBorder = false,
      this.icon,
      this.onTap]);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: false,
      decoration: InputDecoration(
        labelText: labelText,
        border: showBorder
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: formBorder,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: formBorder,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: formBorder,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabled: enabled,
        suffixIcon: icon ?? icon,
      ),
      style: enabled
          ? TextStyle(
              fontWeight: FontWeight.w300,
              color: primaryColor,
            )
          : TextStyle(
              fontWeight: FontWeight.w300,
              color: formText.withOpacity(0.9),
            ),
      textAlign: TextAlign.start,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap ?? onTap,
    );
  }
}
