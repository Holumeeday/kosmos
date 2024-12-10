import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/enums/enums.dart';

part 'profile_creation_flow_state.dart';

class ProfileCreationFlowCubit extends Cubit<ProfileCreationFlowState> {
  ProfileCreationFlowCubit()
      : super(
          const ProfileCreationFlowState(
            fProfileCreationStage: ProfileCreationFlowEnum.uploadName,
          ),
        );

  void changePage(ProfileCreationFlowEnum fPageEnum) {
    emit(state.copyWith(fProfileCreationStage: fPageEnum));
  }
}
