// New model for country properties
class CountryModel {
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

  const CountryModel({
    required this.name,
    required this.iso3,
    required this.iso2,
    required this.phoneCode,
    required this.translations,
    required this.flag,
    required this.flagU,
  });

  /// To show the localized name of the country
  String localizedName(String languageCode) {
    return translations[languageCode] ?? name;
  }

  /// To show the phone code with the plus sign
  String get phoneCodeAndPlus => '+$phoneCode';

  /// Converts the object to a JSON-compatible map
  Map<String, dynamic> toJson() => {
        'name': name,
        'iso3': iso3,
        'iso2': iso2,
        'phoneCode': phoneCode,
        'translations': translations,
        'flag': flag,
        'flagU': flagU,
      };
}
