import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/models/buddies_model.dart';

part 'buddy_profile_state.dart';

class BuddyProfileCubit extends Cubit<BuddyProfileState> {
  BuddyProfileCubit()
      : super(const BuddyProfileState(
            fBuddiesModel: BuddiesModel(
          userName: 'Jordyn Vaccaro',
          interests: [
            "Art",
            "Hockey",
            "Sport",
            "Baseball",
            "Rugby",
            "Visual Arts",
            "Ice Hockey",
            "Softball",
            "Softball"
          ],
          profileImages: ['', '', ''],
          bio:
              'Professional daydreamer, coffee enthusiast, and expert in pressing ‘Next Episode.’ Living life one witty remark at a time',
          followersCount: 4200,
          followingCount: 1200000,
          buddiesCount: 3200000,
          activityCreatedCount: 300,
          activityJoinedCount: 1200,
          reviewCount: 300,
          reviewStars: 4.5,
          activities: [],
          posts: [],
        )));
}
