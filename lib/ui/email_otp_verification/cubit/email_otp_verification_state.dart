part of 'email_otp_verification_cubit.dart';

class EmailOtpVerificationState extends Equatable {
  /// if user can resend otp
  final bool dCanResendOtp;

  /// Show success dialog
  final bool dShowSuccessDialog;

  const EmailOtpVerificationState({
    required this.dCanResendOtp,
    required this.dShowSuccessDialog,
  });

  @override
  List<Object> get props => [dCanResendOtp, dShowSuccessDialog];

  EmailOtpVerificationState copyWith({
    bool? dCanResendOtp,
    bool? dShowSuccessDialog,
  }) {
    return EmailOtpVerificationState(
      dCanResendOtp: dCanResendOtp ?? this.dCanResendOtp,
      dShowSuccessDialog: dShowSuccessDialog ?? this.dShowSuccessDialog,
    );
  }
}
