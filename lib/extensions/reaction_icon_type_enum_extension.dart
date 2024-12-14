import 'package:playkosmos_v3/assets_gen/assets.gen.dart';
import 'package:playkosmos_v3/enums/enums.dart';

/// Extension for the reaction icons
extension ReactionIconExtension on ReactionIconTypeEnum {
  ///Gets the reaction icon from the reaction id of the post
  String getReactionIcon() {
    switch (this) {
      case ReactionIconTypeEnum.like:
        return Assets.svgs.postReactionIcons.likeReaction.path;
      case ReactionIconTypeEnum.clap:
        return Assets.svgs.postReactionIcons.clapReaction.path;
      case ReactionIconTypeEnum.heart:
        return Assets.svgs.postReactionIcons.heartReaction.path;
      case ReactionIconTypeEnum.party:
        return Assets.svgs.postReactionIcons.partyReaction.path;
      case ReactionIconTypeEnum.dislike:
        return Assets.svgs.postReactionIcons.dislikeReaction.path;
      case ReactionIconTypeEnum.sad:
        return Assets.svgs.postReactionIcons.sadReaction.path;
      case ReactionIconTypeEnum.angry:
        return Assets.svgs.postReactionIcons.angryReaction.path;
      case ReactionIconTypeEnum.cry:
        return Assets.svgs.postReactionIcons.cryReaction.path;
      case ReactionIconTypeEnum.shock:
        return Assets.svgs.postReactionIcons.shockReaction.path;
      case ReactionIconTypeEnum.laugh:
        return Assets.svgs.postReactionIcons.laughReaction.path;
    }
  }
}
