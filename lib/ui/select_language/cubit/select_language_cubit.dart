import 'dart:collection';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/constants/constants.dart';
import 'package:playkosmos_v3/models/locale_language_model.dart';

part 'select_language_state.dart';

/// Handles selection and searching of app locale
///
/// @author: Godwin Mathias
class SelectLanguageCubit extends Cubit<SelectLanguageState> {
  /// The unchangeable language list
  final List<LanguageLocaleModel> _fLanguageList =
      UnmodifiableListView(kLanguageList);

  SelectLanguageCubit()
      : super(
          SelectLanguageState(
            dLanguageList: List.from(kLanguageList),
            // Initially selected locale
            dSelectedLocale: kLanguageList.first.languageLocale,
            dSelectedLocaleLangName: kLanguageList.first.languageName,
          ),
        );

  ///To update [dLanguageList] by using the [searchQuery]
  void searchLanguage(String searchQuery) {
    List<LanguageLocaleModel> dSearchLanguageList = [];
    if (searchQuery.trim() == '') {
      dSearchLanguageList = _fLanguageList;
    } else {
      dSearchLanguageList = _fLanguageList.where(
        (language) {
          String query = searchQuery.trim().toLowerCase();
          String languageName = language.languageName.trim().toLowerCase();
          return languageName.contains(query);
        },
      ).toList();
    }
    emit(
      state.copyWith(
        dLanguageList: dSearchLanguageList,
      ),
    );
  }

  /// To set the locale
  void setLocale(Locale locale) {
    final fSelectedLocaleLangName = kLanguageList
        .singleWhere((value) => value.languageLocale == locale)
        .languageName;
    emit(state.copyWith(
      dSelectedLocale: locale,
      dSelectedLocaleLangName: fSelectedLocaleLangName,
    ));
  }
}
