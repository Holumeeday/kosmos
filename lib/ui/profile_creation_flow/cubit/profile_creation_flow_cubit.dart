import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/constants/interests_constants.dart';
import 'package:playkosmos_v3/data_transfer_objects/activity_interest_groups.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/models/profile_creation_flow_model.dart';

part 'profile_creation_flow_state.dart';

/// A Cubit to manage the profile creation flow.
/// Handles user actions like selecting interests, changing stages, and setting profile data.
///
/// @author: Godwin Mathias
class ProfileCreationFlowCubit extends Cubit<ProfileCreationFlowState> {
  /// Initializes the cubit with the default profile creation state.
  ProfileCreationFlowCubit()
      : super(
          ProfileCreationFlowState(
            fProfileCreationStage: ProfileCreationFlowEnum.uploadName,
            fSelectedInterestMap: const {},
            fInterestGroupList: const [...kActivityInterestGroup],
            fFlowModel: ProfileCreationFlowModel(
              profilePicsList: List.filled(5, null),
            ),
            fSearchRadius: 7,
            fLocationMeasure: UnitOfLocationMeasurementEnum.miles.name
          ),
        );

  /// Toggles the selection of a specific interest within a group.
  ///
  /// [fActivityGroup] - The group of interests.
  /// [fInterest] - The specific interest to toggle.
  void selectInterest(ActivityInterestGroups fActivityGroup, String fInterest) {
    final currentInterests = [
      ...state.fSelectedInterestMap[fActivityGroup.categoryName] ?? <String>[]
    ];

    if (currentInterests.contains(fInterest)) {
      currentInterests.remove(fInterest);
    } else {
      currentInterests.add(fInterest);
    }

    final selectAll =
        currentInterests.length == fActivityGroup.interests.length;

    final updatedInterestGroup = fActivityGroup.copyWith(selectAll: selectAll);
    final updatedInterestMap =
        Map<String, List<String>>.from(state.fSelectedInterestMap)
          ..[fActivityGroup.categoryName] = currentInterests;

    final updatedInterestGroupList = [...state.fInterestGroupList];
    final groupIndex = state.fInterestGroupList.indexWhere(
      (group) => group.categoryName == fActivityGroup.categoryName,
    );
    updatedInterestGroupList[groupIndex] = updatedInterestGroup;

    emit(
      state.copyWith(
        fSelectedInterestMap: updatedInterestMap,
        fInterestGroupList: updatedInterestGroupList,
      ),
    );
  }

  /// Toggles the "Select All" state for a group of interests.
  ///
  /// [fActivityGroup] - The group of interests.
  void setSelectAllInterestGroup(ActivityInterestGroups fActivityGroup) {
    final currentInterests = [
      ...state.fSelectedInterestMap[fActivityGroup.categoryName] ?? []
    ];

    final selectAll =
        currentInterests.length != fActivityGroup.interests.length;
    final updatedInterests =
        selectAll ? [...fActivityGroup.interests] : <String>[];

    final updatedInterestMap =
        Map<String, List<String>>.from(state.fSelectedInterestMap)
          ..[fActivityGroup.categoryName] = updatedInterests;

    final updatedInterestGroup = fActivityGroup.copyWith(selectAll: selectAll);
    final updatedInterestGroupList = [...state.fInterestGroupList];
    final groupIndex = state.fInterestGroupList.indexWhere(
      (group) => group.categoryName == fActivityGroup.categoryName,
    );
    updatedInterestGroupList[groupIndex] = updatedInterestGroup;

    emit(
      state.copyWith(
        fSelectedInterestMap: updatedInterestMap,
        fInterestGroupList: updatedInterestGroupList,
      ),
    );
  }

  /// Changes the current page of the profile creation flow.
  ///
  /// [fPageEnum] - The new stage of the profile creation flow.
  void changePage(ProfileCreationFlowEnum fPageEnum) {
    emit(state.copyWith(fProfileCreationStage: fPageEnum));
  }

  /// Updates the list of selected profile image files.
  ///
  /// [fImages] - The list of image files.
  void changeSelectedImageFiles(List<File?> fImages) {
    emit(
      state.copyWith(
        fFlowModel: state.fFlowModel.copyWith(profilePicsList: [...fImages]),
      ),
    );
  }

  /// Toggles the "Show All" state for a group of interests.
  ///
  /// [fInterestGroup] - The group of interests.
  void setShowAll(ActivityInterestGroups fInterestGroup) {
    final updatedInterestGroup =
        fInterestGroup.copyWith(showAll: !fInterestGroup.showAll);

    final updatedInterestGroupList = [...state.fInterestGroupList];
    final groupIndex = state.fInterestGroupList.indexWhere(
      (group) => group.categoryName == fInterestGroup.categoryName,
    );
    updatedInterestGroupList[groupIndex] = updatedInterestGroup;

    emit(
      state.copyWith(fInterestGroupList: updatedInterestGroupList),
    );
  }

  /// Sets the user's date of birth.
  ///
  /// [fDate] - The selected date of birth.
  void changeBirthday(DateTime fDate) {
    emit(
      state.copyWith(
        fFlowModel: state.fFlowModel.copyWith(dateOfBirth: fDate),
      ),
    );
  }

  /// Sets the user's gender.
  ///
  /// [fGender] - The selected gender.
  void changeGender(GenderEnum fGender) {
    emit(
      state.copyWith(
        fFlowModel: state.fFlowModel.copyWith(gender: fGender),
      ),
    );
  }

  /// Moves to the next stage of the profile creation flow.
  void nextPage() {
    final nextStageIndex = state.fProfileCreationStage.index + 1;
    if (nextStageIndex < ProfileCreationFlowEnum.values.length) {
      emit(
        state.copyWith(
          fProfileCreationStage: ProfileCreationFlowEnum.values[nextStageIndex],
        ),
      );
    }
  }

    /// Updates the selected location measure option.
  void setLocationMeasure(String option) {
    final selectedOption = UnitOfLocationMeasurementEnum.values.firstWhere(
      (element) => element.name.toLowerCase() == option.toLowerCase(),
    ).name;
    emit(state.copyWith(fLocationMeasure: selectedOption));
  }

      /// Updates the selected search radius.
  void setSearchRadius(double searchRadius ) {
   
    emit(state.copyWith(fSearchRadius: searchRadius));
  }
}

