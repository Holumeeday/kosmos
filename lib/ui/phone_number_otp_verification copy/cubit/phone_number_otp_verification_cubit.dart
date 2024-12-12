import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'phone_number_otp_verification_state.dart';

class PhoneNumberOtpVerificationCubit extends Cubit<PhoneNumberOtpVerificationState> {
  PhoneNumberOtpVerificationCubit()
      : super(
          const PhoneNumberOtpVerificationState(
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
