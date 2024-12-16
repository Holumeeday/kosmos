import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/data_transfer_objects/playkosmos_exception.dart';
import 'package:playkosmos_v3/models/generic_respose_model.dart';

part 'forgot_password_otp_state.dart';

class ForgotPasswordOtpVerificationCubit
    extends Cubit<ForgotPasswordOtpVerificationState> {
  /// The authentication api repository
  final AuthRemoteApiRepository fAuthRepository;

  /// The user email
  final String fEmail;

  ForgotPasswordOtpVerificationCubit({
    required this.fAuthRepository,
    required this.fEmail,
  }) : super(
          const ForgotPasswordOtpVerificationState(),
        );

  /// Verify the otp
  void verifyOtp() async {
    if (state.otp == null) return;
    emit(state.copyWith(status: ForgotPasswordOtpVerificationStatus.loading));
    try {
      final fResponse = await fAuthRepository.verifyOtpForgotPasswordEmail(
        email: fEmail,
        otp: state.otp!,
      );
      // Emit the state if response status is failed or success with the error message
      // if available
      if (fResponse.status == true) {
        emit(
          state.copyWith(
            status: ForgotPasswordOtpVerificationStatus.success,
            data: fResponse,
          ),
        );
      } else {
        addError(fResponse.status);
        emit(
          state.copyWith(
            status: ForgotPasswordOtpVerificationStatus.failure,
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
          status: ForgotPasswordOtpVerificationStatus.failure,
        ),
      );
    }
  }

  /// Set otp value
  void setOtp({required String fOtp}) {
    emit(state.copyWith(otp: fOtp));
  }

  /// To resend the otp
  void resendOtp() async {
    emit(state.copyWith(
        resendOtpStatus: ForgotPasswordResendOtpVerificationStatus.loading));
    try {
      final fResponse = await fAuthRepository.resendOtpForgotPasswordEmail(
        email: fEmail,
      );
      // Emit the state if response status is failed or success with the error message
      // if available
      if (fResponse.status == true) {
        emit(
          state.copyWith(
            resendOtpStatus: ForgotPasswordResendOtpVerificationStatus.success,
            data: fResponse,
          ),
        );
      } else {
        addError(fResponse.status);
        emit(
          state.copyWith(
            resendOtpStatus: ForgotPasswordResendOtpVerificationStatus.failure,
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
          resendOtpStatus: ForgotPasswordResendOtpVerificationStatus.failure,
        ),
      );
    }
  }
}
