part of 'forgot_password_otp_cubit.dart';

class ForgotPasswordOtpVerificationState extends Equatable {
  /// if user can resend otp
  final bool dCanResendOtp;

  /// Show success dialog
  final bool dShowSuccessDialog;

  const ForgotPasswordOtpVerificationState({
    required this.dCanResendOtp,
    required this.dShowSuccessDialog,
  });

  @override
  List<Object> get props => [dCanResendOtp, dShowSuccessDialog];

  ForgotPasswordOtpVerificationState copyWith({
    bool? dCanResendOtp,
    bool? dShowSuccessDialog,
  }) {
    return ForgotPasswordOtpVerificationState(
      dCanResendOtp: dCanResendOtp ?? this.dCanResendOtp,
      dShowSuccessDialog: dShowSuccessDialog ?? this.dShowSuccessDialog,
    );
  }
}
