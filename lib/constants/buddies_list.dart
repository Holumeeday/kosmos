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

/// Generates a list of `BuddyModel` with random data.
///
/// The number of buddies to generate is determined by the `totalBuddies` parameter.
List<BuddyModel> generateBuddiesList(int totalBuddies) {
  return List.generate(totalBuddies, (index) {
    // Shuffle sample data for randomness.
    final shuffledInterests = [...sampleInterests]..shuffle(random);
    final shuffledImages = [...sampleImages]..shuffle(random);
    final shuffledStories = [...sampleStories]..shuffle(random);
    final shuffledBio = sampleBios[random.nextInt(sampleBios.length)];

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
      reviewCount: random.nextInt(500) + 10, // Random 10-510 reviews.
      reviewStars:
          (random.nextDouble() * 5).clamp(1.0, 5.0), // Random 1.0-5.0 stars.
      activities: shuffledImages.take(5).toList(), // Pick 5 random activities.
      posts: shuffledImages.take(5).toList(), // Pick 5 random posts.
      connectionType: connectionTypes[
          random.nextInt(connectionTypes.length)], // Random connection type.
      stories: shuffledStories.take(3).toList(), // Pick 3 random stories.
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
