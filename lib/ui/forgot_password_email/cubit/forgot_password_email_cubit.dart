import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/data_transfer_objects/playkosmos_exception.dart';
import 'package:playkosmos_v3/models/generic_respose_model.dart';

part 'forgot_password_email_state.dart';

class ForgotPasswordEmailCubit extends Cubit<ForgotPasswordEmailState> {
  /// The authentication api repository
  final AuthRemoteApiRepository fAuthRepository;

  ForgotPasswordEmailCubit({
    required this.fAuthRepository,
  }) : super(const ForgotPasswordEmailState());

  /// Forgot password with email
  void forgotPasswordEmail({required String email}) async {
    emit(state.copyWith(status: ForgotPasswordEmailStatus.loading));
    try {
      final fResponse = await fAuthRepository.forgotPasswordEmail(email: email);
      // Emit the state if response status is failed or success with the error message
      // if available
      if (fResponse.status == true) {
        emit(
          state.copyWith(
            status: ForgotPasswordEmailStatus.success,
            data: fResponse,
          ),
        );
      } else {
        addError(fResponse.status);
        emit(
          state.copyWith(
            status: ForgotPasswordEmailStatus.failure,
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
          status: ForgotPasswordEmailStatus.failure,
        ),
      );
    }
  }
}
