import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/empty_state.dart';
import 'package:playkosmos_v3/common_widgets/sizes.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/*
The dialog for the city, state and country picker
@author: Ugochukwu Umeh
 */
class CSCPickerSheet extends StatelessWidget {
  /// The list of csc
  final Widget fShowList;

  /// if the list is not empty
  final bool fListIsNotEmpty;

  /// The hint text
  final String fHintText;

  /// The text editing controller
  final TextEditingController fTextController;

  const CSCPickerSheet({
    super.key,
    required this.fTextController,
    required this.fHintText,
    required this.fListIsNotEmpty,
    required this.fShowList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
        8,
      )),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: context.useHeightPercent(90),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Country code header text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                context.loc.countryCode,
                style: context.appTextTheme.header1,
              ),
            ),
            const VSpace(11),
            const Divider(),
            const VSpace(24),

            // Search field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: fTextController,
                style: context.appTextTheme.buttonLarge,
                decoration: InputDecoration(
                  hintText: context.loc.searchCountryCode,
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
                          if (fTextController.text.isNotEmpty) {
                            fTextController.clear();
                          }
                        },
                        child: AnimatedBuilder(
                            animation: fTextController,
                            builder: (context, child) {
                              return Icon(
                                fTextController.value.text.isEmpty
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
            const VSpace(16),

            // The countries
            Flexible(
              child: fListIsNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: fShowList,
                    )
                  : EmptyState(
                      fIconWidget: Icon(
                        Icons.search_off_rounded,
                        color: context.colors.secondary,
                        size: 50,
                      ),
                      fTitleText: context.loc.noSearchResultFound,
                      fSubtitleText: context.loc.refineYourSearchCriteria,
                    ),
            )
          ],
        ),
      ),
    );
  }
}

/*
This contains a padding of 20 for horizontal and vertical around the text field
@author: Ugochukwu Umeh
 */
// ignore: unused_element
class _CSCPickerTextField extends StatelessWidget {
  /// The hint text
  final String fHintText;

  /// The text editing controller
  final TextEditingController fTextController;

  /// This contains a padding of 20 for horizontal and vertical around the text
  /// field
  const _CSCPickerTextField({
    required this.fHintText,
    required this.fTextController,
  });

  @override
  Widget build(BuildContext context) {
    /// The input border
    final InputBorder fInputBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: context.colors.tertiary,
      ),
    );
    final InputBorder fFocusedBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: context.colors.secondary,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: TextField(
        controller: fTextController,
        style: context.textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: fHintText,
          border: fInputBorder,
          enabledBorder: fInputBorder,
          focusedBorder: fFocusedBorder,
          suffixIcon: Icon(
            Icons.search_rounded,
            size: 30,
            color: context.colors.secondary,
          ),
        ),
      ),
    );
  }
}
