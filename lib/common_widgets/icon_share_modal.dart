import 'package:flutter/material.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/*
The modal for sharing post
@author: Ugochukwu Umeh
*/
class IconShareModal extends StatelessWidget {
  ///To share to timeline
  final VoidCallback fShareToTimeline;

  ///To share to others
  final VoidCallback fOtherShare;

  const IconShareModal({
    super.key,
    required this.fOtherShare,
    required this.fShareToTimeline,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //Share heading
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Text(
              context.loc.share,
              style: context.textTheme.displayMedium?.copyWith(
                color: context.colors.secondary,
              ),
            ),
          ),
          const Divider(height: 40),
          //Timeline
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                fShareToTimeline();
              },
              child: Text(
                context.loc.shareToTimeline,
                style: context.textTheme.titleSmall,
              ),
            ),
          ),
          const Divider(height: 40),

          // Options
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                fOtherShare();
              },
              child: Text(
                context.loc.moreOptions,
                style: context.textTheme.titleSmall,
              ),
            ),
          ),
          const Divider(height: 40),
        ],
      ),
    );
  }
}
