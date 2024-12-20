import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// ignore: unused_import
import 'package:playkosmos_v3/enums/connection_type.dart';
import 'package:playkosmos_v3/models/buddies_model.dart';

part 'buddies_state.dart';

/*
 Buddies Cubit
 Supplies dynamic data for the Buddies Page.
 @author: Chidera Chijama
 */
class BuddiesCubit extends Cubit<BuddiesState> {
  BuddiesCubit()
      : super(const BuddiesState(
          fBuddiesModel: BuddiesModel(
          
          ),
        ));

  /// get the user's name
  void getUserName(String userName) {
    emit(state.copyWith(
        fBuddiesModel: state.fBuddiesModel.copyWith(userName: userName)));
  }

  /// get the distance text
  void getDistance(int distance) {
    emit(state.copyWith(
        fBuddiesModel: state.fBuddiesModel.copyWith(distance: distance)));
  }

  /// get the number of mutual buddies
  void getMutualBuddyCount(int count) {
    emit(state.copyWith(
        fBuddiesModel:
            state.fBuddiesModel.copyWith(mutualBuddiesCount: count)));
  }

  /// get the number of similar interests
  void getSimilarInterestCount(int count) {
    emit(state.copyWith(
        fBuddiesModel:
            state.fBuddiesModel.copyWith(similarInterestsCount: count)));
  }

  /// get the interest list
  void getInterestList(List<String> interests) {
    emit(state.copyWith(
        fBuddiesModel: state.fBuddiesModel.copyWith(interests: interests)));
  }
}
