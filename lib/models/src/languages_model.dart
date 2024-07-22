import 'package:flutter/material.dart';
import '../../gen/assets.gen.dart';
import 'dart:ui';

enum Language {
  english(
    Locale('en', 'UK'),
    Assets.uk,
    'English',
  ),
  vietnamese(
    Locale('vi', 'VN'),
    Assets.vn,
    'Tiếng Việt',
  ),
  spanish(
    Locale('es', 'ES'),
    Assets.es,
    'Español',
  );

  const Language(this.locale, this.image, this.text);

  final Locale locale;
  final AssetGenImage image;
  final String text;
}

class Assets {
  static const uk = AssetGenImage('assets/icons/flags/uk.png');
  static const vn = AssetGenImage('assets/icons/flags/vietnam.png');
  static const es = AssetGenImage('assets/icons/flags/spain.png');
}
