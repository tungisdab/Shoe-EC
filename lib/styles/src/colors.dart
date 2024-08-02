import 'package:flutter/material.dart';

class AppColors {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color textColor;
  final Color primaryColor;
  final Color dotlineColor;
  final Color tertiary;
  final Color shadowColor;

  AppColors({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.textColor,
    required this.primaryColor,
    required this.dotlineColor,
    required this.tertiary,
    required this.shadowColor,
  });

  static final AppColors light = AppColors(
    backgroundColor: Colors.white,
    foregroundColor: Colors.transparent,
    textColor: Colors.black,
    primaryColor: Colors.red,
    dotlineColor: Colors.grey,
    tertiary: Colors.white,
    shadowColor: Colors.grey.withOpacity(0.1),
  );

  static final AppColors dark = AppColors(
    backgroundColor: Colors.black,
    foregroundColor: Colors.transparent,
    textColor: Colors.white,
    primaryColor: Colors.red,
    dotlineColor: Colors.grey,
    tertiary: Colors.grey,
    shadowColor: Colors.white.withOpacity(0.1),
  );

}
