part of 'select_language_cubit.dart';

class SelectLanguageState extends Equatable {
  /// The selected locale of the app
  final Locale dSelectedLocale;

  /// The selected locale language name
  final String dSelectedLocaleLangName;

  /// The language list
  final List<LanguageLocaleModel> dLanguageList;

  const SelectLanguageState({
    required this.dSelectedLocale,
    required this.dSelectedLocaleLangName,
    required this.dLanguageList,
  });

  @override
  List<Object> get props => [
        dSelectedLocale,
        dSelectedLocaleLangName,
        dLanguageList,
      ];

  SelectLanguageState copyWith({
    Locale? dSelectedLocale,
    String? dSelectedLocaleLangName,
    List<LanguageLocaleModel>? dLanguageList,
  }) {
    return SelectLanguageState(
      dSelectedLocale: dSelectedLocale ?? this.dSelectedLocale,
      dSelectedLocaleLangName:
          dSelectedLocaleLangName ?? this.dSelectedLocaleLangName,
      dLanguageList: dLanguageList ?? this.dLanguageList,
    );
  }
}
