part of 'buddy_profile_cubit.dart';

class BuddyProfileState extends Equatable {
  const BuddyProfileState({
    required this.fBuddyModel,
  });
  final DummyBuddyModel fBuddyModel;

  BuddyProfileState copyWith({DummyBuddyModel? fBuddyModel}) {
    return BuddyProfileState(
      fBuddyModel: fBuddyModel ?? this.fBuddyModel,
    );
  }

  @override
  List<Object?> get props => [fBuddyModel];
}

// final class BuddyProfileInitial extends BuddyProfileState {}
