import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// The default shape of the snackbar
final ShapeBorder _kSnackbarShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(4),
);

/// The default duration
const Duration _kSnackbarDuration = Duration(seconds: 4);

class SnackBarUtil {
  /// If a snack bar can be shown. Usually false only in case where there is a
  /// persistent snackbar
  static bool canShowSnackbar = true;

  /// To set [canShowSnackbar]
  static void setCanShowSnackbar(bool value) {
    canShowSnackbar = value;
  }

  /// Show a normal snackbar
  static void show({
    required Widget content,
    ShapeBorder? shape,
    Duration? duration,
    DismissDirection dismissDirection = DismissDirection.down,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  }) {
    // If snack bar cannot be shown then return else hide the current one
    // before showing the current one
    if (!canShowSnackbar) return;
    final context = GetContext.current;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: content,
          shape: shape ?? _kSnackbarShape,
          duration: duration ?? _kSnackbarDuration,
          dismissDirection: dismissDirection,
          behavior: behavior,
        ),
      );
  }

  /// Show error snackbar
  static void showError({required String message}) {
    final context = GetContext.current;
    show(
      content: Row(
        children: [
          Icon(
            Icons.warning_rounded,
            color: context.colors.surface,
          ),
          const HSpace(8),
          Flexible(
            child: Text(
              message,
              maxLines: 2,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colors.surface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Show error snackbar
  static void showInfo({required String message}) {
    final context = GetContext.current;
    show(
      content: Row(
        children: [
          Icon(
            Icons.info,
            color: context.colors.surface,
          ),
          const HSpace(8),
          Flexible(
            child: Text(
              message,
              maxLines: 2,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colors.surface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// To show a default snack bar with a text
  static void showDefaultTextSnackbar({
    required String snackbarText,
    int snackbarMilliseconds = 2500,
    int? maxLines,
  }) {
    final context = GetContext.current;
    show(
      content: Text(
        snackbarText,
        maxLines: maxLines,
        style: context.textTheme.bodyMedium?.copyWith(
          color: context.colors.surface,
        ),
      ),
      duration: Duration(milliseconds: snackbarMilliseconds),
    );
  }

  /// Create a snack bar that can't be closed by the user
  static void showPersistentSnackBar({
    required Widget content,
    SnackBarBehavior behavior = SnackBarBehavior.fixed,
  }) {
    // The persistent snackbar is always shown
    setCanShowSnackbar(true);
    show(
      content: content,
      duration: const Duration(days: 1),
      dismissDirection: DismissDirection.none,
      behavior: behavior,
    );
    // The persistent snackbar prevents others from been shown
    setCanShowSnackbar(false);
  }

  /// Clear all snack bar from queue and updates [canShowSnackbar] to true
  static void get clearAllSnackBar {
    final context = GetContext.current;
    ScaffoldMessenger.of(context).clearSnackBars();
    setCanShowSnackbar(true);
  }
}
