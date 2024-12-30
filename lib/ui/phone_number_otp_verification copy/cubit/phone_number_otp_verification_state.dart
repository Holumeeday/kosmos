part of 'phone_number_otp_verification_cubit.dart';

enum PhoneNumberOtpVerificationStatus {
  initial,
  loading,
  failure,
  success,
}

enum PhoneNumberResendOtpVerificationStatus {
  initial,
  loading,
  failure,
  success,
}

class PhoneNumberOtpVerificationState extends Equatable {
  final String? errorMessage;
  final PhoneNumberOtpVerificationStatus status;
  final PhoneNumberResendOtpVerificationStatus resendOtpStatus;
  final GenericResponse? data;
  final String? otp;
  final bool dCanResendOtp;

  const PhoneNumberOtpVerificationState({
    this.otp,
    this.dCanResendOtp = false,
    this.resendOtpStatus = PhoneNumberResendOtpVerificationStatus.initial,
    this.errorMessage,
    this.status = PhoneNumberOtpVerificationStatus.initial,
    this.data,
  });

  @override
  List<Object?> get props => [
        errorMessage,
        status,
        data,
        otp,
        dCanResendOtp,
        resendOtpStatus,
      ];

  PhoneNumberOtpVerificationState copyWith({
    String? errorMessage,
    PhoneNumberOtpVerificationStatus? status,
    GenericResponse? data,
    bool? dCanResendOtp,
    String? otp,
    PhoneNumberResendOtpVerificationStatus? resendOtpStatus,
  }) {
    return PhoneNumberOtpVerificationState(
      resendOtpStatus: resendOtpStatus ?? this.resendOtpStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      data: data ?? this.data,
      dCanResendOtp: dCanResendOtp ?? this.dCanResendOtp,
      otp: otp ?? this.otp,
    );
  }
}
