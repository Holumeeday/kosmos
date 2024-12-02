import 'package:flutter/material.dart';
import 'package:playkosmos_v3/assets_gen/assets.gen.dart';
import 'package:playkosmos_v3/models/locale_language_model.dart';

///The language list
final List<LanguageLocaleModel> kLanguageList = [
  // Language Locale Model for English (UK)
  LanguageLocaleModel(
    languageName: 'English',
    countryName: 'UK',
    countryFlag: Assets.svgs.flags.gbFlag.path,
    languageLocale: const Locale('en'),
  ),
  // Language Locale Model for Finnish (Finland)
  LanguageLocaleModel(
    languageName: 'Suomi',
    countryName: 'Suomi',
    countryFlag: Assets.svgs.flags.fiFlag.path,
    languageLocale: const Locale('fi'),
  ),
  // Language Locale Model for French (France)
  LanguageLocaleModel(
    languageName: 'Français',
    countryName: 'France',
    countryFlag: Assets.svgs.flags.frFlag.path,
    languageLocale: const Locale('fr'),
  ),
  // Language Locale Model for Hindi (India)
  LanguageLocaleModel(
    languageName: 'हिन्दी',
    countryName: 'भारत',
    countryFlag: Assets.svgs.flags.inFlag.path,
    languageLocale: const Locale('hi'),
  ),
  // Language Locale Model for Sinhala (Sri lanka)
  LanguageLocaleModel(
    languageName: 'සිංහල',
    countryName: 'Sri Lanka',
    countryFlag: Assets.svgs.flags.lkFlag.path,
    languageLocale: const Locale('si'),
  ),
  // Language Locale Model for Tamil (Sri lanka)
  LanguageLocaleModel(
    languageName: 'தமிழ்',
    countryName: 'Sri Lanka',
    countryFlag: Assets.svgs.flags.lkFlag.path,
    languageLocale: const Locale('ta'),
  ),
  // Language Locale Model for Chinese (China)
  LanguageLocaleModel(
    languageName: '简体中文',
    countryName: 'China',
    countryFlag: Assets.svgs.flags.cnFlag.path,
    languageLocale: const Locale('zh'),
  ),
];
