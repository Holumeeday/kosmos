import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:playkosmos_v3/constants/interests_constants.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/data_transfer_objects/playkosmos_exception.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/models/activity_interest_groups.dart';
import 'package:playkosmos_v3/models/file_upload_url_path_model.dart';
import 'package:playkosmos_v3/models/generic_respose_model.dart';
import 'package:playkosmos_v3/models/location_model.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/models/profile_creation_flow_model.dart';
import 'package:playkosmos_v3/utils/utils.dart';

part 'profile_creation_flow_state.dart';

/// A Cubit to manage the profile creation flow.
/// Handles user actions like selecting interests, changing stages, and setting profile data.
///
/// @author: Godwin Mathias
class ProfileCreationFlowCubit extends Cubit<ProfileCreationFlowState> {
  ///  Authentication repository
  final AuthRemoteApiRepository fAuthRepository;

  /// The user storage repository
  final UserProfileStorage fUserRepository;

  /// Initializes the cubit with the default profile creation state.
  ProfileCreationFlowCubit({
    required this.fAuthRepository,
    required this.fUserRepository,
  }) : super(
          ProfileCreationFlowState(
            fProfileCreationStage: ProfileCreationFlowEnum.uploadName,
            fSelectedInterestMap: const {},
            fFlowModel: ProfileCreationFlowModel(
                interests: const [...kActivityInterestGroups],
                profilePicsList: List.filled(9, null),
                radiusUnits: UnitOfLocationMeasurementEnum.kilometres.name),
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
    final fInterestGroupList = state.fFlowModel.interests!;

    final updatedInterestGroupList = [...fInterestGroupList];
    final groupIndex = fInterestGroupList.indexWhere(
      (group) => group.categoryName == fActivityGroup.categoryName,
    );
    updatedInterestGroupList[groupIndex] = updatedInterestGroup;

    emit(
      state.copyWith(
          fSelectedInterestMap: updatedInterestMap,
          fFlowModel:
              state.fFlowModel.copyWith(interests: updatedInterestGroupList)),
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
    final fInterestGroupList = state.fFlowModel.interests!;

    final updatedInterestGroup = fActivityGroup.copyWith(selectAll: selectAll);
    final updatedInterestGroupList = [...fInterestGroupList];
    final groupIndex = fInterestGroupList.indexWhere(
      (group) => group.categoryName == fActivityGroup.categoryName,
    );
    updatedInterestGroupList[groupIndex] = updatedInterestGroup;

    emit(
      state.copyWith(
        fSelectedInterestMap: updatedInterestMap,
        fFlowModel:
            state.fFlowModel.copyWith(interests: updatedInterestGroupList),
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
    final fInterestGroupList = state.fFlowModel.interests!;

    final updatedInterestGroupList = [...fInterestGroupList];
    final groupIndex = fInterestGroupList.indexWhere(
      (group) => group.categoryName == fInterestGroup.categoryName,
    );
    updatedInterestGroupList[groupIndex] = updatedInterestGroup;

    emit(
      state.copyWith(
          fFlowModel:
              state.fFlowModel.copyWith(interests: updatedInterestGroupList)),
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

  /// Sets the user current location data
  Future<void> setLocation() async {
    final position = await LocationUtil.getLocation();
    if (position == null) return;
    // The getting of location property takes time sometimes
    if (!isClosed) {
      emit(state.copyWith(
          fFlowModel: state.fFlowModel.copyWith(
              location: Locations(
                  latitude: position.latitude,
                  longitude: position.longitude))));
    } else {
      // In case it was closed we can just add the values directly to the API
      uploadOtherDetails(
          location: Locations(
              latitude: position.latitude, longitude: position.longitude));
    }
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
// Debugging print
    emit(state.copyWith(
      fFlowModel: state.fFlowModel.copyWith(radiusUnits: option),
    ));
  }

  /// Updates the selected search radius.
  void setSearchRadius(double searchRadius) {
    emit(
      state.copyWith(
        fFlowModel: state.fFlowModel.copyWith(radius: searchRadius),
      ),
    );
  }

  /// --------------- API upload section ----------------

  /// Upload name and Bio
  void uploadNameBio({
    required String name,
    String? bio,
  }) async {
    emit(state.copyWith(
        uploadNameStatus: ProfileCreationUploadNameStatus.loading));
    try {
      final fResponse = await fAuthRepository.setUsernameBio(
        fullName: name,
        bio: bio,
      );

      // Emit the state if response status is failed or success with the error message
      // if available
      if (fResponse.status == true) {
        _updateUserRepository(name: name);
        emit(
          state.copyWith(
            uploadNameStatus: ProfileCreationUploadNameStatus.success,
            data: fResponse,
          ),
        );
      } else {
        addError(fResponse.status);
        emit(
          state.copyWith(
            uploadNameStatus: ProfileCreationUploadNameStatus.failure,
            data: fResponse,
            errorMessage: fResponse.message,
          ),
        );
      }
    } on PlaykosmosException catch (e) {
      addError(e);
      emit(
        state.copyWith(
          errorMessage: e.message,
          uploadNameStatus: ProfileCreationUploadNameStatus.failure,
        ),
      );
    }
  }

  /// Upload name and bio details
  Future<void> uploadOtherDetails({
    String? name,
    int? searchRadius,
    String? birthday,
    GenderEnum? gender,
    ActivityInterestGroupsList? interests,
    Locations? location,
  }) async {
    if (!isClosed) {
      emit(state.copyWith(
          uploadOthersStatus: ProfileCreationUploadOthersStatus.loading));
    }

    try {
      final formattedBirthday = state.fFlowModel.dateOfBirth != null
          ? DateFormat('yyyy-MM-dd').format(state.fFlowModel.dateOfBirth!)
          : null;

      final selectedInterests =
          _mapSelectedInterests(state.fSelectedInterestMap);

      final fResponse = await fAuthRepository.setOnboarding(
        fullName: name,
        searchRadius: state.fFlowModel.radius,
        birthday: formattedBirthday,
        gender: state.fFlowModel.gender,
        interests: selectedInterests,
        location: state.fFlowModel.location,
      );

      if (fResponse.status) {
        _updateUserRepository(
          name: name,
          searchRadius: state.fFlowModel.radius?.round(),
          birthday: state.fFlowModel.dateOfBirth,
          gender: state.fFlowModel.gender,
          interests: selectedInterests,
          location: state.fFlowModel.location,
        );
      }

      if (isClosed) return;

      emit(
        state.copyWith(
          uploadOthersStatus: fResponse.status
              ? ProfileCreationUploadOthersStatus.success
              : ProfileCreationUploadOthersStatus.failure,
          data: fResponse,
          errorMessage: fResponse.status ? null : fResponse.message,
        ),
      );
    } catch (e) {
      _handleError(e);
    }
  }

  /// Upload images to AWS bucket
  Future<void> uploadImages({required List<File?> images}) async {
    final newImages = images.whereType<File>().toList();

    try {
      final fResponse = await fAuthRepository.getOnboardingImageUrls(
        totalImages: newImages.length,
      );

      if (!fResponse.status) return;

      final fileUploadUrls = FileUploadPartModel.fromMap(fResponse.data);
      final uploadedImageUrls =
          await _uploadFilesToAWS(newImages, fileUploadUrls);

      if (uploadedImageUrls.isNotEmpty) {
        await fAuthRepository.setOnboarding(pictures: uploadedImageUrls);
        fUserRepository.setUser(
          fUserRepository.fUserModel.copyWith(
            pictures: uploadedImageUrls,
          ),
        );
      }
    } catch (_) {
      // Handle or log exceptions as needed
    }
  }

  /// Map selected interests to ActivityInterestGroupsList
  ActivityInterestGroupsList? _mapSelectedInterests(
      Map<String, List<String>> selectedInterestMap) {
    if (selectedInterestMap.isEmpty) return null;

    return ActivityInterestGroupsList(
      groups: selectedInterestMap.entries
          .map((entry) => ActivityInterestGroups(
                categoryName: entry.key,
                interests: entry.value,
              ))
          .toList(),
    );
  }

  /// Update user repository with new details
  void _updateUserRepository({
    String? name,
    int? searchRadius,
    DateTime? birthday,
    GenderEnum? gender,
    ActivityInterestGroupsList? interests,
    Locations? location,
  }) {
    fUserRepository.setUser(fUserRepository.fUserModel.copyWith(
      fullName: name,
      searchRadius: searchRadius,
      birthday: birthday,
      gender: gender,
      interests: interests,
      locations: location,
    ));
  }

  /// Upload files to AWS and return their URLs
  Future<List<String>> _uploadFilesToAWS(
      List<File> files, FileUploadPartModel fileUploadUrls) async {
    final uploadedImageUrls = <String>[];

    for (final (index, imageUrl) in (fileUploadUrls.url ?? []).indexed) {
      await fAuthRepository.uploadImagesWithFile(
        image: files[index],
        uploadPath: imageUrl.uploadUrl!,
      );
      uploadedImageUrls.add(imageUrl.fileUrl!);
    }

    return uploadedImageUrls;
  }

  /// Handle errors and update state
  void _handleError(Object e) {
    if (e is PlaykosmosException) {
      addError(e);
      emit(
        state.copyWith(
          errorMessage: e.message,
          uploadOthersStatus: ProfileCreationUploadOthersStatus.failure,
        ),
      );
    } else {
      printE(e);
    }
  }
}
