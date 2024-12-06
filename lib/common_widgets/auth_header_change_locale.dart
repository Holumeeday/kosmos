import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/select_language/cubit/select_language_cubit.dart';
import 'package:playkosmos_v3/utils/pop_up_util.dart';

/*
This class defines the row widget placed in either create account or login view
that contains the locale name and other text
@author: Ugochukwu Umeh
*/
class AuthHeaderChangeLocale extends StatelessWidget {
  const AuthHeaderChangeLocale({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Semantics(
        button: true,
        enabled: true,
        excludeSemantics: true,
        label: context.loc.changeSelectedLanguage,
        child: GestureDetector(
          onTap: () {
            //Shows a modal bottom sheet to change the language of the app
            showDefaultModal(
              context,
              maxHeight: 65,
              child: const SelectLanguageModal(),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                CupertinoIcons.globe,
                color: Colors.white,
                size: 23,
              ),
              const HSpace(4),

              //Language text
              Flexible(
                child: Text(
                  context.select((SelectLanguageCubit cubit) =>
                      cubit.state.dSelectedLocaleLangName),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              const HSpace(4),

              //Dropdown arrow
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.white,
                size: 23,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
