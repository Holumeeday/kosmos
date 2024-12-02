import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/select_language/widgets/select_language_list.dart';

/*
This class defines the select language modal
@author: Ugochukwu Umeh
@date: 24 Mar, 2023
@modified: 16 Jun, 2023
*/
class SelectLanguageModal extends StatelessWidget {
  const SelectLanguageModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  context.loc.appLanguage,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.tertiary,
                  size: 23,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        const VSpace(20),
        const Flexible(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: SelectLanguageSearchList(),
          ),
        ),
      ],
    );
  }
}
