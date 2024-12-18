import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/*
This class defines the profile picture
@author: Ugochukwu Umeh
*/
class ProfilePicture extends StatelessWidget {
  ///The profile picture which may be null
  final String? fProfilePicture;

  ///The username
  final String fUserName;

  /// The radius. Do not scale as its already scaled here, rather use the
  /// unscaled value
  final double fRadius;

  ///To move to profile
  final bool fToProfile;

  /// Excluding semantics for the profile picture
  final bool fExcludeSemantics;

  /// The id
  final String? fId;

  /// The identity
  final ParticipantTypeEnum? fParticipantType;

  ///For [fRadius] do not scale the value as its already scaled
  const ProfilePicture({
    super.key,
    required this.fRadius,
    required this.fProfilePicture,
    required this.fUserName,
    this.fToProfile = true,
    this.fExcludeSemantics = false,
    this.fId,
    this.fParticipantType,
  });

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      excluding: fExcludeSemantics,
      child: Semantics(
        label: context.loc.userNameProfilePicture(fUserName),
        button: fToProfile ? true : null,
        child: _Item(
          fRadius: fRadius,
          fProfilePicture: fProfilePicture,
          fUserName: fUserName,
          fToProfile: fToProfile,
          fId: fId,
          fParticipantType: fParticipantType,
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String? fProfilePicture;
  final String fUserName;
  final double fRadius;
  final bool fToProfile;
  final String? fId;
  final ParticipantTypeEnum? fParticipantType;

  const _Item({
    required this.fRadius,
    required this.fProfilePicture,
    required this.fUserName,
    required this.fToProfile,
    required this.fId,
    required this.fParticipantType,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: (fProfilePicture == null)
          // if the profile picture is null then use the first letter of the
          // username and if the user name is empty then show the person icon
          ? _UsernameTextIcon(fUsername: fUserName, fRadius: fRadius)
          : CachedNetworkImage(
              imageUrl: fProfilePicture!,
              imageBuilder: (_, image) => CircleAvatar(
                radius: fRadius,
                foregroundImage: image,
              ),
              placeholder: (_, __) => _PersonIcon(fRadius: fRadius),
              errorWidget: (_, __, ___) =>
                  _UsernameTextIcon(fUsername: fUserName, fRadius: fRadius),
            ),
    );
  }
}

/*
This class defines the text used if there's no picture or there's an error
@author: Ugochukwu Umeh
*/
class _UsernameTextIcon extends StatelessWidget {
  final String fUsername;
  final double fRadius;

  const _UsernameTextIcon({
    required this.fUsername,
    required this.fRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (fUsername.isEmpty) {
      return _PersonIcon(fRadius: fRadius);
    }
    return CircleAvatar(
      radius: fRadius,
      backgroundColor: context.colors.secondary.withOpacity(0.15),
      child: Center(
        child: Text(
          fUsername.substring(0, 1),
          textScaler: TextScaler.noScaling,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: context.colors.secondary,
          ),
        ),
      ),
    );
  }
}

/*
This class defines the icon used as placeholder or error for the profile
picture
@author: Ugochukwu Umeh
*/
class _PersonIcon extends StatelessWidget {
  final double fRadius;

  const _PersonIcon({required this.fRadius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: fRadius,
      backgroundColor: context.colors.secondary,
      child: Icon(
        Icons.person_rounded,
        size: fRadius,
        color: context.colors.onSecondary,
      ),
    );
  }
}
