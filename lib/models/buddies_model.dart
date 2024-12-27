/// Represents a buddy user in the system with their profile and interaction data.
/// @author: Chidera Chijama
class BuddiesModel {
  /// Distance from the current user in miles
  final int distance;

  /// Number of interests shared with the current user
  final int similarInterestsCount;

  /// Number of mutual connections between users
  final int mutualBuddiesCount;

  /// Username of the buddy
  final String userName;

  /// List of user's interests
  final List<String> interests;

  /// URLs of profile images
  final List<String> profileImages;

  /// User's biographical information
  final String bio;

  /// Number of users following this buddy
  final int followersCount;

  /// Number of users this buddy follows
  final int followingCount;

  /// Total number of buddy connections
  final int buddiesCount;

  /// Number of activities created by this buddy
  final int activityCreatedCount;

  /// Number of activities this buddy has joined
  final int activityJoinedCount;

  /// List of activity identifiers
  final List<String> activities;

  /// List of post identifiers
  final List<String> posts;

  /// Type of connection with the current user
  final String connectionType;

  /// List of stories
  final List<String> stories;

  /// Followers list (other buddies)
  final List<BuddiesModel>? followersList;

  /// Following list (other buddies)
  final List<BuddiesModel>? followingList;

  /// Buddies list (other buddies)
  final List<BuddiesModel>? buddiesList;

  /// Reviews of this buddy
  final Reviews reviews;

  /// Creates a new BuddiesModel instance with default values
  const BuddiesModel({
    this.followersList,
    this.followingList,
    this.buddiesList,
    this.distance = 3,
    this.similarInterestsCount = 15,
    this.mutualBuddiesCount = 12,
    this.userName = 'Jordyn Vaccaro',
    this.interests = const [
      "Art",
      "Hockey",
      "Sport",
      "Baseball",
      "Rugby",
      "Visual Arts",
      "Ice Hockey",
      "Softball",
      "Softball"
    ],
    this.profileImages = const [
      "https://cdn.businessday.ng/2022/04/Abiru-1.png",
      "https://pbs.twimg.com/profile_images/1495721772523692034/GnC5MJjS_400x400.jpg",
      "https://pbs.twimg.com/profile_images/1530445927739162625/xtGDZZIm_400x400.jpg",
    ],
    this.bio =
        "Professional daydreamer, coffee enthusiast, and expert in pressing ‘Next Episode.’ Living life one witty remark at a time",
    this.followersCount = 4200,
    this.followingCount = 1200000,
    this.buddiesCount = 3200000,
    this.activityCreatedCount = 300,
    this.activityJoinedCount = 1200,
    this.activities = const [
      "https://elections.civichive.org/wp-content/uploads/2022/12/Abiola-Latifu-Kolawole-PRP.jpg",
      "https://pbs.twimg.com/profile_images/1510691230555987973/agTnpSpG_400x400.jpg",
      "https://dailytrust.com/wp-content/uploads/2022/11/Prince-Adewole-Adebayo-1.jpg",
    ],
    this.posts = const [
      "https://elections.civichive.org/wp-content/uploads/2022/12/Abiola-Latifu-Kolawole-PRP.jpg",
      "https://pbs.twimg.com/profile_images/1510691230555987973/agTnpSpG_400x400.jpg",
      "https://dailytrust.com/wp-content/uploads/2022/11/Prince-Adewole-Adebayo-1.jpg",
    ],
    this.connectionType = "followingUser",
    this.stories = const [
      "https://example.com/story1.jpg",
      "https://example.com/story2.jpg",
      "https://example.com/story3.jpg",
    ],
    this.reviews = const Reviews(),
  });

  /// Creates a copy of this BuddiesModel with the given fields replaced with new values
  BuddiesModel copyWith({
    int? distance,
    int? similarInterestsCount,
    int? mutualBuddiesCount,
    String? userName,
    List<String>? interests,
    List<String>? profileImages,
    String? bio,
    int? followersCount,
    int? followingCount,
    int? buddiesCount,
    int? activityCreatedCount,
    int? activityJoinedCount,
    int? reviewCount,
    double? reviewStars,
    List<String>? activities,
    List<String>? posts,
    String? connectionType,
    List<String>? stories,
    List<BuddiesModel>? followersList,
    List<BuddiesModel>? followingList,
    List<BuddiesModel>? buddiesList,
    Reviews? reviews,
  }) {
    return BuddiesModel(
      distance: distance ?? this.distance,
      similarInterestsCount:
          similarInterestsCount ?? this.similarInterestsCount,
      mutualBuddiesCount: mutualBuddiesCount ?? this.mutualBuddiesCount,
      userName: userName ?? this.userName,
      interests: interests ?? this.interests,
      profileImages: profileImages ?? this.profileImages,
      bio: bio ?? this.bio,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      buddiesCount: buddiesCount ?? this.buddiesCount,
      activityCreatedCount: activityCreatedCount ?? this.activityCreatedCount,
      activityJoinedCount: activityJoinedCount ?? this.activityJoinedCount,
      activities: activities ?? this.activities,
      posts: posts ?? this.posts,
      connectionType: connectionType ?? this.connectionType,
      stories: stories ?? this.stories,
      followersList: followersList ?? this.followersList,
      followingList: followingList ?? this.followingList,
      buddiesList: buddiesList ?? this.buddiesList,
      reviews: reviews ?? this.reviews,
    );
  }
}

/// Represents the reviews section of a buddy
class Reviews {
  /// The total number of reviews
  final int count;

  /// The total rating value
  final double totalRating;

  /// List of individual reviews
  final List<Review> reviewList;

  const Reviews({
    this.count = 300,
    this.totalRating = 4.5,
    this.reviewList = const [],
  });
}

/// Represents a single review
class Review {
  /// The reviewer, represented as a BuddiesModel
  final BuddiesModel reviewer;

  /// The review rating (1-5)
  final int rating;

  /// The actual review text
  final String review;

  /// The time of the review
  final DateTime timeOfReview;

  const Review({
    required this.reviewer,
    required this.rating,
    required this.review,
    required this.timeOfReview,
  });
}
