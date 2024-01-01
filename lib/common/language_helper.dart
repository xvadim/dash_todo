import 'package:flutter/material.dart';

class LanguageHelper {
  static const kEnglishLocaleName = 'en';
  static const kUkrainianLocaleName = 'uk';

  static const kEnglishLocaleTitle = '🇬🇧 English';
  static const kUkrainianLocaleTitle = '🇺🇦 Українська';

  static const kEnglishLocale = Locale(kEnglishLocaleName);
  static const kUkrainianLocale = Locale(kUkrainianLocaleName);

  static const kLanguageEnglishIndex = 0;
  static const kLanguageUkrainianIndex = 1;

  static const sLocales = <int, Locale>{
    kLanguageEnglishIndex: kEnglishLocale,
    kLanguageUkrainianIndex: kUkrainianLocale,
  };
}
