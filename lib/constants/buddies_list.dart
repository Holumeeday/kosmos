import 'dart:math';

import 'package:playkosmos_v3/models/buddy_model.dart';

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
  'horseRiding',
  'dogAgilityTraining',
  'petPhotography',
  'birdWatching',
  'wildlifeSafaris',
  'aquariumVisits',
  'volunteeringAtShelters',
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

/// Generates a list of `BuddyModel` with random data and dummy reviews.
List<BuddyModel> generateBuddiesList(int totalBuddies) {
  return List.generate(totalBuddies, (index) {
    // Shuffle sample data for randomness.
    final shuffledInterests = [...sampleInterests]..shuffle(random);
    final shuffledImages = [...sampleImages]..shuffle(random);
    final shuffledStories = [...sampleStories]..shuffle(random);
    final shuffledBio = sampleBios[random.nextInt(sampleBios.length)];

    // Generate dummy reviewers as full buddies.
    final List<BuddyModel> reviewers = List.generate(
      random.nextInt(10) + 1, // Random number of reviewers between 1 and 10.
      (reviewIndex) => BuddyModel(
        userName: "Reviewer $reviewIndex",
        profileImages: shuffledImages.take(1).toList(),
        bio: sampleBios[random.nextInt(sampleBios.length)],
        distance: random.nextInt(100) + 1,
        similarInterestsCount: random.nextInt(10) + 1,
        mutualBuddiesCount: random.nextInt(5) + 1,
        interests: sampleInterests.take(3).toList(),
        followersCount: random.nextInt(5000) + 100,
        followingCount: random.nextInt(2000) + 100,
        buddiesCount: random.nextInt(1000) + 50,
        activityCreatedCount: random.nextInt(20) + 1,
        activityJoinedCount: random.nextInt(50) + 10,
        activities: shuffledImages.take(2).toList(),
        posts: shuffledImages.take(2).toList(),
        stories: shuffledStories.take(2).toList(),
        connectionType: connectionTypes[random.nextInt(connectionTypes.length)],
      ),
    );

    // Generate dummy reviews for the buddy.
    final List<Review> allReviews = List.generate(reviewers.length, (reviewIndex) {
      return Review(
        reviewer: reviewers[reviewIndex],
        rating: random.nextInt(5) + 1, // Random rating between 1 and 5.
        review: sampleReviews[random.nextInt(sampleReviews.length)],
        timeOfReview:
            DateTime.now().subtract(Duration(days: random.nextInt(365))),
      );
    });

    // Split reviews into creator and participant reviews (non-equal parts).
    final int creatorCount = (allReviews.length * 0.6).round(); // 60% for creator.
    final List<Review> creatorReviews = allReviews.take(creatorCount).toList();
    final List<Review> participantReviews = allReviews.skip(creatorCount).toList();

    // Calculate the creator and participant average ratings.
    final double creatorAverageRating = creatorReviews.isNotEmpty
        ? double.parse(
            (creatorReviews.fold(0, (sum, review) => sum + review.rating) /
                    creatorReviews.length)
                .toStringAsFixed(1))
        : 0.0;

    final double participantAverageRating = participantReviews.isNotEmpty
        ? double.parse(
            (participantReviews.fold(0, (sum, review) => sum + review.rating) /
                    participantReviews.length)
                .toStringAsFixed(1))
        : 0.0;

    // Generate a random `BuddyModel`.
    return BuddyModel(
      distance: random.nextInt(100) + 1, // Random distance between 1-100 miles.
      similarInterestsCount:
          random.nextInt(20), // Random 0-20 similar interests.
      mutualBuddiesCount: random.nextInt(30), // Random 0-30 mutual buddies.
      userName: "Buddy $index", // Generate unique user names, e.g., "Buddy 0".
      interests: shuffledInterests.take(3).toList(), // Pick 3 random interests.
      profileImages: shuffledImages.take(3).toList(), // Pick 3 random images.
      bio: shuffledBio, // Pick a random bio.
      followersCount:
          random.nextInt(10000) + 1000, // Random 1000-11000 followers.
      followingCount:
          random.nextInt(10000) + 1000, // Random 1000-11000 following.
      buddiesCount: random.nextInt(5000) + 500, // Random 500-5500 buddies.
      activityCreatedCount:
          random.nextInt(50) + 1, // Random 1-50 activities created.
      activityJoinedCount:
          random.nextInt(100) + 10, // Random 10-110 activities joined.
      activities: shuffledImages.take(5).toList(), // Pick 5 random activities.
      posts: shuffledImages.take(5).toList(), // Pick 5 random posts.
      connectionType: connectionTypes[
          random.nextInt(connectionTypes.length)], // Random connection type.
      stories: shuffledStories.take(3).toList(), // Pick 3 random stories.
      reviews: Reviews(
        count: allReviews.length,
        averageRating: double.parse(
            (allReviews.fold(0, (sum, review) => sum + review.rating) /
                    allReviews.length)
                .toStringAsFixed(1)),
        creatorReviewList: creatorReviews,
        participantReviewList: participantReviews,
        creatorOverallRating: creatorAverageRating,
        participantOverallRating: participantAverageRating,
      ),
    );
  });
}
/// Creates a subset of the buddies list within the specified range.
///
/// This ensures safe sublist creation by clamping the range within valid bounds.
List<BuddyModel> getFollowersList(
    List<BuddyModel> buddies, int startIndex, int count) {
  final endIndex = (startIndex + count).clamp(0, buddies.length);
  return buddies.sublist(startIndex, endIndex);
}

// Generate the full list of buddies.
final List<BuddyModel> fullBuddiesList = generateBuddiesList(500);

// Subset lists for specific purposes.
final List<BuddyModel> followersList = getFollowersList(fullBuddiesList, 0, 50);
final List<BuddyModel> followingList =
    getFollowersList(fullBuddiesList, 50, 100);
final List<BuddyModel> buddiesList =
    getFollowersList(fullBuddiesList, 100, 150);
