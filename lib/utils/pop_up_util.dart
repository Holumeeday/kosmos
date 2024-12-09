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
