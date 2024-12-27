import 'dart:math';

import 'package:playkosmos_v3/models/buddies_model.dart';

final Random random = Random();

/// List of possible connection types for buddies.
final List<String> connectionTypes = [
  "buddy",
  "followingUser",
  "userFollowing",
  "stranger",
];

/// Sample interests used for generating random buddy data.
final List<String> sampleInterests = [
  "Art",
  "Hockey",
  "Sport",
  "Baseball",
  "Rugby",
  "Visual Arts",
  "Ice Hockey",
  "Softball",
];

/// Sample bios used for generating random buddy data.
final List<String> sampleBios = [
  "Loves hiking and exploring new places.",
  "Avid reader and coffee enthusiast.",
  "Always up for a challenge.",
  "Music lover and aspiring guitarist.",
  "Professional daydreamer, living one witty remark at a time.",
];

/// Sample profile image URLs used for generating random buddy data.
final List<String> sampleImages = [
  "https://cdn.businessday.ng/2022/04/Abiru-1.png",
  "https://pbs.twimg.com/profile_images/1495721772523692034/GnC5MJjS_400x400.jpg",
  "https://pbs.twimg.com/profile_images/1530445927739162625/xtGDZZIm_400x400.jpg",
  "https://elections.civichive.org/wp-content/uploads/2022/12/Abiola-Latifu-Kolawole-PRP.jpg",
  "https://dailytrust.com/wp-content/uploads/2022/11/Prince-Adewole-Adebayo-1.jpg",
];

/// Sample stories URLs used for generating random buddy data.
final List<String> sampleStories = [
  "https://example.com/story1.jpg",
  "https://example.com/story2.jpg",
  "https://example.com/story3.jpg",
  "https://example.com/story4.jpg",
];

/// Sample reviews used for generating dummy data.
final List<String> sampleReviews = [
  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus vehicula nec nulla eu ultrices. Donec ac ultrices eros.",
  "This buddy is fantastic! Always up for an adventure and a great conversationalist. Highly recommended!",
  "I had an amazing time hanging out with this buddy. They are so friendly and fun to be around.",
  "One of the most genuine people I’ve met. Their advice and support have been invaluable. Would love to meet again!",
  "Not quite what I expected. While they were polite, the vibe just wasn’t there for me.",
  "Very organized and reliable! They made our trip a breeze and took care of all the small details. Definitely a 5-star experience.",
  "Great energy and enthusiasm, but could work on punctuality. Overall, still a good experience.",
  "We went hiking together, and it was incredible! This buddy knew all the best trails and hidden spots.",
  "A great listener and very empathetic. They gave me some great tips on personal development too!",
  "The buddy was okay, but I feel like the conversation didn’t flow as naturally as I had hoped.",
];

/// Generates a list of `BuddiesModel` with random data and dummy reviews.
List<BuddiesModel> generateBuddiesList(int totalBuddies) {
  return List.generate(totalBuddies, (index) {
    // Shuffle sample data for randomness.
    final shuffledInterests = [...sampleInterests]..shuffle(random);
    final shuffledImages = [...sampleImages]..shuffle(random);
    final shuffledStories = [...sampleStories]..shuffle(random);
    final shuffledBio = sampleBios[random.nextInt(sampleBios.length)];

    // Generate dummy reviews for the buddy.
    final List<Review> reviews = List.generate(random.nextInt(10) + 1, (reviewIndex) {
      final reviewer = BuddiesModel(
        userName: "Reviewer $reviewIndex",
        profileImages: shuffledImages.take(1).toList(),
        bio: "This is a reviewer’s bio",
      );
      return Review(
        reviewer: reviewer,
        rating: random.nextInt(5) + 1, // Random rating between 1 and 5.
        review: sampleReviews[random.nextInt(sampleReviews.length)]
            .substring(0, random.nextInt(20) + 50), // Varying review length.
        timeOfReview: DateTime.now().subtract(Duration(days: random.nextInt(365))),
      );
    });

    // Calculate the total rating and review count.
    final double totalRating =double.parse ((reviews.fold(0, (sum, review) => sum + review.rating) /reviews.length).toStringAsFixed(1));
    final int reviewCount = reviews.length;

    // Generate a random `BuddiesModel`.
    return BuddiesModel(
      distance: random.nextInt(100) + 1, // Random distance between 1-100 miles.
      similarInterestsCount: random.nextInt(20), // Random 0-20 similar interests.
      mutualBuddiesCount: random.nextInt(30), // Random 0-30 mutual buddies.
      userName: "Buddy $index", // Generate unique user names, e.g., "Buddy 0".
      interests: shuffledInterests.take(3).toList(), // Pick 3 random interests.
      profileImages: shuffledImages.take(3).toList(), // Pick 3 random images.
      bio: shuffledBio, // Pick a random bio.
      followersCount: random.nextInt(10000) + 1000, // Random 1000-11000 followers.
      followingCount: random.nextInt(10000) + 1000, // Random 1000-11000 following.
      buddiesCount: random.nextInt(5000) + 500, // Random 500-5500 buddies.
      activityCreatedCount: random.nextInt(50) + 1, // Random 1-50 activities created.
      activityJoinedCount: random.nextInt(100) + 10, // Random 10-110 activities joined.
      activities: shuffledImages.take(5).toList(), // Pick 5 random activities.
      posts: shuffledImages.take(5).toList(), // Pick 5 random posts.
      connectionType: connectionTypes[random.nextInt(connectionTypes.length)], // Random connection type.
      stories: shuffledStories.take(3).toList(), // Pick 3 random stories.
      reviews: Reviews(
        count: reviewCount,
        totalRating: totalRating,
        reviewList: reviews,
      ),
    );
  });
}

/// Creates a subset of the buddies list within the specified range.
///
/// This ensures safe sublist creation by clamping the range within valid bounds.
List<BuddiesModel> getFollowersList(
    List<BuddiesModel> buddies, int startIndex, int count) {
  final endIndex = (startIndex + count).clamp(0, buddies.length);
  return buddies.sublist(startIndex, endIndex);
}

// Generate the full list of buddies.
final List<BuddiesModel> fullBuddiesList = generateBuddiesList(500);

// Subset lists for specific purposes.
final List<BuddiesModel> followersList = getFollowersList(fullBuddiesList, 0, 50);
final List<BuddiesModel> followingList = getFollowersList(fullBuddiesList, 50, 100);
final List<BuddiesModel> buddiesList = getFollowersList(fullBuddiesList, 100, 150);
