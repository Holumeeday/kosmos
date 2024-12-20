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

  /// Number of reviews received
  final int reviewCount;

  /// Average rating from reviews (0-5 stars)
  final double reviewStars;

  /// List of activity identifiers
  final List<String> activities;

  /// List of post identifiers
  final List<String> posts;

  /// Type of connection with the current user
  final String connectionType;

  /// Creates a new BuddiesModel instance with default values
  const BuddiesModel({
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
    this.reviewCount = 300,
    this.reviewStars = 4.5,
    this.activities = const [
      "https://elections.civichive.org/wp-content/uploads/2022/12/Abiola-Latifu-Kolawole-PRP.jpg",
      "https://pbs.twimg.com/profile_images/1510691230555987973/agTnpSpG_400x400.jpg",
      "https://dailytrust.com/wp-content/uploads/2022/11/Prince-Adewole-Adebayo-1.jpg",
      "https://elections.civichive.org/wp-content/uploads/2022/12/Adenuga-Sunday-Oluwafemi-BP.jpg",
      "https://elections.civichive.org/wp-content/uploads/2022/12/Ado-Ibrahim-Abdulmalik-YPP.jpg",
      "https://upload.wikimedia.org/wikipedia/commons/7/7c/Hamza_al-Mustapha_2023.jpg",
      "https://cdn.businessday.ng/2022/04/Abiru-1.png",
      "https://pbs.twimg.com/profile_images/1495721772523692034/GnC5MJjS_400x400.jpg",
      "https://pbs.twimg.com/profile_images/1530445927739162625/xtGDZZIm_400x400.jpg",
      "https://stears-elections.s3.eu-west-1.amazonaws.com/static/candidate-photos/president/APP-Charles-Nnadi.png"
    ],
    this.posts = const [
      "https://elections.civichive.org/wp-content/uploads/2022/12/Abiola-Latifu-Kolawole-PRP.jpg",
      "https://pbs.twimg.com/profile_images/1510691230555987973/agTnpSpG_400x400.jpg",
      "https://dailytrust.com/wp-content/uploads/2022/11/Prince-Adewole-Adebayo-1.jpg",
      "https://elections.civichive.org/wp-content/uploads/2022/12/Adenuga-Sunday-Oluwafemi-BP.jpg",
      "https://elections.civichive.org/wp-content/uploads/2022/12/Ado-Ibrahim-Abdulmalik-YPP.jpg",
      "https://upload.wikimedia.org/wikipedia/commons/7/7c/Hamza_al-Mustapha_2023.jpg",
      "https://cdn.businessday.ng/2022/04/Abiru-1.png",
      "https://pbs.twimg.com/profile_images/1495721772523692034/GnC5MJjS_400x400.jpg",
      "https://pbs.twimg.com/profile_images/1530445927739162625/xtGDZZIm_400x400.jpg",
      "https://stears-elections.s3.eu-west-1.amazonaws.com/static/candidate-photos/president/APP-Charles-Nnadi.png"
    ],
    this.connectionType = "followingYou",
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
      reviewCount: reviewCount ?? this.reviewCount,
      reviewStars: reviewStars ?? this.reviewStars,
      activities: activities ?? this.activities,
      posts: posts ?? this.posts,
      connectionType: connectionType ?? this.connectionType,
    );
  }
}
