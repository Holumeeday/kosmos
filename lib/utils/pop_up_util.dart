import 'package:flutter/material.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/// A utility function to show a customizable modal bottom sheet.
///
/// This function provides a customizable modal bottom sheet with various
/// options for configuring its appearance and behavior. You can adjust properties
/// such as the maximum height, scroll behavior, padding, and whether the modal
/// is dismissible or draggable. The modal bottom sheet can also be customized
/// with a background color and barrier color, along with other visual and interaction options.
///
/// Example usage:
/// ```dart
/// showDefaultModal(
///   maxHeight: 50,
///   child: MyCustomWidget(), // The content of the modal
///   isScrollControlled: true,
///   isDismissible: false,
///   showDragHandle: true,
/// );
/// ```
///
/// Parameters:
/// - `maxHeight`: The maximum height for the modal as a percentage of screen height (0.0 to 1.0).
/// - `child`: The widget to be displayed inside the modal bottom sheet.
/// - `isScrollControlled`: Whether the modal's height is determined by its content or `maxHeight`. Defaults to `true`.
/// - `isDismissible`: Whether the modal can be dismissed by tapping outside. Defaults to `true`.
/// - `enableDrag`: Whether the modal can be dragged up and down. Defaults to `true`.
/// - `showDragHandle`: Whether to display the drag handle at the top of the modal. Defaults to `false`.
/// - `borderRadius`: The radius for the top-left and top-right corners of the modal. Defaults to `16.0`.
/// - `verticalPadding`: Vertical padding for the content inside the modal. Defaults to `16.0`.
/// - `horizontalPadding`: Horizontal padding for the content inside the modal. Defaults to `0.0`.
/// - `backgroundColor`: The background color of the modal. If null, the default theme color is used.
/// - `barrierColor`: The color of the overlay behind the modal. If null, the default barrier color is used.
///
/// Returns:
/// - A `Future` that completes when the modal is closed.
Future showDefaultModal(
  BuildContext context, {
  double? maxHeight, // Optional max height
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
    constraints: maxHeight != null
        ? BoxConstraints(maxHeight: context.useHeightPercent(maxHeight))
        : null, // Only apply constraints when maxHeight is provided
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

///This shows a custom dialog which holds a [child]
Future showCustomDialog(
  BuildContext context, {
  required Widget Function(BuildContext context) builder,
  bool barrierDismissible = true,
}) {
  return showDialog(
    useSafeArea: true,
    barrierDismissible: barrierDismissible,
    context: context,
    builder: builder,
  );
}

///For dialogs
///
///[title] is the header of the dialog, while [subtitle] is the content.
///[textAlign] helps to align the title and content text, and defaults to
///[TextAlign.center] for both [titleTextAlign] and [subTitleTextAlign]
Future showDialogWithOneAction(
  BuildContext context, {
  required String title,
  required String subtitle,
  required String trueActionText,
  Color? trueActionColor,
  bool barrierDismissible = true,
  TextAlign titleTextAlign = TextAlign.center,
  TextAlign subTitleTextAlign = TextAlign.center,
}) {
  return showCustomDialog(
    context,
    barrierDismissible: barrierDismissible,
    builder: (context) => AlertDialog.adaptive(
      title: Text(
        title,
        textAlign: titleTextAlign,
        style: context.appTextTheme.buttonMedium,
      ),
      content: SingleChildScrollView(
        child: Text(
          subtitle,
          textAlign: subTitleTextAlign,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colors.tertiary,
          ),
        ),
      ),
      actions: [
        // Proceed
        Builder(builder: (_) {
          final Color color = trueActionColor ?? context.colors.secondary;
          return TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: color),
            child: Text(
              trueActionText,
              textAlign: TextAlign.end,
              style: context.textTheme.titleSmall?.copyWith(
                color: color,
              ),
            ),
          );
        }),
      ],
    ),
  );
}

///For dialogs
///
///[title] is the header of the dialog, while [subtitle] is the content.
///[isTrueActionRed] determines if the proceed text button is red in color or
///blue.
///
///[showActions] decides if action buttons should be shown. [falseActionText]
///is the first action text to be seen (the left), returns [false] and defaults to [Cancel]
///while [trueActionText] is the dialog action button that returns [true] and
///it defaults to [Proceed]
///
/// [titleTextAlign] and [subTitleTextAlign] helps with aligning the [title]
/// and [subtitle] text
Future showDefaultDialog(
  BuildContext context, {
  required String title,
  required String subtitle,
  bool isTrueActionRed = false,
  Color? falseActionColor,
  Color? trueActionColor,
  String? trueActionText,
  String? falseActionText,
  bool barrierDismissible = true,
  bool showActions = true,
  TextAlign titleTextAlign = TextAlign.center,
  TextAlign subTitleTextAlign = TextAlign.center,
}) {
  return showCustomDialog(
    context,
    barrierDismissible: barrierDismissible,
    builder: (context) {
      return AlertDialog.adaptive(
        title: Text(
          title,
          textAlign: titleTextAlign,
          style: context.appTextTheme.buttonMedium,
        ),
        content: SingleChildScrollView(
          child: Text(
            subtitle,
            textAlign: subTitleTextAlign,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colors.tertiary,
            ),
          ),
        ),
        actions: showActions
            ? [
                // Cancel
                Builder(builder: (_) {
                  final Color? color = falseActionColor ??
                      (isTrueActionRed
                          ? context.colors.secondary
                          : context.appColors.redColor);
                  return TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: TextButton.styleFrom(foregroundColor: color),
                    child: Text(
                      falseActionText ?? context.loc.cancel,
                      textAlign: TextAlign.end,
                      style: context.textTheme.titleSmall?.copyWith(
                        color: color,
                      ),
                    ),
                  );
                }),

                // Proceed
                Builder(builder: (_) {
                  final Color? color = trueActionColor ??
                      (isTrueActionRed
                          ? context.appColors.redColor
                          : context.colors.secondary);
                  return TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: TextButton.styleFrom(foregroundColor: color),
                    child: Text(
                      trueActionText ?? context.loc.proceedText,
                      textAlign: TextAlign.end,
                      style: context.textTheme.titleSmall?.copyWith(
                        color: color,
                      ),
                    ),
                  );
                }),
              ]
            : null,
      );
    },
  );
}
