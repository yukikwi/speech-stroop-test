import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final bool isLeading;
  final String experimenteeNumber;

  const CustomAppBar(this.text,
      [this.isLeading = false, this.experimenteeNumber = ""]);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    IconButton leadingIcon;
    if (isLeading == true) {
      leadingIcon = IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: secondaryColor,
        ),
        onPressed: () => Navigator.pop(context, false),
      );
    }

    return AppBar(
      shape: Border(bottom: BorderSide(color: tertiaryColor, width: 1)),
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: isLeading,
      leading: leadingIcon,
      //`true` if you want Flutter to automatically add Back Button when needed,
      //or `false` if you want to force your own back button every where
      centerTitle: true,
      title: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF37265F)),
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 18, 25, 0),
          child: Text(
            experimenteeNumber,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: formText,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
      elevation: 0,
      // leading: IconButton(
      //   icon: const Icon(
      //     Icons.arrow_back,
      //     color: Color(0xFFEB8D8D),
      //   ),
      //   onPressed: () => Navigator.pop(context, false),
      // )
    );
  }
}
