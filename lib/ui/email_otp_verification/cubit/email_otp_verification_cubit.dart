import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'email_otp_verification_state.dart';

class EmailOtpVerificationCubit extends Cubit<EmailOtpVerificationState> {
  EmailOtpVerificationCubit()
      : super(
          const EmailOtpVerificationState(
            dCanResendOtp: false,
            dShowSuccessDialog: false,
          ),
        );

  /// Setting the [dCanResendOtp] value
  void setResendingOtp(bool value) {
    emit(state.copyWith(dCanResendOtp: value));
  }

  /// To resend the otp
  void resendOtp() async {}

  /// To show the successful otp modal bottom sheet
  Future showSuccessDialog() async {
    emit(state.copyWith(dShowSuccessDialog: true));
  }
}
