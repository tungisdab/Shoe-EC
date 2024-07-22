import 'package:flutter/material.dart';

class AppColors {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color textColor;
  final Color primaryColor;
  final Color dotlineColor;

  AppColors({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.textColor,
    required this.primaryColor,
    required this.dotlineColor,
  });

  static final AppColors light = AppColors(
    backgroundColor: Colors.white,
    foregroundColor: Colors.transparent,
    textColor: Colors.black,
    primaryColor: Colors.blue,
    dotlineColor: Colors.grey,
  );

  static final AppColors dark = AppColors(
    backgroundColor: Colors.black,
    foregroundColor: Colors.transparent,
    textColor: Colors.white,
    primaryColor: Colors.blue,
    dotlineColor: Colors.grey,
  );

}