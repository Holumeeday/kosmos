/* BuddiesModel
 Represents the Buddies data structure.
 @author: Chidera Chijama
 */

class BuddiesModel {
  final int? distance; // Distance in miles
  final int? similarInterestsCount; // Count of similar interests
  final int? mutualBuddiesCount; // Count of mutual buddies
  final String? userName; // Name of the buddy
  final List<String>? interests; // List of interests
  final List<String>? profileImages; // List of profile images
  final String? bio; // User bio
  final int? followersCount; // Count of followers
  final int? followingCount; // Count of following
  final int? buddiesCount; // Count of buddies
  final int? activityCreatedCount; // Count of activities created
  final int? activityJoinedCount; // Count of activities joined
  final int? reviewCount; // Count of reviews
  final double? reviewStars; // Review rating in stars
  final List<String>? activities; // List of user activities
  final List<String>? posts; // List of user posts

  const BuddiesModel({
    this.distance,
    this.similarInterestsCount,
    this.mutualBuddiesCount,
    this.userName,
    this.interests,
    this.profileImages,
    this.bio,
    this.followersCount,
    this.followingCount,
    this.buddiesCount,
    this.activityCreatedCount,
    this.activityJoinedCount,
    this.reviewCount,
    this.reviewStars,
    this.activities,
    this.posts,
  });

  /// Factory method to create a BuddiesModel from JSON data
  factory BuddiesModel.fromJson(Map<String, dynamic> json) {
    return BuddiesModel(
      distance: json['distance'] ?? 0,
      similarInterestsCount: json['similarInterests'] ?? 0,
      mutualBuddiesCount: json['mutualBuddies'] ?? 0,
      userName: json['userName'] ?? "Unknown",
      bio: json['bio'] ?? "",
      interests: List<String>.from(json['interests'] ?? []),
      profileImages: List<String>.from(json['profileImages'] ?? []),
      followersCount: json['followersCount'] ?? 0,
      followingCount: json['followingCount'] ?? 0,
      buddiesCount: json['buddiesCount'] ?? 0,
      activityCreatedCount: json['activityCreatedCount'] ?? 0,
      activityJoinedCount: json['activityJoinedCount'] ?? 0,
      reviewCount: json['reviewCount'] ?? 0,
      reviewStars: json['reviewStars'] ?? 0,
      activities: List<String>.from(json['activities'] ?? []),
      posts: List<String>.from(json['posts'] ?? []),
    );
  }

  /// CopyWith method for partial updates
  BuddiesModel copyWith({
    int? distance,
    int? similarInterestsCount,
    int? mutualBuddiesCount,
    String? userName,
    String? bio,
    List<String>? interests,
    List<String>? profileImages,
    int? followersCount,
    int? followingCount,
    int? buddiesCount,
    int? activityCreatedCount,
    int? activityJoinedCount,
    int? reviewCount,
    double? reviewStars,
    List<String>? activities,
    List<String>? posts,
  }) {
    return BuddiesModel(
      distance: distance ?? this.distance,
      similarInterestsCount:
          similarInterestsCount ?? this.similarInterestsCount,
      mutualBuddiesCount: mutualBuddiesCount ?? this.mutualBuddiesCount,
      userName: userName ?? this.userName,
      bio: bio ?? this.bio,
      interests: interests ?? this.interests,
      profileImages: profileImages ?? this.profileImages,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      buddiesCount: buddiesCount ?? this.buddiesCount,
      activityCreatedCount: activityCreatedCount ?? this.activityCreatedCount,
      activityJoinedCount: activityJoinedCount ?? this.activityJoinedCount,
      reviewCount: reviewCount ?? this.reviewCount,
      reviewStars: reviewStars ?? this.reviewStars,
      activities: activities ?? this.activities,
      posts: posts ?? this.posts,
    );
  }
}
