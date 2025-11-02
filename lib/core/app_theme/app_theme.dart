import 'package:evently/core/app_theme/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: AppColor.lightBg,
      primaryColor: AppColor.primaryColor,
      primaryColorLight: Colors.white,
      primaryColorDark: Colors.black,
      textTheme: TextTheme(
        bodySmall: TextStyle(fontSize: 14, color: Colors.black),
        bodyMedium: TextStyle(fontSize: 18, color: Colors.black),
        bodyLarge: TextStyle(fontSize: 20, color: Colors.black),
      ));
  static ThemeData DrakTheme = ThemeData(
      scaffoldBackgroundColor: AppColor.DarkBg,
      primaryColor: AppColor.primaryColor,
      primaryColorLight: Colors.black,
      primaryColorDark: Colors.white,
      textTheme: TextTheme(
        bodySmall: TextStyle(fontSize: 14, color: Colors.white),
        bodyMedium: TextStyle(fontSize: 18, color: Colors.white),
        bodyLarge: TextStyle(fontSize: 20, color: Colors.white),
      ));
}
