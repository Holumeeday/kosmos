import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/*
This class hold a radio and text and changes their order
@author: Ugochukwu Umeh
@date: 01 Mar, 2023
@modified: 16 Jun, 2023
*/
class CustomRadioListTile<T> extends StatelessWidget {
  ///To decide if the radio comes before the text
  final bool fRadioFirst;

  ///When it's clicked
  final VoidCallback fOnChanged;

  ///The value of the radio
  final T fValue;

  ///The text title. This is already scaled here so no need for scaling
  final String fTitle;

  ///The text subtitle widget.
  final Widget? fSubtitle;

  ///The radio group value
  final T? fGroupValue;

  ///The title text size
  final double fTextSize;

  ///The text font weight
  final FontWeight? fFontWeight;

  ///The color of the title text. Defaults to the text color
  final Color? fTitleColor;

  ///The padding
  final EdgeInsetsGeometry fContentPadding;

  ///The margin
  final EdgeInsetsGeometry fMargin;

  ///The alignment of the row. Defaults to start
  final MainAxisAlignment fRowMainAlignment;

  /// The semantic label
  final String? fSemanticLabel;

  ///This creates a custom text and radio widget whose order depends on
  ///[fRadioFirst]. When it's selected, [fOnChanged] is called.
  ///[fTextSize] is already scaled here, input the value as it is in the design
  ///[fContentPadding] defaults to zero
  const CustomRadioListTile({
    super.key,
    required this.fRadioFirst,
    required this.fOnChanged,
    required this.fTextSize,
    this.fFontWeight,
    required this.fTitle,
    required this.fValue,
    required this.fGroupValue,
    this.fSubtitle,
    this.fContentPadding = EdgeInsets.zero,
    this.fMargin = EdgeInsets.zero,
    this.fTitleColor,
    this.fRowMainAlignment = MainAxisAlignment.start,
    this.fSemanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    ///The title and subtitle column
    final fTextTileWidget = Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              fTitle,
              style: TextStyle(
                fontSize: fTextSize,
                fontWeight: fFontWeight,
                color: fTitleColor ?? context.appColors.textColor,
              ),
            ),
          ),
          fSubtitle ?? const SizedBox(),
        ],
      ),
    );

    ///The radio widget
    final fRadioWidget = Radio.adaptive(
      value: fValue,
      activeColor: context.colors.secondary,
      groupValue: fGroupValue,
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
      ),
      onChanged: (name) {
        fOnChanged();
      },
    );
    return MergeSemantics(
      child: Padding(
        padding: fMargin,
        child: InkWell(
          onTap: fOnChanged,
          child: Padding(
            padding: fContentPadding,
            child: fRadioFirst
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: fRowMainAlignment,
                    children: [
                      fRadioWidget,
                      const HSpace(7),
                      fTextTileWidget,
                    ],
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: fRowMainAlignment,
                    children: [
                      fTextTileWidget,
                      const HSpace(7),
                      fRadioWidget,
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
