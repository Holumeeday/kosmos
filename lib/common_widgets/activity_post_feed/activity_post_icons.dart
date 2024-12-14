import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/*
This displays the icons in activity or status
@author: Ugochukwu Umeh
*/
class ActivityPostIcons extends StatelessWidget {
  ///When the share icon is tapped
  final VoidCallback fOnShareTap;

  ///When the bookmark icon is tapped
  final VoidCallback fOnBookmarkTap;

  ///Determines if the post is bookmarked or not
  final bool fIsBookmarked;

  ///When the bookmark icon is tapped
  final VoidCallback fOnMoreTap;

  ///The distance
  final num? fDistance;

  const ActivityPostIcons({
    super.key,
    required this.fOnShareTap,
    required this.fOnBookmarkTap,
    required this.fIsBookmarked,
    required this.fOnMoreTap,
    this.fDistance,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Share, bookmark and more details icon
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Share
            Flexible(
              child: Semantics(
                button: true,
                label: context.loc.share,
                child: _ActivityStatusIcon(
                  fIconColor: context.appColors.darkGreyColor,
                  fOnTap: fOnShareTap,
                  fIcon: Icons.share_outlined,
                ),
              ),
            ),
            // Bookmark
            Flexible(
              child: Semantics(
                button: true,
                label: context.loc.postBookmarked(
                    fIsBookmarked ? 'bookMarked' : 'notBookmarked'),
                child: _ActivityStatusIcon(
                  fIconColor: fIsBookmarked
                      ? context.colors.secondary
                      : context.appColors.darkGreyColor,
                  fOnTap: () {
                    String dBookmarkMessage;
                    fOnBookmarkTap();
                    if (fIsBookmarked) {
                      dBookmarkMessage = context.loc.postRemovedFromBookmark;
                    } else {
                      dBookmarkMessage = context.loc.postBookmarkedString;
                    }
                    SemanticsService.announce(
                      dBookmarkMessage,
                      Directionality.of(context),
                    );
                  },
                  fIcon: fIsBookmarked
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_outlined,
                ),
              ),
            ),
            // More options
            Flexible(
              child: Semantics(
                button: true,
                label: context.loc.moreOptions,
                child: _ActivityStatusIcon(
                  fIconColor: context.appColors.darkGreyColor,
                  fOnTap: fOnMoreTap,
                  fIcon: Icons.more_vert,
                  fRightPadding: 0,
                ),
              ),
            ),
          ],
        ),

        // The distance icon
        if (fDistance != null)
          Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.colors.secondary.withOpacity(0.1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Icon(
                  Icons.location_on_rounded,
                  color: context.colors.secondary,
                  size: 16,
                ),
                const HSpace(4),

                // Distance
                Flexible(
                  child: Text(
                    context.loc.milesAwayDistance(fDistance!),
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colors.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/*
This displays the icon used in activity or status
@author: Ugochukwu Umeh
*/
class _ActivityStatusIcon extends StatelessWidget {
  ///When the icon is tapped
  final VoidCallback fOnTap;

  ///The icon itself
  final IconData fIcon;

  ///Right padding
  final double fRightPadding;

  ///The color of the icon
  final Color? fIconColor;

  const _ActivityStatusIcon({
    required this.fIconColor,
    required this.fOnTap,
    required this.fIcon,
    this.fRightPadding = 8,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryIconButton(
      fOnTap: fOnTap,
      fIcon: Icon(
        fIcon,
        color: fIconColor,
        size: 24,
      ),
    );
  }
}
