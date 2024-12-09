import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'forgot_password_otp_state.dart';

class ForgotPasswordOtpVerificationCubit
    extends Cubit<ForgotPasswordOtpVerificationState> {
  ForgotPasswordOtpVerificationCubit()
      : super(
          const ForgotPasswordOtpVerificationState(
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
