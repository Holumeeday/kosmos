import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/models/profile_creation_flow_model.dart';

part 'profile_creation_flow_state.dart';

class ProfileCreationFlowCubit extends Cubit<ProfileCreationFlowState> {
  ProfileCreationFlowCubit()
      : super(
          ProfileCreationFlowState(
              fProfileCreationStage: ProfileCreationFlowEnum.uploadName,
              fFlowModel: ProfileCreationFlowModel(
                  profilePicsList: List.filled(5, null))),
        );

  void changePage(ProfileCreationFlowEnum fPageEnum) {
    emit(state.copyWith(fProfileCreationStage: fPageEnum));
  }

  void changeSelectedImageFiles(List<File?> fImages) {
    emit(
      state.copyWith(
        fFlowModel: state.fFlowModel.copyWith(profilePicsList: [...fImages]),
      ),
    );
  }

  void changeBirthday(DateTime fDate) {
    emit(
      state.copyWith(
        fFlowModel: state.fFlowModel.copyWith(dateOfBirth: fDate),
      ),
    );
  }

  void changeGender(GenderEnum fGender) {
    emit(
      state.copyWith(
        fFlowModel: state.fFlowModel.copyWith(gender: fGender),
      ),
    );
  }

  void nextPage() {
    emit(
      state.copyWith(
        fProfileCreationStage: ProfileCreationFlowEnum.values
            .elementAt(state.fProfileCreationStage.index + 1),
      ),
    );
  }
}
