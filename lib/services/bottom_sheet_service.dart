import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/*
This class handles all the view models call for modal bottom sheet
@author: Ugochukwu
*/
class ModalBottomSheetService {
  ///The default modal to generate other modals
  Future showDefaultModal({
    required double maxHeight,
    required Widget child,
    bool isScrollControlled = true,
    bool isDismissible = true,
    bool enableDrag = true,
    bool showDragHandle = false,
    double borderRadius = 16,
    double verticalPadding = 16,
    double horizontalPadding = 0,
    Color? backgroundColor,
    Color? barrierColor,
  }) {
    final BuildContext context = GetContext.current;
    final double height = context.useHeightPercent(maxHeight);
    return showModalBottomSheet(
      context: context,
      showDragHandle: showDragHandle,
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      useSafeArea: true,
      enableDrag: enableDrag,
      clipBehavior: Clip.hardEdge,
      constraints: BoxConstraints(maxHeight: height),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        child: child,
      ),
    );
  }

  ///Shows the modal after an action. The modal is not dismissible or draggable
  ///
  ///It requires a [title] which shows below the done animation, a [subtitle]
  ///which shows below the title, a primary button [proceedText] to proceed
  ///(returns true) and in cases and an outline primary button [backText] to go
  ///back (returns false). [titleColor] to set a title text color else text
  ///color is used
  Future showDefaultAnimationButtonsModal({
    String? title,
    String? subtitle,
    String? proceedText,
    double borderRadius = 16,
    String? backText,
    Color? titleColor,
    double maxHeight = 75,
    bool isDismissible = false,
  }) {
    final BuildContext context = GetContext.current;
    return showDefaultModal(
      maxHeight: maxHeight,
      isDismissible: isDismissible,
      enableDrag: false,
      borderRadius: borderRadius,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //Done animation
              Icon(
                Icons.check_circle_outlined,
                size: 172,
                color: context.colors.primary,
              ),

              // Title and subtitle
              MergeSemantics(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title
                    if (title != null) ...[
                      const VSpace(24),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: context.textTheme.headlineMedium?.copyWith(
                          color: titleColor,
                        ),
                      ),
                    ],

                    // Subtitle
                    if (subtitle != null) ...[
                      const VSpace(16),
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: context.colors.tertiary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Proceed button
              if (proceedText != null)
                PrimaryButton(
                  fButtonRadius: 6,
                  fMargin: const EdgeInsets.only(top: 20),
                  fPadding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                  fOnTap: () {
                    Navigator.pop(context, true);
                  },
                  fText: proceedText,
                ),

              // Back button
              if (backText != null)
                OutlinePrimaryButton(
                  fTextColor: context.colors.secondary,
                  fOnTap: () {
                    Navigator.pop(context, false);
                  },
                  fMargin: const EdgeInsets.only(top: 20),
                  fPadding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                  fButtonRadius: 6,
                  fText: backText,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
