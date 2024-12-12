part of 'phone_number_otp_verification_cubit.dart';

class PhoneNumberOtpVerificationState extends Equatable {
  /// if user can resend otp
  final bool dCanResendOtp;

  /// Show success dialog
  final bool dShowSuccessDialog;

  const PhoneNumberOtpVerificationState({
    required this.dCanResendOtp,
    required this.dShowSuccessDialog,
  });

  @override
  List<Object> get props => [dCanResendOtp, dShowSuccessDialog];

  PhoneNumberOtpVerificationState copyWith({
    bool? dCanResendOtp,
    bool? dShowSuccessDialog,
  }) {
    return PhoneNumberOtpVerificationState(
      dCanResendOtp: dCanResendOtp ?? this.dCanResendOtp,
      dShowSuccessDialog: dShowSuccessDialog ?? this.dShowSuccessDialog,
    );
  }
}
