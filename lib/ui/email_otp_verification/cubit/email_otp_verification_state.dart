part of 'email_otp_verification_cubit.dart';

enum EmailOtpVerificationStatus {
  initial,
  loading,
  failure,
  success,
}

enum EmailResendOtpVerificationStatus {
  initial,
  loading,
  failure,
  success,
}

class EmailOtpVerificationState extends Equatable {
  final String? errorMessage;
  final EmailOtpVerificationStatus status;
  final EmailResendOtpVerificationStatus resendOtpStatus;
  final GenericResponse? data;
  final String? otp;

  const EmailOtpVerificationState({
    this.otp,
    this.resendOtpStatus = EmailResendOtpVerificationStatus.initial,
    this.errorMessage,
    this.status = EmailOtpVerificationStatus.initial,
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

  EmailOtpVerificationState copyWith({
    String? errorMessage,
    EmailOtpVerificationStatus? status,
    GenericResponse? data,
    String? otp,
    EmailResendOtpVerificationStatus? resendOtpStatus,
  }) {
    return EmailOtpVerificationState(
      resendOtpStatus: resendOtpStatus ?? this.resendOtpStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      data: data ?? this.data,
      otp: otp ?? this.otp,
    );
  }
}
