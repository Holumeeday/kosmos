import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/*
This displays more options when its the user's post
@author: Ugochukwu Umeh
*/
class ActivityMoreOptionsUserModal extends StatelessWidget {
  /// The link to copy
  final String fCopyLink;

  /// If its a shared post
  final bool fIsSharedPost;

  /// To cancel the activity
  final VoidCallback fCancelActivity;

  /// To manage the activity
  final VoidCallback fManageActivity;

  /// To edit the activity
  final VoidCallback fEditActivity;

  /// To delete the post
  final VoidCallback fDeletePost;

  const ActivityMoreOptionsUserModal({
    super.key,
    required this.fIsSharedPost,
    required this.fCopyLink,
    required this.fCancelActivity,
    required this.fManageActivity,
    required this.fEditActivity,
    required this.fDeletePost,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Manage
          if (!fIsSharedPost)
            MoreOptionsItem(
              fText: context.loc.manage,
              fOnTap: () {
                Navigator.pop(context);
                fManageActivity();
              },
            ),

          // Copy
          MoreOptionsItem(
            fText: context.loc.copyLink,
            fOnTap: () {
              Navigator.pop(context);
              _copyLink();
            },
          ),

          // Edit
          MoreOptionsItem(
            fText: context.loc.edit,
            fOnTap: () {
              Navigator.pop(context);
              fEditActivity();
            },
          ),

          // Cancel
          if (!fIsSharedPost)
            MoreOptionsItem(
              fText: context.loc.cancelActivity,
              fTextColor: context.colors.error,
              fOnTap: () => _cancelActivityDialog(context, fCancelActivity),
            ),

          // Delete
          if (fIsSharedPost)
            MoreOptionsItem(
              fText: context.loc.deletePost,
              fTextColor: context.colors.error,
              fOnTap: () => _deletePostDialog(context, fDeletePost),
            ),
        ],
      ),
    );
  }

  /// Link copied toast
  Future<void> _copyLink() async {
    await Clipboard.setData(ClipboardData(text: fCopyLink));
  }

  /// Canceling activity dialog
  Future<void> _cancelActivityDialog(
      BuildContext context, VoidCallback cancelActivity) async {
    final bool? result = await showDefaultDialog(
      context,
      title: GetContext.loc.cancelActivityDialogTitle,
      subtitle: GetContext.loc.cancelActivityDialogContent,
      isTrueActionRed: true,
      barrierDismissible: false,
    );
    if (result == true && context.mounted) {
      context.pop();
      cancelActivity();
    }
  }

  /// Delete activity post
  Future<void> _deletePostDialog(
      BuildContext context, VoidCallback deletePost) async {
    final bool? result = await showDefaultDialog(
      context,
      title: GetContext.loc.deletePostDialogTitle,
      subtitle: GetContext.loc.deletePostDialogContent,
      isTrueActionRed: true,
      barrierDismissible: false,
    );
    if (result == true && context.mounted) {
      context.pop();
      deletePost();
    }
  }
}
