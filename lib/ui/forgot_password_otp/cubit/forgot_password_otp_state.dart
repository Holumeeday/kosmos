part of 'forgot_password_otp_cubit.dart';

enum ForgotPasswordOtpVerificationStatus {
  initial,
  loading,
  failure,
  success,
}

enum ForgotPasswordResendOtpVerificationStatus {
  initial,
  loading,
  failure,
  success,
}

class ForgotPasswordOtpVerificationState extends Equatable {
  final String? errorMessage;
  final ForgotPasswordOtpVerificationStatus status;
  final ForgotPasswordResendOtpVerificationStatus resendOtpStatus;
  final GenericResponse? data;
  final String? otp;

  const ForgotPasswordOtpVerificationState({
    this.otp,
    this.resendOtpStatus = ForgotPasswordResendOtpVerificationStatus.initial,
    this.errorMessage,
    this.status = ForgotPasswordOtpVerificationStatus.initial,
    this.data,
  });

  @override
  List<Object?> get props => [
        errorMessage,
        status,
        data,
        otp,
        resendOtpStatus,
      ];

  ForgotPasswordOtpVerificationState copyWith({
    String? errorMessage,
    ForgotPasswordOtpVerificationStatus? status,
    GenericResponse? data,
    String? otp,
    ForgotPasswordResendOtpVerificationStatus? resendOtpStatus,
  }) {
    return ForgotPasswordOtpVerificationState(
      resendOtpStatus: resendOtpStatus ?? this.resendOtpStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      data: data ?? this.data,
      otp: otp ?? this.otp,
    );
  }
}
