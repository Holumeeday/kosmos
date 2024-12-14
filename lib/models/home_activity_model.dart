import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/models/display_user_model.dart';
import 'package:playkosmos_v3/models/flyer_positioning_model.dart';

class ActivityListModel extends Equatable {
  ///The post text
  final String? activityPost;

  ///The distance
  final num distance;

  ///The profile info
  final ActivityUserProfile activityUserProfile;

  ///If its the user activity
  final bool activityIsUser;

  ///The flyer properties
  final ActivityFlyerProperties activityFlyerProperties;

  ///The tagged people
  final List<String> activityTag;

  ///The images
  final List<String> activityAddedImages;

  ///The participants
  final int activityParticipantsCount;

  ///The participants
  final int? activityMaxParticipant;

  ///The playmates attending
  final List<DisplayUser> playmatesAttending;

  ///If the activity is bookmarked
  final bool activityBookmarked;

  ///If this a shared activity post
  final bool isActivityShared;

  ///The profile info of the person that shared the activity
  final ActivityUserProfile? sharedActivityUserProfile;

  ///The people tagged to the activity
  final List<String>? sharedActivityTag;

  ///The post text for the shared activity
  final String? sharedActivityPost;

  ///The positioning of properties
  final FlyerPositioning activityPropertiesPosition;

  ///The reaction of the user
  final ReactionIconTypeEnum? userReaction;

  ///The list of reactions to the activity
  final List<ReactionIconTypeEnum> activityReactionList;

  ///The number of times the post has been shared
  final int activityShareCount;

  ///The number of times the post has been commented on
  final int activityCommentsCount;

  ///The number of times the questions has been asked about this post
  final int activityQAndACount;

  ///The number of times the post has been reviewed
  final int activityReviewsCount;

  ///Time post was made
  final DateTime activityPostTime;

  ///Time post was shared
  final DateTime? sharedActivityPostTime;

  const ActivityListModel({
    required this.activityPost,
    required this.activityUserProfile,
    required this.activityIsUser,
    required this.isActivityShared,
    required this.activityFlyerProperties,
    required this.activityPropertiesPosition,
    required this.activityAddedImages,
    required this.activityParticipantsCount,
    required this.activityTag,
    required this.activityBookmarked,
    required this.activityReactionList,
    required this.userReaction,
    required this.activityShareCount,
    required this.playmatesAttending,
    required this.activityMaxParticipant,
    required this.activityCommentsCount,
    required this.activityQAndACount,
    required this.activityReviewsCount,
    required this.activityPostTime,
    required this.distance,
    this.sharedActivityPost,
    this.sharedActivityUserProfile,
    this.sharedActivityTag,
    this.sharedActivityPostTime,
  });

  ///A copy with function
  ActivityListModel copyWith({
    bool? activityBookmarked,
    List<ReactionIconTypeEnum>? activityReactionList,
    int? activityReactionCount,
    int? activityShareCount,
  }) {
    return ActivityListModel(
      activityPost: activityPost,
      activityUserProfile: activityUserProfile,
      activityIsUser: activityIsUser,
      activityFlyerProperties: activityFlyerProperties,
      activityPropertiesPosition: activityPropertiesPosition,
      activityAddedImages: activityAddedImages,
      activityParticipantsCount: activityParticipantsCount,
      activityTag: activityTag,
      activityBookmarked: activityBookmarked ?? this.activityBookmarked,
      activityReactionList: activityReactionList ?? this.activityReactionList,
      userReaction: userReaction,
      activityShareCount: activityShareCount ?? this.activityShareCount,
      activityMaxParticipant: activityMaxParticipant,
      playmatesAttending: playmatesAttending,
      activityCommentsCount: activityCommentsCount,
      activityQAndACount: activityQAndACount,
      activityReviewsCount: activityReviewsCount,
      activityPostTime: activityPostTime,
      isActivityShared: isActivityShared,
      sharedActivityPost: sharedActivityPost,
      sharedActivityUserProfile: sharedActivityUserProfile,
      sharedActivityTag: sharedActivityTag,
      sharedActivityPostTime: sharedActivityPostTime,
      distance: distance,
    );
  }

