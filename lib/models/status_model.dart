import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/models/home_activity_model.dart';

class StatusModel {
  ///The post text
  final String statusPost;

  ///The profile info
  final ActivityUserProfile activityUserProfile;

  ///If its the user activity
  final bool statusIsUser;

  ///The tagged people
  final List<String> statusTag;

  ///The images
  final List<String> statusAddedImages;

  ///If the activity is bookmarked
  final bool statusBookmarked;

  ///If this a shared status post
  final bool isStatusShared;

  ///The profile info of the person that shared the status
  final ActivityUserProfile? sharedActivityUserProfile;

  ///The people tagged to the status
  final List<String>? sharedStatusTag;

  ///The post text for the shared status
  final String? sharedStatusPost;

  ///Time post was shared
  final DateTime? sharedStatusPostTime;

  ///The reaction of the user
  final ReactionIconTypeEnum? userReaction;

  ///The list of reactions to the activity
  final List<ReactionIconTypeEnum> statusReactionList;

  ///The number of times the post has been shared
  final int statusShareCount;

  ///The number of times the post has been commented on
  final int statusCommentsCount;

  ///Time post was made
  final DateTime statusPostTime;

  const StatusModel({
    required this.statusPost,
    required this.activityUserProfile,
    required this.statusIsUser,
    required this.statusAddedImages,
    required this.statusTag,
    required this.statusBookmarked,
    required this.statusReactionList,
    required this.userReaction,
    required this.statusShareCount,
    required this.statusCommentsCount,
    required this.statusPostTime,
    required this.isStatusShared,
    this.sharedStatusPost,
    this.sharedActivityUserProfile,
    this.sharedStatusTag,
    this.sharedStatusPostTime,
  });

  ///A copy with function
  StatusModel updateBookmark(
    bool statusBookmarked,
  ) {
    return StatusModel(
      statusPost: statusPost,
      activityUserProfile: activityUserProfile,
      statusIsUser: statusIsUser,
      statusAddedImages: statusAddedImages,
      statusTag: statusTag,
      statusBookmarked: statusBookmarked,
      statusReactionList: statusReactionList,
      userReaction: userReaction,
      statusShareCount: statusShareCount,
      statusCommentsCount: statusCommentsCount,
      statusPostTime: statusPostTime,
      isStatusShared: isStatusShared,
      sharedStatusPost: sharedStatusPost,
      sharedActivityUserProfile: sharedActivityUserProfile,
      sharedStatusTag: sharedStatusTag,
      sharedStatusPostTime: sharedStatusPostTime,
    );
  }

  ///A copy with function
  StatusModel updateUserReaction({
    ReactionIconTypeEnum? userReaction,
  }) {
    return StatusModel(
      statusPost: statusPost,
      activityUserProfile: activityUserProfile,
      statusIsUser: statusIsUser,
      statusAddedImages: statusAddedImages,
      statusTag: statusTag,
      statusBookmarked: statusBookmarked,
      statusReactionList: statusReactionList,
      userReaction: userReaction,
      statusShareCount: statusShareCount,
      statusCommentsCount: statusCommentsCount,
      statusPostTime: statusPostTime,
      isStatusShared: isStatusShared,
      sharedStatusPost: sharedStatusPost,
      sharedActivityUserProfile: sharedActivityUserProfile,
      sharedStatusTag: sharedStatusTag,
      sharedStatusPostTime: sharedStatusPostTime,
    );
  }
}
