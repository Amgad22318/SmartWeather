import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class Themes {
  static ThemeData lightTheme = ThemeData(
      drawerTheme: const DrawerThemeData(backgroundColor: defaultAppColor),
      colorScheme: const ColorScheme.light(
        primary: defaultAppColor,
        secondary: defaultAppColor,
      ),
      iconTheme: const IconThemeData(color: defaultAppWhiteColor),
      buttonTheme: const ButtonThemeData(
        buttonColor: defaultDarkBlue,
      ),
      scaffoldBackgroundColor: defaultAppColor,
      appBarTheme: const AppBarTheme(
          backgroundColor: defaultAppColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          )));

  static ThemeData darkTheme = ThemeData(
      drawerTheme: const DrawerThemeData(backgroundColor: defaultDarkBlue),
      colorScheme: const ColorScheme.light(
        primary: defaultDarkBlue,
        secondary: defaultDarkBlue,
      ),
      iconTheme: const IconThemeData(color: defaultAppWhiteColor),
      buttonTheme: const ButtonThemeData(
        buttonColor: defaultDarkBlue,
      ),
      scaffoldBackgroundColor: defaultDarkBlue,
      appBarTheme: const AppBarTheme(
          backgroundColor: defaultDarkBlue,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          )));
}
