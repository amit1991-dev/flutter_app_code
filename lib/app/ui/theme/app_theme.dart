import 'package:flutter/material.dart';
import '../../data/constants/miscellaneous.dart';
final ThemeData appThemeData = ThemeData(
  primaryColor: Colors.purple,
  // accentColor: Colors.purpleAccent,
  splashColor: Colors.purpleAccent,
  highlightColor: Colors.purple,
  colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,
      secondary: appColors["primary"]!
    // primaryColorDark: appColors["primary"]!,
    // accentColor: appColors["primary"]!, // but now it should be declared like this

  ),
  fontFamily: 'Georgia',
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
);

ThemeData darkTheme = ThemeData(
    // accentColor: appColors["grey"]!.shade800,
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,
      secondary: appColors["primary"]!
      // primaryColorDark: appColors["primary"]!,
      // accentColor: appColors["primary"]!, // but now it should be declared like this

    ),
    brightness: Brightness.dark,
    primaryColor: appColors["primary"]!,
    splashColor: appColors["primary"]!,
    // accentColor: appColors["primary"]!,
    // accentColorBrightness: Brightness.dark,
    buttonTheme: ButtonThemeData(
      buttonColor: appColors["primary"]!,
      disabledColor: appColors["grey"]!,
    ));

ThemeData lightTheme = ThemeData(
    // accentColor: Colors.pink,
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      // primaryColorDark: appColors["primary"]!,
      accentColor: appColors["primary"]!, // but now it should be declared like this

    ),
    // colorScheme: ColorScheme.fromSwatch(
    //   accentColor: Color(0xff936c3b), // but now it should be declared like this
    // ),
    brightness: Brightness.light,
    primaryColor: appColors["primary"]!,
    buttonTheme: ButtonThemeData(
      buttonColor: appColors["primary"]!,
      disabledColor: appColors["grey"]!,
    ));
