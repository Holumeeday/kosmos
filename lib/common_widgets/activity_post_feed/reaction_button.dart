import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playkosmos_v3/assets_gen/assets.gen.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/*
This displays aids in reacting to a post
@author: Ugochukwu Umeh
*/
class ReactionButton extends StatelessWidget {
  /// The user reaction
  final ReactionIconTypeEnum? fUserReaction;

  /// When its tapped
  final VoidCallback fOnTap;

  const ReactionButton({
    super.key,
    required this.fUserReaction,
    required this.fOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: context.loc.reaction(fUserReaction?.name ?? ''),
      button: true,
      child: GestureDetector(
        onTap: fOnTap,
        child: Container(
          height: 56,
          width: 56,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colors.secondary.withOpacity(0.12),
          ),
          child: SvgPicture.asset(
            fUserReaction == null
                ? Assets.svgs.postReactionIcons.defaultReaction.path
                : fUserReaction!.getReactionIcon(),
            height: 32,
            width: 32,
          ),
        ),
      ),
    );
  }
}
