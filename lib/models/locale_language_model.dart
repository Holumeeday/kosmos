import 'dart:ui';

/*
This class stores the language info
@author: Ugochukwu Umeh
*/
class LanguageLocaleModel {
  ///The language name
  final String languageName;

  ///The country name
  final String countryName;

  ///The flag
  final String countryFlag;

  ///The locale of the country
  final Locale languageLocale;

  const LanguageLocaleModel({
    required this.languageName,
    required this.countryName,
    required this.countryFlag,
    required this.languageLocale,
  });
}
