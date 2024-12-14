import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/profile_picture.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/models/display_user_model.dart';

/*
This stacks 3 images on top side by side
@author: Ugochukwu Umeh
*/
class ImageStackWidget extends StatelessWidget {
  /// List of images
  final List<DisplayUser> fUsers;

  /// Size of the image
  final double fSize;

  const ImageStackWidget({
    super.key,
    required this.fUsers,
    required this.fSize,
  });

  @override
  Widget build(BuildContext context) {
    if (fUsers.isEmpty) {
      return const SizedBox();
    }
    int fUserCount = 0;
    //The first image cannot be null if the list is not empty
    final DisplayUser fUser1 = fUsers.first;
    fUserCount++;

    //The second user
    DisplayUser? fUser2;
    //If the length of the list is more than 2 then fUser2 can be set
    if (fUsers.length >= 2) {
      fUser2 = fUsers.elementAt(1);
      fUserCount++;
    }

    //The third user
    DisplayUser? fUser3;
    //If the length of the list is more than 3 then fUser3 can be set
    if (fUsers.length >= 3) {
      fUser3 = fUsers.elementAt(2);
      fUserCount++;
    }

    return SizedBox(
      width: ((fSize * 2) * fUserCount + 1),
      child: Stack(
        children: [
          _MutualImageContainer(
            fUser: fUser1,
            fSize: fSize,
          ),
          if (fUser2 != null)
            Positioned(
              left: (fSize * 1.9),
              child: _MutualImageContainer(
                fUser: fUser2,
                fSize: fSize,
              ),
            ),
          if (fUser3 != null)
            Positioned(
              left: (fSize * 3.8),
              child: _MutualImageContainer(
                fUser: fUser3,
                fSize: fSize,
              ),
            ),
        ],
      ),
    );
  }
}

/*
This creates a border around the images
@author: Ugochukwu Umeh
*/
class _MutualImageContainer extends StatelessWidget {
  /// The image
  final DisplayUser fUser;

  /// Image size
  final double fSize;

  const _MutualImageContainer({
    required this.fUser,
    required this.fSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colors.secondary,
          width: 2,
        ),
        shape: BoxShape.circle,
      ),
      child: ProfilePicture(
        fRadius: fSize,
        fUserName: fUser.username.checkNullDash,
        fProfilePicture: fUser.displayImage,
        fToProfile: false,
      ),
    );
  }
}
