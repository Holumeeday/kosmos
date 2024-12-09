class CountriesStatesModel {
  /// Name of the country
  final String name;

  /// 3 letters code of the country
  final String iso3;

  /// 2 letters code of the country
  final String iso2;

  /// The international phone code of the country
  final String phoneCode;

  /// Translations of the [name] to other localizations
  final Map<String, String> translations;

  /// The flag of the currency in String
  final String flag;

  /// The flag of the currency in unicode
  final String flagU;

  /// The states of the currency
  final List<States> states;

  const CountriesStatesModel({
    required this.name,
    required this.iso3,
    required this.iso2,
    required this.phoneCode,
    required this.translations,
    required this.flag,
    required this.flagU,
    required this.states,
  });

  /// TO show the localized name of the country
  String localizedName(String languageCode) {
    return translations[languageCode] ?? name;
  }

  /// TO show the phone code and the plus sign
  String get phoneCodeAndPlus => '+$phoneCode';
}

class States {
  /// The name of the state
  final String name;

  /// Translations of the [name] to other localizations
  final Map<String, String> translations;

  const States({
    required this.name,
    required this.translations,
  });

  /// To show the localized name of the state
  String localizedName(String languageCode) {
    return translations[languageCode] ?? name;
  }
}
