part of 'buddies_cubit.dart';

/// Buddies State
/// Holds all dynamic data for the Buddies Page.
/// @author: Chidera Chijama

class BuddiesState extends Equatable {
  final BuddiesModel fBuddiesModel;

  const BuddiesState({
    required this.fBuddiesModel,
  });

  /// Default initial state
  factory BuddiesState.initial() {
    return const BuddiesState(
      fBuddiesModel: BuddiesModel(
        distance: 3,
        similarInterests: 15,
        mutualBuddies: 12,
        userName: "Jordyn Vaccaro",
        interests: [
          "Art",
          "Hockey",
          "Sport",
          "Baseball",
          "Rugby",
          "Visual Arts",
          "Ice Hockey",
          "Softball",
        ],
      ),
    );
  }

  BuddiesState copyWith({BuddiesModel? fBuddiesModel}) {
    return BuddiesState(
      fBuddiesModel: fBuddiesModel ?? this.fBuddiesModel,
    );
  }

  @override
  List<Object?> get props => [fBuddiesModel];
}
