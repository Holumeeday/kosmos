import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/models/display_user_model.dart';
import 'package:playkosmos_v3/models/feed_post_owner_model.dart';
import 'package:playkosmos_v3/models/flyer_details_model.dart';
import 'package:playkosmos_v3/models/flyer_model.dart';

/// This model defines the items in the activity tab in the home tab
class FeedActivitiesModel {
  final List<FeedActivityModel> activities;

  const FeedActivitiesModel({
    this.activities = const [],
  });

  factory FeedActivitiesModel.fromJson(Map<String, dynamic> json) {
    return FeedActivitiesModel(
      activities: (json['activities'] as List?)
              ?.map<FeedActivityModel>(
                (x) => FeedActivityModel.fromJson(x as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  FeedActivitiesModel copyWith({
    List<FeedActivityModel>? activities,
  }) {
    return FeedActivitiesModel(
      activities: activities ?? this.activities,
    );
  }
}

class FeedActivityModel {
  final String? sharingPostId, originalPostId;
  final FeedPostOwnerModel sharingPostUser, originalPostUser;
  final bool isBookmarked;
  final double postDistance;
  final FlyerModel flyer;
  final FlyerDetailsModel flyerDetails;
  final List<String> postMedia;
  final List<DisplayUser> playmatesAttending;
  final int postShares, postComments, postQnA, postParticipants, postReviews;
  final int? maxParticipants;
  final List<ReactionIconTypeEnum> postReactions;
  final ReactionIconTypeEnum? reaction;

  String? get id =>
      (sharingPostId?.isNotEmpty ?? false) ? sharingPostId : originalPostId;
  String? get ownerId => (sharingPostId?.isNotEmpty ?? false)
      ? sharingPostUser.id
      : originalPostUser.id;

  const FeedActivityModel({
    this.sharingPostId,
    this.originalPostId,
    this.reaction,
    this.sharingPostUser = const FeedPostOwnerModel(),
    this.originalPostUser = const FeedPostOwnerModel(),
    this.isBookmarked = false,
    this.postDistance = 0,
    this.flyer = const FlyerModel(),
    this.flyerDetails = const FlyerDetailsModel(),
    this.postMedia = const [],
    this.postReactions = const [],
    this.playmatesAttending = const [],
    this.postShares = 0,
    this.postComments = 0,
    this.postQnA = 0,
    this.postParticipants = 0,
    this.postReviews = 0,
    this.maxParticipants,
  });

  factory FeedActivityModel.fromJson(Map<String, dynamic> json) {
    return FeedActivityModel(
      sharingPostId: json['sharingPostId'] as String?,
      originalPostId: json['originalPostId'] as String?,
      reaction: json['reaction'] == null
          ? null
          : ReactionIconTypeEnum.fromString(json['reaction']),
      sharingPostUser: json['sharingPostUser'] == null
          ? const FeedPostOwnerModel()
          : FeedPostOwnerModel.fromJson(json['sharingPostUser']),
      originalPostUser: json['originalPostUser'] == null
          ? const FeedPostOwnerModel()
          : FeedPostOwnerModel.fromJson(json['originalPostUser']),
      isBookmarked: json['isBookmarked'] as bool? ?? false,
      postDistance: json['postDistance'].toDouble() ?? 0,
      flyer: json['flyer'] == null
          ? const FlyerModel()
          : FlyerModel.fromJson(json['flyer']),
      flyerDetails: json['flyerDetails'] == null
          ? const FlyerDetailsModel()
          : FlyerDetailsModel.fromJson(json['flyerDetails']),
      postMedia:
          (json['postMedia'] as List?)?.map((e) => e as String).toList() ?? [],
      postReactions: (json['postReactions'] as List?)
              ?.map((e) => ReactionIconTypeEnum.fromString(e))
              .toList() ??
          [],
      playmatesAttending: (json['playmatesAttending'] as List?)
              ?.map((e) => DisplayUser.fromJson(e))
              .toList() ??
          [],
      postShares: json['postShares'].toInt() ?? 0,
      postComments: json['postComments'].toInt() ?? 0,
      postQnA: json['postQnA'].toInt() ?? 0,
      postParticipants: json['postParticipants'].toInt() ?? 0,
      postReviews: json['postReviews'].toInt() ?? 0,
      maxParticipants: json['maxParticipants'],
    );
  }

  FeedActivityModel copyWith({
    bool? isBookmarked,
  }) {
    return FeedActivityModel(
      sharingPostId: sharingPostId,
      originalPostId: originalPostId,
      reaction: reaction,
      sharingPostUser: sharingPostUser,
      originalPostUser: originalPostUser,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      postDistance: postDistance,
      flyer: flyer,
      flyerDetails: flyerDetails,
      postMedia: postMedia,
      postReactions: postReactions,
      playmatesAttending: playmatesAttending,
      postShares: postShares,
      postComments: postComments,
      postQnA: postQnA,
      postParticipants: postParticipants,
      postReviews: postReviews,
    );
  }

  FeedActivityModel updateReaction({
    ReactionIconTypeEnum? reaction,
    List<ReactionIconTypeEnum>? postReactions,
  }) {
    return FeedActivityModel(
      sharingPostId: sharingPostId,
      originalPostId: originalPostId,
      reaction: reaction,
      sharingPostUser: sharingPostUser,
      originalPostUser: originalPostUser,
      isBookmarked: isBookmarked,
      postDistance: postDistance,
      flyer: flyer,
      flyerDetails: flyerDetails,
      postMedia: postMedia,
      postReactions: postReactions ?? this.postReactions,
      playmatesAttending: playmatesAttending,
      postShares: postShares,
      postComments: postComments,
      postQnA: postQnA,
      postParticipants: postParticipants,
      postReviews: postReviews,
    );
  }
}
