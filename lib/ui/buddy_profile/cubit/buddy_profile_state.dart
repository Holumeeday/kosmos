part of 'buddy_profile_cubit.dart';

class BuddyProfileState extends Equatable {
  const BuddyProfileState({
    required this.fBuddyModel,
  });
  final BuddyModel fBuddyModel;

  BuddyProfileState copyWith({BuddyModel? fBuddyModel}) {
    return BuddyProfileState(
      fBuddyModel: fBuddyModel ?? this.fBuddyModel,
    );
  }

  @override
  List<Object?> get props => [fBuddyModel];
}

// final class BuddyProfileInitial extends BuddyProfileState {}
