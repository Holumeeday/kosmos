import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/data_transfer_objects/playkosmos_exception.dart';
import 'package:playkosmos_v3/models/generic_respose_model.dart';

part 'email_otp_verification_state.dart';

class EmailOtpVerificationCubit extends Cubit<EmailOtpVerificationState> {
  /// The authentication api repository
  final AuthRemoteApiRepository fAuthRepository;

  /// The user email
  final String fEmail;

  EmailOtpVerificationCubit({
    required this.fAuthRepository,
    required this.fEmail,
  }) : super(
          const EmailOtpVerificationState(),
        );

  /// Verify the otp
  void verifyOtp() async {
    if (state.otp == null) return;
    emit(state.copyWith(status: EmailOtpVerificationStatus.loading));
    try {
      final fResponse = await fAuthRepository.verifyEmailOtp(
        email: fEmail,
        otp: int.parse(state.otp!),
      );
      // Emit the state if response status is failed or success with the error message
      // if available
      if (fResponse.status == true) {
        emit(
          state.copyWith(
            status: EmailOtpVerificationStatus.success,
            data: fResponse,
          ),
        );
      } else {
        addError(fResponse.status);
        emit(
          state.copyWith(
            status: EmailOtpVerificationStatus.failure,
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
          status: EmailOtpVerificationStatus.failure,
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
        resendOtpStatus: EmailResendOtpVerificationStatus.loading));
    try {
      final fResponse = await fAuthRepository.forgotPasswordEmail(
        email: fEmail,
      );
      // Emit the state if response status is failed or success with the error message
      // if available
      if (fResponse.status == true) {
        emit(
          state.copyWith(
            resendOtpStatus: EmailResendOtpVerificationStatus.success,
            data: fResponse,
          ),
        );
      } else {
        addError(fResponse.status);
        emit(
          state.copyWith(
            resendOtpStatus: EmailResendOtpVerificationStatus.failure,
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
          resendOtpStatus: EmailResendOtpVerificationStatus.failure,
        ),
      );
    }
  }
}