  ///A copy with function
  ActivityListModel copyOnlyUserReaction({
    ReactionIconTypeEnum? userReaction,
  }) {
    return ActivityListModel(
      activityPost: activityPost,
      activityUserProfile: activityUserProfile,
      activityIsUser: activityIsUser,
      activityFlyerProperties: activityFlyerProperties,
      activityPropertiesPosition: activityPropertiesPosition,
      activityAddedImages: activityAddedImages,
      activityParticipantsCount: activityParticipantsCount,
      activityTag: activityTag,
      activityBookmarked: activityBookmarked,
      activityReactionList: activityReactionList,
      userReaction: userReaction,
      activityShareCount: activityShareCount,
      activityMaxParticipant: activityMaxParticipant,
      playmatesAttending: playmatesAttending,
      activityCommentsCount: activityCommentsCount,
      activityQAndACount: activityQAndACount,
      activityReviewsCount: activityReviewsCount,
      activityPostTime: activityPostTime,
      isActivityShared: isActivityShared,
      sharedActivityPost: sharedActivityPost,
      sharedActivityUserProfile: sharedActivityUserProfile,
      sharedActivityTag: sharedActivityTag,
      sharedActivityPostTime: sharedActivityPostTime,
      distance: distance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'activityPost': activityPost,
      'distance': distance,
      'activityUserProfile': activityUserProfile.toMap(),
      'activityIsUser': activityIsUser,
      'activityFlyerProperties': activityFlyerProperties.toMap(),
      'activityTag': activityTag,
      'activityAddedImages': activityAddedImages,
      'activityParticipantsCount': activityParticipantsCount,
      'activityMaxParticipant': activityMaxParticipant,
      'playmatesAttending': playmatesAttending.map((x) => x.toMap()).toList(),
      'activityBookmarked': activityBookmarked,
      'isActivityShared': isActivityShared,
      'sharedActivityUserProfile': sharedActivityUserProfile?.toMap(),
      'sharedActivityTag': sharedActivityTag,
      'sharedActivityPost': sharedActivityPost,
      'activityPropertiesPosition': activityPropertiesPosition.interestName,
      'userReaction': userReaction?.name,
      'activityReactionList': activityReactionList.map((x) => x.name).toList(),
      'activityShareCount': activityShareCount,
      'activityCommentsCount': activityCommentsCount,
      'activityQAndACount': activityQAndACount,
      'activityReviewsCount': activityReviewsCount,
      'activityPostTime': activityPostTime.millisecondsSinceEpoch,
      'sharedActivityPostTime': sharedActivityPostTime?.millisecondsSinceEpoch,
    };
  }

