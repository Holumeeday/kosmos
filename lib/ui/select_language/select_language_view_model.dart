import 'dart:collection';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:playkosmos_v3/constants/constants.dart';
import 'package:playkosmos_v3/models/locale_language_model.dart';

/*
This view model enables us change the language of the app
@author: Ugochukwu Umeh
*/
class SelectLanguageViewModel extends ChangeNotifier {
  /// The unchangeable language list
  final List<LanguageLocaleModel> _fLanguageList =
      UnmodifiableListView(kLanguageList);

  /// The language list
  List<LanguageLocaleModel> dLanguageList = List.from(kLanguageList);

  /// The reactive service
  // final LocaleReactiveService _fLocaleReactiveService = locator<LocaleReactiveService>();

  ///To update [dLanguageList] by using the [searchQuery]
  void searchLanguage(String searchQuery) {
    if (searchQuery.trim() == '') {
      dLanguageList = _fLanguageList;
    } else {
      dLanguageList = _fLanguageList.where(
        (language) {
          String query = searchQuery.trim().toLowerCase();
          String languageName = language.languageName.trim().toLowerCase();
          return languageName.contains(query);
        },
      ).toList();
    }
    notifyListeners();
  }

  /// To set the locale
  void setLocale(Locale locale) {
    // _fLocaleReactiveService.setLocale(locale);
  }
}
