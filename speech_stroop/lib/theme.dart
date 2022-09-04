import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    backgroundColor: backgroundColor,
    useMaterial3: true,
    primarySwatch: primaryColorMaterial,
    fontFamily: 'BaiJamjuree',
    textTheme: textTheme(),
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = const OutlineInputBorder();
  return const InputDecorationTheme();
}

TextTheme textTheme() {
  return TextTheme(
    displayLarge: TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 115.0,
    ),
    displayMedium: TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.w500,
      fontSize: 45.0,
    ),
    displaySmall: TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.w500,
      fontSize: 36.0,
    ),
    headlineLarge: TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.w500,
      fontSize: 32.0,
    ),
    headlineMedium: TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.w500,
      fontSize: 28.0,
    ),
    headlineSmall: TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.w500,
      fontSize: 24.0,
    ),
    titleLarge: TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.w500,
      fontSize: 22.0,
    ),
    titleMedium: TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
    ),
    titleSmall: TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
    ),
    labelLarge: TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
    ),
    labelMedium: TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.w500,
      fontSize: 12.0,
    ),
    labelSmall: TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.w500,
      fontSize: 12.0,
    ),
    bodyLarge: TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
    ),
    bodyMedium: TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
    ),
    bodySmall: TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.w500,
      fontSize: 12.0,
    ),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme();
}
