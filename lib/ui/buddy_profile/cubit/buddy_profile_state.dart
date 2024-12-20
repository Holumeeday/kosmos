part of 'buddy_profile_cubit.dart';

 class BuddyProfileState extends Equatable {
  const BuddyProfileState( {required this.fBuddiesModel,});
  final BuddiesModel fBuddiesModel;
  


  BuddyProfileState copyWith({BuddiesModel? fBuddiesModel}) {
    return BuddyProfileState(fBuddiesModel: fBuddiesModel ?? this.fBuddiesModel,
    );
  }

  @override
  List<Object?> get props => [fBuddiesModel];
}

// final class BuddyProfileInitial extends BuddyProfileState {}
