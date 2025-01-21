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
    if (state.otp == null ||
        state.otp!.isEmpty ||
        !RegExp(r'^\d+$').hasMatch(state.otp!)) {
      emit(state.copyWith(
          status: EmailOtpVerificationStatus.failure,
          errorMessage: "OTP must be a valid number."));
      return;
    }

    emit(state.copyWith(status: EmailOtpVerificationStatus.loading));

    try {
      final fResponse = await fAuthRepository.verifyEmailOtp(
        email: fEmail,
        otp: int.parse(state.otp!),
      );
      if (fResponse.status == true) {
        emit(state.copyWith(
          status: EmailOtpVerificationStatus.success,
          data: fResponse,
        ));
      } else {
        emit(state.copyWith(
          status: EmailOtpVerificationStatus.failure,
          errorMessage: fResponse.message,
        ));
      }
    } on PlaykosmosException catch (e) {
      emit(state.copyWith(
        status: EmailOtpVerificationStatus.failure,
        errorMessage: e.message,
      ));
    }
  }

  // void setOtp(String fOtp) {
  //   emit(state.copyWith(otp: fOtp.trim()));
  // }

  void setOtp({required String fOtp}) {
    final sanitizedOtp = fOtp.trim();
    emit(state.copyWith(
        otp: sanitizedOtp)); // Make sure you are passing the correct value here
  }

  void resendOtp() async {
    emit(state.copyWith(
        resendOtpStatus: EmailResendOtpVerificationStatus.loading));
    try {
      final fResponse = await fAuthRepository.resendOtpEmail(email: fEmail);
      if (fResponse.status == true) {
        emit(state.copyWith(
          resendOtpStatus: EmailResendOtpVerificationStatus.success,
        ));
      } else {
        emit(state.copyWith(
          resendOtpStatus: EmailResendOtpVerificationStatus.failure,
          errorMessage: fResponse.message,
        ));
      }
    } on PlaykosmosException catch (e) {
      emit(state.copyWith(
        resendOtpStatus: EmailResendOtpVerificationStatus.failure,
        errorMessage: e.message,
      ));
    }
  }
}
