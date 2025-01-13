import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/constants/interests_constants.dart';
import 'package:playkosmos_v3/models/activity_interest_groups.dart';
import 'package:playkosmos_v3/models/buddy_model.dart';
part 'buddy_profile_state.dart';

class BuddyProfileCubit extends Cubit<BuddyProfileState> {
  BuddyProfileCubit()
      : super(BuddyProfileState(
            fBuddyModel: const DummyBuddyModel(),
            fActivityInterestGroupList:
                mapInterestsToCategories(const DummyBuddyModel().interests)));
  void setSeeMore(ActivityInterestGroups fInterestGroup) {
    final updatedInterestGroup =
        fInterestGroup.copyWith(showAll: !fInterestGroup.showAll);
    final fInterestGroupList =
        mapInterestsToCategories(state.fBuddyModel.interests);

    final updatedInterestGroupList = [...fInterestGroupList];
    final groupIndex = fInterestGroupList.indexWhere(
      (group) => group.categoryName == fInterestGroup.categoryName,
    );
    updatedInterestGroupList[groupIndex] = updatedInterestGroup;

    emit(state.copyWith(fActivityInterestGroupList: updatedInterestGroupList));
  }
}
