import 'package:app_shoes_ec/styles/src/colors.dart';
import 'package:app_shoes_ec/styles/src/size.dart';
import 'package:flutter/material.dart';

class AppTheme {
  final AppColors chosenColor;

  AppTheme(this.chosenColor);

  ThemeData getTheme() {
    final sizes = AppValues();

    return ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: chosenColor.primaryColor,
          background: chosenColor.backgroundColor,
          primary: chosenColor.primaryColor,
          tertiary: chosenColor.tertiary,
          shadow: chosenColor.shadowColor,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: chosenColor.primaryColor,
          foregroundColor: chosenColor.foregroundColor,
          iconTheme: IconThemeData(
            color: chosenColor.textColor, // Màu cho leading
          ),
          actionsIconTheme: const IconThemeData(
            color: Colors.red, // Màu cho actions
          ),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: chosenColor.textColor,
            fontSize: sizes.normalText,
          ),
          headlineLarge: TextStyle(
            color: chosenColor.textColor,
            fontSize: sizes.largeText,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(chosenColor.primaryColor),
          foregroundColor:
              MaterialStateProperty.all<Color>(chosenColor.backgroundColor),
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(
              fontSize: sizes.smallText,
            ),
          ),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all<Color>(chosenColor.primaryColor),
        overlayColor:
            MaterialStateProperty.all<Color>(chosenColor.backgroundColor),
        trackColor:
            MaterialStateProperty.all<Color>(chosenColor.backgroundColor),
        trackOutlineColor:
            MaterialStateProperty.all<Color>(chosenColor.backgroundColor),
      ),
    );
  }
}
