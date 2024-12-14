import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/data_transfer_objects/playkosmos_exception.dart';
import 'package:playkosmos_v3/models/generic_respose_model.dart';

part 'sign_up_with_email_state.dart';

class SignUpWithEmailCubit extends Cubit<SignUpWithEmailState> {
  /// The authentication api repository
  final AuthRemoteApiRepository fAuthRepository;

  SignUpWithEmailCubit({
    required this.fAuthRepository,
  }) : super(const SignUpWithEmailState());

  /// Sign up with email
  void signUpEmail({required String email}) async {
    emit(state.copyWith(status: SignUpWithEmailStatus.loading));
    try {
      final fResponse = await fAuthRepository.signUpEmail(email: email);
      // Emit the state if response status is failed or success with the error message
      // if available
      if (fResponse.status == true) {
        emit(
          state.copyWith(
            status: SignUpWithEmailStatus.success,
            data: fResponse,
          ),
        );
      } else {
        addError(fResponse.status);
        emit(
          state.copyWith(
            status: SignUpWithEmailStatus.failure,
            data: fResponse,
            errorMessage: fResponse.message,
          ),
        );
      }
    } on PlaykosmosException catch (e) {
      addError(e);
      emit(
        state.copyWith(errorMessage: e.message),
      );
    }
  }
}
