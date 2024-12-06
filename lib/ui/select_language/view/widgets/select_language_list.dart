import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/models/locale_language_model.dart';
import 'package:playkosmos_v3/ui/select_language/cubit/select_language_cubit.dart';

/*
This class creates the main select language list
@author: Ugochukwu Umeh
*/
class SelectLanguageSearchList extends StatelessWidget {
  const SelectLanguageSearchList({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SelectLanguageView();
  }
}

/*
This class shows the select language list
@author: Ugochukwu Umeh
*/
class _SelectLanguageView extends StatefulWidget {
  const _SelectLanguageView();

  @override
  State<_SelectLanguageView> createState() => _SelectLanguageViewState();
}

class _SelectLanguageViewState extends State<_SelectLanguageView> {
  ///The search text controller
  late TextEditingController _fSearchController;

  @override
  void initState() {
    super.initState();
    _fSearchController = TextEditingController();
    _fSearchController.addListener(
      () {
        context
            .read<SelectLanguageCubit>()
            .searchLanguage(_fSearchController.text);
      },
    );
  }

  @override
  void dispose() {
    _fSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: context.loc.languageSelectionOptions,
      container: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //Search text field
          Semantics(
            label: context.loc.searchForALanguage,
            container: true,
            child: ExcludeSemantics(
              child: TextField(
                controller: _fSearchController,
                style: context.appTextTheme.buttonLarge,
                decoration: InputDecoration(
                  hintText: context.loc.searchLanguageHint,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 13,
                    horizontal: 11,
                  ),
                  filled: true,
                  fillColor: context.colors.tertiary.withOpacity(0.1),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    child: GestureDetector(
                        onTap: () {
                          if (_fSearchController.text.isNotEmpty) {
                            _fSearchController.clear();
                          }
                        },
                        child: AnimatedBuilder(
                            animation: _fSearchController,
                            builder: (context, child) {
                              return Icon(
                                _fSearchController.value.text.isEmpty
                                    ? Icons.search_rounded
                                    : Icons.close,
                                color: context.appColors.darkGreyColor,
                                size: 24,
                              );
                            })),
                  ),
                ),
              ),
            ),
          ),
          const VSpace(20),

          //Language list
          BlocSelector<SelectLanguageCubit, SelectLanguageState,
              List<LanguageLocaleModel>>(
            selector: (cubit) => cubit.dLanguageList,
            builder: (_, languageList) => Column(
              mainAxisSize: MainAxisSize.min,
              children: languageList.map<Widget>(
                (fLanguageModel) {
                  //Listens to the current locale name
                  final String fLocale = context.loc.localeName;
                  return Semantics(
                    label: context.loc.currentLanguageSelectionOption(
                        '${fLanguageModel.languageName} ${fLanguageModel.countryName}'),
                    selected:
                        fLanguageModel.languageLocale.languageCode == fLocale,
                    child: RadioListTile(
                      activeColor: context.colors.secondary,
                      value: fLanguageModel.languageLocale.languageCode,
                      groupValue: fLocale,
                      title: Wrap(
                        children: [
                          //Language name and country
                          Text.rich(
                            TextSpan(
                              text: fLanguageModel.languageName,
                              style: context.appTextTheme.buttonLarge,
                              children: [
                                // Language name
                                TextSpan(
                                  text: ' (${fLanguageModel.countryName})  ',
                                  style: context.appTextTheme.buttonLarge
                                      ?.copyWith(
                                    color: context.colors.tertiary,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //Flag
                          SvgPicture.asset(
                            fLanguageModel.countryFlag,
                            width: 16,
                            height: 20,
                          ),
                        ],
                      ),
                      contentPadding: EdgeInsets.zero,
                      onChanged: (value) {
                        context
                            .read<SelectLanguageCubit>()
                            .setLocale(fLanguageModel.languageLocale);
                      },
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
