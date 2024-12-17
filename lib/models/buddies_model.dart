/* BuddiesModel
 Represents the Buddies data structure.
 @author: Chidera Chijama
 */

class BuddiesModel {
  final int distance; // Formatted distance text
  final int similarInterests; // Count of similar interests
  final int mutualBuddies; // Count of mutual buddies
  final String userName; // Name of the buddy
  final List<String> interests; // List of interests

  const BuddiesModel({
    required this.distance,
    required this.similarInterests,
    required this.mutualBuddies,
    required this.userName,
    required this.interests,
  });

  /// Factory method to create a BuddiesModel from JSON data
  factory BuddiesModel.fromJson(Map<String, dynamic> json) {
    return BuddiesModel(
      distance: json['distanceText'] ?? "0 miles away",
      similarInterests: json['similarInterestsCount'] ?? 0,
      mutualBuddies: json['mutualBuddiesCount'] ?? 0,
      userName: json['userName'] ?? "Unknown",
      interests: List<String>.from(json['interestList'] ?? []),
    );
  }

  /// CopyWith method for partial updates
  BuddiesModel copyWith({
    int? distance,
    int? similarInterests,
    int? mutualBuddies,
    String? userName,
    List<String>? interest,
  }) {
    return BuddiesModel(
      distance: distance ?? this.distance,
      similarInterests: similarInterests ?? this.similarInterests,
      mutualBuddies: mutualBuddies ?? this.mutualBuddies,
      userName: userName ?? this.userName,
      interests: interest ?? this.interests,
    );
  }
}
