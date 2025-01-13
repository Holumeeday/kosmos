part of 'buddy_profile_cubit.dart';

class BuddyProfileState extends Equatable {
  const BuddyProfileState({
    required this.fBuddyModel,
    required this.fActivityInterestGroupList,
  });
  final DummyBuddyModel fBuddyModel;
  final List<ActivityInterestGroups> fActivityInterestGroupList;

  BuddyProfileState copyWith({DummyBuddyModel? fBuddyModel, List<ActivityInterestGroups>? fActivityInterestGroupList}) {
    return BuddyProfileState(
      fBuddyModel: fBuddyModel ?? this.fBuddyModel,
      fActivityInterestGroupList: fActivityInterestGroupList?? this.fActivityInterestGroupList
    );
  }

  @override
  List<Object?> get props => [fBuddyModel];
}

// final class BuddyProfileInitial extends BuddyProfileState {}
