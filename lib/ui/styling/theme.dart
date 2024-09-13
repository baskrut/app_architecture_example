import 'package:app_architecture_example/ui/styling/colors.dart';
import 'package:flutter/material.dart';

final ThemeData appTheme = _buildTheme();

///there is Roboto font family it's uses as a default font style for flutter app

ThemeData _buildTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(primary: appLightBlue),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: appLightBlue,
      selectionColor: appLightBlue,
      selectionHandleColor: appLightBlue,
    ),
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        fontStyle: FontStyle.normal,
        color: textDarkGrey,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        fontStyle: FontStyle.normal,
        color: textDarkGrey,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: TextStyle(
        fontStyle: FontStyle.normal,
        color: textDarkGrey,
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
      ),

      ///Use labelSmall for button
      labelSmall: TextStyle(
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontSize: 18.0,
      ),
    ),
  );
}
