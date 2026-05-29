import 'package:flutter/material.dart';
import 'package:weather_app/constants/colors.dart';

class ThemeApp {
  //theme trời mưa
  static ThemeData rainTheme = ThemeData(
    primarySwatch: ColorsApp.textColor == Colors.white
        ? Colors.blue
        : Colors.orange,
    scaffoldBackgroundColor: ColorsApp.backgroundColor,
  );
  //theme trời nắng
  static ThemeData sunTheme = ThemeData(
    primarySwatch: ColorsApp.textSun == Colors.white
        ? Colors.blue
        : Colors.orange,
    scaffoldBackgroundColor: ColorsApp.backgroundSun,
  );
  //theme trời bình thường
  static ThemeData normalTheme = ThemeData(
    primarySwatch: ColorsApp.textNormal == Colors.white
        ? Colors.blue
        : Colors.orange,
    scaffoldBackgroundColor: ColorsApp.backgroundNormal,
  );
}
