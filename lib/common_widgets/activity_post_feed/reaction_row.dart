import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/*
This displays the popular reactions and total number of reactions
@author: Ugochukwu Umeh
*/
class ReactionsRow extends StatelessWidget {
  ///The reaction of the post
  final List<ReactionIconTypeEnum> fPostReaction;

  ///When the reactions is tapped
  final VoidCallback fOnReactionsTapped;

  ///This displays the popular reactions and the total number of reaction
  const ReactionsRow({
    super.key,
    required this.fPostReaction,
    required this.fOnReactionsTapped,
  });

  @override
  Widget build(BuildContext context) {
    /// Gets the total number of reactions
    final int fTotalReaction = fPostReaction.length;

    /// Ranks the post reaction in order of number of reactions
    final Map<ReactionIconTypeEnum, int> fRankedMap =
        fPostReaction.rankReaction();

    /// Gets the popular reaction ids for generating icons
    final List<MapEntry<ReactionIconTypeEnum, int>> fPopularReaction =
        fRankedMap.entries.take(3).toList();

    return Visibility(
      visible: fTotalReaction > 0,
      child: Semantics(
        label: context.loc.nReactions(fTotalReaction),
        child: GestureDetector(
          onTap: fOnReactionsTapped,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 4,
            children: [
              //Reaction Icons
              ...fPopularReaction.map<Widget>(
                (reaction) {
                  final String reactionIcon = reaction.key.getReactionIcon();
                  return Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: SvgPicture.asset(
                      reactionIcon,
                      height: 15,
                      width: 15,
                    ),
                  );
                },
              ),

              ExcludeSemantics(
                child: Text(
                  fTotalReaction.formatNumToCompact(),
                  style: context.textTheme.labelLarge?.copyWith(
                    color: context.colors.tertiary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
