import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/*
This displays more options when its not the user's post
@author: Ugochukwu Umeh
*/
class MoreOptionsNotUserModal extends StatelessWidget {
  /// Hide action
  final VoidCallback fHideProceedAction;

  /// Report action
  final VoidCallback fReportProceedAction;

  /// Block action
  final VoidCallback fBlockProceedAction;

  /// Remove action
  final VoidCallback fRemoveProceedAction;

  const MoreOptionsNotUserModal({
    super.key,
    required this.fHideProceedAction,
    required this.fReportProceedAction,
    required this.fBlockProceedAction,
    required this.fRemoveProceedAction,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hide
          MoreOptionsItem(
            fText: context.loc.hide,
            fOnTap: () => _showDialog(
              context,
              title: context.loc.hidePostFromUser,
              content: context.loc.hidePostDialogContent,
              proceedAction: fHideProceedAction,
            ),
          ),

          //Block
          MoreOptionsItem(
            fText: context.loc.block,
            fOnTap: () => _showDialog(
              context,
              title: context.loc.blockPostFromUser,
              content: context.loc.blockPostDialogContent,
              proceedAction: fBlockProceedAction,
            ),
          ),

          // Report
          MoreOptionsItem(
            fText: context.loc.report,
            fTextColor: context.colors.error,
            fOnTap: () {
              Navigator.pop(context);
              fReportProceedAction();
            },
          ),

          // Remove
          MoreOptionsItem(
            fText: context.loc.remove,
            fTextColor: context.colors.error,
            fOnTap: () => _showDialog(
              context,
              title: context.loc.removeThisUser,
              content: context.loc.removeUserDialogContent,
              proceedAction: fRemoveProceedAction,
            ),
          ),
        ],
      ),
    );
  }

  // Canceling activity dialog
  void _showDialog(
    BuildContext context, {
    required String title,
    required String content,
    required VoidCallback proceedAction,
  }) async {
    final bool result = await showDefaultDialog(
      context,
      title: title,
      barrierDismissible: false,
      subtitle: content,
      isTrueActionRed: true,
    );
    if (result && context.mounted) {
      context.pop();
      proceedAction();
    }
  }
}
