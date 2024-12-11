import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/buttons.dart';
import 'package:playkosmos_v3/common_widgets/sizes.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/// This dialog shows the success message and the let go button
///
/// used in the authentication flow screens
/// @author: Godwin Mathias
class ActionDialog extends StatelessWidget {
  const ActionDialog({
    super.key,
    required this.fTitle,
    required this.fOnLetGo,
    required this.fcontent,
  });

  /// The title
  final String fTitle;

  /// On click let go button
  final VoidCallback fOnLetGo;

  final Widget fcontent;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // The title
            Text(
              fTitle,
              style: context.appTextTheme.header1,
              textAlign: TextAlign.center,
            ),
            const VSpace(16),
            fcontent,
            const VSpace(40),

            // Let go button
            PrimaryGradientButton(
              fOnPressed: fOnLetGo,
              fChild: Text(context.loc.letGo),
            )
          ],
        ),
      ),
    );
  }
}
