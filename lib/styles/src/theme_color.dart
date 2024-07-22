import 'package:flutter/material.dart';

class ThemeColor{
  static Color navBar = const Color.fromARGB(255, 52, 50, 50);
  static Color purpleColor = const Color.fromARGB(255, 189, 180, 255);
  static Color bgColor = const Color.fromARGB(255, 255, 255, 255);
  static Color chatColor = Colors.deepPurple.shade100;
  static Color listColor = Colors.deepPurple.shade50;

  final gradient = const LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xFF64B5F6),
      Color(0xFF9575CD),
      Color(0xFFF06292),
      Color(0xFFF9A825),
    ],
    tileMode: TileMode.mirror,
  );
}
