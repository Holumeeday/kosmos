part of 'buddy_connections_cubit.dart';

/// Represents the state for the Buddy Connections feature.
///
/// Holds data about the lists of followers, buddies, and those being followed,
/// as well as their respective "show all" toggle states.
/// @author - Chidera Chijama
class BuddyConnectionsState extends Equatable {
  const BuddyConnectionsState({
    required this.fFollowers,
    required this.fFollowersListBuddies,
    required this.fFollowersShowAll,
    required this.fBuddies,
    required this.fBuddiesListBuddies,
    required this.fBuddiesShowAll,
    required this.fFollowing,
    required this.fFollowingListBuddies,
    required this.fFollowingShowAll,
  });

  /// List of all users being followed by the current user.
  final List<BuddyModel> fFollowing;

  /// Filtered list of users being followed with connection type `'buddy'`.
  final List<BuddyModel> fFollowingListBuddies;

  /// Indicates whether to show all followers or limit the displayed list.
  final bool fFollowingShowAll;

  /// List of all users following the current user.
  final List<BuddyModel> fFollowers;

  /// Filtered list of users following with connection type `'buddy'`.
  final List<BuddyModel> fFollowersListBuddies;

  /// Indicates whether to show all followers or limit the displayed list.
  final bool fFollowersShowAll;

  /// List of all buddies connected with the current user.
  final List<BuddyModel> fBuddies;

  /// Filtered list of buddies with connection type `'buddy'`.
  final List<BuddyModel> fBuddiesListBuddies;

  /// Indicates whether to show all buddies or limit the displayed list.
  final bool fBuddiesShowAll;

  @override
  List<Object> get props => [
        fFollowing,
        fFollowingListBuddies,
        fFollowingShowAll,
        fFollowers,
        fFollowersListBuddies,
        fFollowersShowAll,
        fBuddies,
        fBuddiesListBuddies,
        fBuddiesShowAll,
      ];

  /// Creates a copy of the current state with updated values for the specified fields.
  BuddyConnectionsState copyWith({
    List<BuddyModel>? fFollowing,
    bool? fFollowingShowAll,
    List<BuddyModel>? fFollowingListBuddies,
    List<BuddyModel>? fFollowers,
    bool? fFollowersShowAll,
    List<BuddyModel>? fFollowersListBuddies,
    List<BuddyModel>? fBuddies,
    bool? fBuddiesShowAll,
    List<BuddyModel>? fBuddiesListBuddies,
  }) {
    return BuddyConnectionsState(
      fFollowing: fFollowing ?? this.fFollowing,
      fFollowingShowAll: fFollowingShowAll ?? this.fFollowingShowAll,
      fFollowingListBuddies:
          fFollowingListBuddies ?? this.fFollowingListBuddies,
      fFollowers: fFollowers ?? this.fFollowers,
      fFollowersShowAll: fFollowersShowAll ?? this.fFollowersShowAll,
      fFollowersListBuddies:
          fFollowersListBuddies ?? this.fFollowersListBuddies,
      fBuddies: fBuddies ?? this.fBuddies,
      fBuddiesShowAll: fBuddiesShowAll ?? this.fBuddiesShowAll,
      fBuddiesListBuddies: fBuddiesListBuddies ?? this.fBuddiesListBuddies,
    );
  }
}
