part of 'buddies_cubit.dart';

/// Buddies State
/// Holds all dynamic data for the Buddies Page.
/// @author: Chidera Chijama

class BuddiesState extends Equatable {
  final BuddiesModel fBuddiesModel;

  const BuddiesState({
    required this.fBuddiesModel,
  });


  BuddiesState copyWith({BuddiesModel? fBuddiesModel}) {
    return BuddiesState(
      fBuddiesModel: fBuddiesModel ?? this.fBuddiesModel,
    );
  }

  @override
  List<Object?> get props => [fBuddiesModel];
}
