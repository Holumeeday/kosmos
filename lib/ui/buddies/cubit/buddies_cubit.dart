import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/models/buddies_model.dart';

part 'buddies_state.dart';

/*
 Buddies Cubit
 Supplies dynamic data for the Buddies Page.
 @author: Chidera Chijama\
 */
class BuddiesCubit extends Cubit<BuddiesState> {
  BuddiesCubit()
      : super(BuddiesState(
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
              "Softball"
            ],
          ),
        ));

  /// get the user's name
  void getUserName(String userName) {
    emit(state.copyWith(fBuddiesModel: state.fBuddiesModel.copyWith(userName: userName)));
  }

  /// get the distance text
  void getDistance(int distance) {
        emit(state.copyWith(fBuddiesModel: state.fBuddiesModel.copyWith(distance: distance)));

  }

  /// get the number of mutual buddies
  void getMutualBuddyCount(int count) {
        emit(state.copyWith(fBuddiesModel: state.fBuddiesModel.copyWith(mutualBuddies: count)));

  }

  /// get the number of similar interests
  void getSimilarInterestCount(int count) {
        emit(state.copyWith(fBuddiesModel: state.fBuddiesModel.copyWith(similarInterests: count)));

  }

  /// get the interest list
  void getInterestList(List<String> interests) {
    emit(state.copyWith(fBuddiesModel: state.fBuddiesModel.copyWith(interest: interests)));
    
  }
}
