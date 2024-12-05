part of 'email_otp_verification_cubit.dart';

class EmailOtpVerificationState extends Equatable {
  /// if user can resend otp
  final bool dCanResendOtp;

  const EmailOtpVerificationState({
    required this.dCanResendOtp,
  });

  @override
  List<Object> get props => [dCanResendOtp];

  EmailOtpVerificationState copyWith({
    bool? dCanResendOtp,
  }) {
    return EmailOtpVerificationState(
      dCanResendOtp: dCanResendOtp ?? this.dCanResendOtp,
    );
  }
}
