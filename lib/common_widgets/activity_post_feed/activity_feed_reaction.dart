import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/models/display_user_model.dart';

/*
This displays the activities in the home view
@author: Ugochukwu Umeh
*/
class ActivityFeedReaction extends StatefulWidget {
  /// The reaction of the post
  final List<ReactionIconTypeEnum> fPostReaction;

  /// The number of shares
  final int fSharesNumber;

  /// The user reaction
  final ReactionIconTypeEnum? fUserReaction;

  /// Playmates attending the activity
  final List<DisplayUser> fPlaymatesAttending;

  /// When the reactions is tapped
  final VoidCallback fOnReactionsTapped;

  /// When the user wants to react
  final ValueChanged<ReactionIconTypeEnum?> fToReact;

  /// When playmates is tapped
  final VoidCallback fOnPlaymatesAttendingTapped;

  const ActivityFeedReaction({
    super.key,
    required this.fPostReaction,
    required this.fSharesNumber,
    required this.fUserReaction,
    required this.fPlaymatesAttending,
    required this.fOnReactionsTapped,
    required this.fToReact,
    required this.fOnPlaymatesAttendingTapped,
  });

  @override
  State<ActivityFeedReaction> createState() => _ActivityFeedReactionState();
}

class _ActivityFeedReactionState extends State<ActivityFeedReaction> {
  /// To show the reactions emojis
  bool _dShowReactions = false;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  /// To update [_dShowReactions] value
  void _updateShowReactionState() {
    setState(() {
      _dShowReactions = !_dShowReactions;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// The remaining playmates attending
    final int fRemainingPlaymatesAttending =
        widget.fPlaymatesAttending.length - 3;

    /// Main widget
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeInCubic,
        transitionBuilder: (Widget child, Animation<double> animation) =>
            ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: _dShowReactions
            // Shows the reactions
            ? ReactionIcons(
                fToReact: widget.fToReact,
                fClose: _updateShowReactionState,
                fSelectedIcon: widget.fUserReaction,
              )
            // Shows reactions, shares, playmates attending
            : Row(
                children: [
                  // Popular Reaction and shares
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Only visible when there's a reaction
                        // Reaction icons and total reaction
                        ReactionsRow(
                          fPostReaction: widget.fPostReaction,
                          fOnReactionsTapped: widget.fOnReactionsTapped,
                        ),

                        // Only visible when shares more than 1 Shares
                        Visibility(
                          visible: widget.fSharesNumber > 0,
                          child: Semantics(
                            label: context.loc.nShares(widget.fSharesNumber),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text(
                                '${widget.fSharesNumber.formatNumToCompact()} ${context.loc.shares}',
                                style: context.textTheme.labelLarge?.copyWith(
                                  color: context.colors.tertiary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const HSpace(5),

                  // Reaction to the post
                  Expanded(
                    flex: 2,
                    child: ReactionButton(
                      fUserReaction: widget.fUserReaction,
                      fOnTap: _updateShowReactionState,
                    ),
                  ),
                  const HSpace(5),

                  // Playmates attending
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Playmates attending text
                        TextWithBackground(
                          fText: context.loc.playmatesAttending,
                          fBackgroundColor: context.colors.secondary,
                          fTextSize: 12,
                          fFontWeight: FontWeight.w500,
                          fPadding: const EdgeInsets.all(4),
                        ),
                        const VSpace(8),

                        // Playmates attending pictures
                        Semantics(
                          label: context.loc.viewAttendingPlaymates,
                          button: true,
                          excludeSemantics: true,
                          child: GestureDetector(
                            onTap: widget.fOnPlaymatesAttendingTapped,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Playmates attending image or 0 text
                                Flexible(
                                  flex: 3,
                                  child: ImageStackWidget(
                                    fUsers: widget.fPlaymatesAttending,
                                    fSize: 15,
                                  ),
                                ),

                                // Remaining playmates attending
                                Flexible(
                                  child: Visibility(
                                    visible: fRemainingPlaymatesAttending > 0,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        '+${fRemainingPlaymatesAttending.formatNumToCompact()}',
                                        style: context.textTheme.labelLarge,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
