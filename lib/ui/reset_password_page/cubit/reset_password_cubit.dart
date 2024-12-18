import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/data_transfer_objects/playkosmos_exception.dart';
import 'package:playkosmos_v3/models/generic_respose_model.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  /// The authentication api repository
  final AuthRemoteApiRepository fAuthRepository;

  ResetPasswordCubit({
    required this.fAuthRepository,
  }) : super(const ResetPasswordState());

  /// Reset new password email or phone
  void resetPassword({
    String? email,
    String? phone,
    required String password,
  }) async {
    emit(state.copyWith(status: ResetPasswordStatus.loading));
    try {
      late GenericResponse fResponse;
      if (email != null) {
        fResponse = await fAuthRepository.resetPasswordEmail(
          email: email,
          password: password,
        );
      } else {
        // create password for phone
      }

      // Emit the state if response status is failed or success with the error message
      // if available
      if (fResponse.status == true) {
        emit(
          state.copyWith(
            status: ResetPasswordStatus.success,
            data: fResponse,
          ),
        );
      } else {
        addError(fResponse.status);
        emit(
          state.copyWith(
            status: ResetPasswordStatus.failure,
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
          status: ResetPasswordStatus.failure,
        ),
      );
    }
  }
}