  factory ActivityListModel.fromMap(Map<String, dynamic> map) {
    return ActivityListModel(
      activityPost:
          map['activityPost'] != null ? map['activityPost'] as String : null,
      distance: map['distance'] as num,
      activityUserProfile: ActivityUserProfile.fromMap(
          map['activityUserProfile'] as Map<String, dynamic>),
      activityIsUser: map['activityIsUser'] as bool,
      activityFlyerProperties: ActivityFlyerProperties.fromMap(
          map['activityFlyerProperties'] as Map<String, dynamic>),
      activityTag: List<String>.from((map['activityTag'] as List<String>)),
      activityAddedImages:
          List<String>.from((map['activityAddedImages'] as List<String>)),
      activityParticipantsCount: map['activityParticipantsCount'] as int,
      activityMaxParticipant: map['activityMaxParticipant'] != null
          ? map['activityMaxParticipant'] as int
          : null,
      playmatesAttending: List<DisplayUser>.from(
        (map['playmatesAttending'] as List<int>).map<DisplayUser>(
          (x) => DisplayUser.fromJson(x as Map<String, dynamic>),
        ),
      ),
      activityBookmarked: map['activityBookmarked'] as bool,
      isActivityShared: map['isActivityShared'] as bool,
      sharedActivityUserProfile: map['sharedActivityUserProfile'] != null
          ? ActivityUserProfile.fromMap(
              map['sharedActivityUserProfile'] as Map<String, dynamic>)
          : null,
      sharedActivityTag: map['sharedActivityTag'] != null
          ? List<String>.from(map['sharedActivityTag'] as List<String>)
          : null,
      sharedActivityPost: map['sharedActivityPost'] != null
          ? map['sharedActivityPost'] as String
          : null,
      activityPropertiesPosition: FlyerPositioning.fromMap(
          map['activityPropertiesPosition'] as Map<String, dynamic>),
      userReaction: map['userReaction'] != null
          ? ReactionIconTypeEnum.fromString(map['userReaction'] as String)
          : null,
      activityReactionList: List<ReactionIconTypeEnum>.from(
        (map['activityReactionList'] as List<int>).map<ReactionIconTypeEnum>(
          (x) => ReactionIconTypeEnum.fromString(x as String),
        ),
      ),
      activityShareCount: map['activityShareCount'] as int,
      activityCommentsCount: map['activityCommentsCount'] as int,
      activityQAndACount: map['activityQAndACount'] as int,
      activityReviewsCount: map['activityReviewsCount'] as int,
      activityPostTime:
          DateTime.fromMillisecondsSinceEpoch(map['activityPostTime'] as int),
      sharedActivityPostTime: map['sharedActivityPostTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['sharedActivityPostTime'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ActivityListModel.fromJson(String source) =>
      ActivityListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props {
    return [
      activityPost,
      distance,
      activityUserProfile,
      activityIsUser,
      activityFlyerProperties,
      activityTag,
      activityAddedImages,
      activityParticipantsCount,
      activityMaxParticipant,
      playmatesAttending,
      activityBookmarked,
      isActivityShared,
      sharedActivityUserProfile,
      sharedActivityTag,
      sharedActivityPost,
      activityPropertiesPosition,
      userReaction,
      activityReactionList,
      activityShareCount,
      activityCommentsCount,
      activityQAndACount,
      activityReviewsCount,
      activityPostTime,
      sharedActivityPostTime,
    ];
  }
}

class ActivityListTagModel {
  ///The tagged user name
  final String name;

  ///The profile picture of the tagged
  final String? profilePic;

  ///The interests of the tagged
  final List<String> interests;

  ///The participant subscribed plan
  final String? subscriptionPlan;

  ///Identity which may be playmate, venue, store or team
  final String identity;

  ///If the user is connected with the tagged
  final bool isConnected;

  const ActivityListTagModel({
    required this.name,
    required this.profilePic,
    required this.interests,
    required this.identity,
    required this.subscriptionPlan,
    required this.isConnected,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profilePic': profilePic,
      'interests': interests,
      'subscriptionPlan': subscriptionPlan,
      'identity': identity,
      'isConnected': isConnected,
    };
  }

  factory ActivityListTagModel.fromMap(Map<String, dynamic> map) {
    return ActivityListTagModel(
      name: map['name'] as String,
      profilePic:
          map['profilePic'] != null ? map['profilePic'] as String : null,
      interests: List<String>.from((map['interests'] as List<String>)),
      subscriptionPlan: map['subscriptionPlan'] != null
          ? map['subscriptionPlan'] as String
          : null,
      identity: map['identity'] as String,
      isConnected: map['isConnected'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ActivityListTagModel.fromJson(String source) =>
      ActivityListTagModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ActivityUserProfile {
  ///The name of the user
  final String profileName;

  ///The image of the user
  final String? profileImage;

  ///The subscription plan of the user
  final String profilePlan;

  ///This contains the name, picture and subscription plan of a playmate
  const ActivityUserProfile({
    required this.profileImage,
    required this.profileName,
    required this.profilePlan,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'profileName': profileName,
      'profileImage': profileImage,
      'profilePlan': profilePlan,
    };
  }

  factory ActivityUserProfile.fromMap(Map<String, dynamic> map) {
    return ActivityUserProfile(
      profileName: map['profileName'] as String,
      profileImage:
          map['profileImage'] != null ? map['profileImage'] as String : null,
      profilePlan: map['profilePlan'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ActivityUserProfile.fromJson(String source) =>
      ActivityUserProfile.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ActivityFlyerProperties {
  ///The activity title
  final String activityTitle;

  ///The activity details
  final String activityDetails;

  ///The activity type text
  final String activityType;

  ///The activity interest
  final String activityInterest;

  ///The city where the activity will take place
  final String activityCity;

  ///The country where the activity will take place
  final String activityCountry;

  ///The venue where the activity will take place
  final String activityVenue;

  ///The activity price
  final String activityPrice;

  ///The date
  final DateTime activityDate;

  ///The time
  final TimeOfDay activityTime;

  ///The duration
  final String activityDuration;

  ///The time zone
  final String activityTimeZone;

  ///The activity refund date
  final DateTime? activityRefundDate;

  ///The activity refund time
  final TimeOfDay? activityRefundTime;

  ///The image
  final String? activityImage;

  const ActivityFlyerProperties({
    required this.activityTitle,
    required this.activityDetails,
    required this.activityType,
    required this.activityInterest,
    required this.activityCity,
    required this.activityCountry,
    required this.activityVenue,
    required this.activityPrice,
    required this.activityDate,
    required this.activityTime,
    required this.activityDuration,
    required this.activityTimeZone,
    required this.activityRefundDate,
    required this.activityRefundTime,
    required this.activityImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'activityTitle': activityTitle,
      'activityDetails': activityDetails,
      'activityType': activityType,
      'activityInterest': activityInterest,
      'activityCity': activityCity,
      'activityCountry': activityCountry,
      'activityVenue': activityVenue,
      'activityPrice': activityPrice,
      'activityDate': activityDate.millisecondsSinceEpoch,
      'activityTime': activityTime.toString(),
      'activityDuration': activityDuration,
      'activityTimeZone': activityTimeZone,
      'activityRefundDate': activityRefundDate?.millisecondsSinceEpoch,
      'activityRefundTime': activityRefundTime?.toString(),
      'activityImage': activityImage,
    };
  }

  factory ActivityFlyerProperties.fromMap(Map<String, dynamic> map) {
    return ActivityFlyerProperties(
      activityTitle: map['activityTitle'] as String,
      activityDetails: map['activityDetails'] as String,
      activityType: map['activityType'] as String,
      activityInterest: map['activityInterest'] as String,
      activityCity: map['activityCity'] as String,
      activityCountry: map['activityCountry'] as String,
      activityVenue: map['activityVenue'] as String,
      activityPrice: map['activityPrice'] as String,
      activityDate:
          DateTime.fromMillisecondsSinceEpoch(map['activityDate'] as int),
      activityTime:
          TimeOfDay.fromDateTime(DateTime.parse(map['activityTime'] as String)),
      activityDuration: map['activityDuration'] as String,
      activityTimeZone: map['activityTimeZone'] as String,
      activityRefundDate: map['activityRefundDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['activityRefundDate'] as int)
          : null,
      activityRefundTime: map['activityRefundTime'] != null
          ? TimeOfDay.fromDateTime(
              DateTime.parse(map['activityRefundTime'] as String))
          : null,
      activityImage:
          map['activityImage'] != null ? map['activityImage'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ActivityFlyerProperties.fromJson(String source) =>
      ActivityFlyerProperties.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
