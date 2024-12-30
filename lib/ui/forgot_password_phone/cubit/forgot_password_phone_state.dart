part of 'forgot_password_phone_cubit.dart';

enum ForgotPasswordPhoneStatus {
  initial,
  loading,
  success,
  failure,
}

class ForgotPasswordPhoneState extends Equatable {
  /// The selected OTP option for receiving the code.
  final PhoneOtpMethodEnum fSelectedOtpOption;

  /// The selected country code model.
  final CountryModel fSelectedCountryCode;

  /// The entered phone number.
  final String fPhoneNumber;

  /// The API request status
  final ForgotPasswordPhoneStatus status;

  /// The request error message
  final String? errorMessage;

  /// The request response data
  final GenericResponse? data;

  /// Constructor to initialize all state fields.
  const ForgotPasswordPhoneState({
    this.fSelectedOtpOption = PhoneOtpMethodEnum.sms,
    required this.fSelectedCountryCode,
    required this.fPhoneNumber,
    this.data,
    this.errorMessage,
    this.status = ForgotPasswordPhoneStatus.initial,
  });

  @override
  List<Object?> get props => [
        fSelectedOtpOption,
        fSelectedCountryCode,
        fPhoneNumber,
        data,
        status,
        errorMessage,
      ];

  /// Creates a new state with updated values while keeping others unchanged.
  ForgotPasswordPhoneState copyWith({
    PhoneOtpMethodEnum? fSelectedOtpOption,
    CountryModel? fSelectedCountryCode,
    String? fPhoneNumber,
    GenericResponse? data,
    String? errorMessage,
    ForgotPasswordPhoneStatus? status,
  }) {
    return ForgotPasswordPhoneState(
      data: data ?? this.data,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      fSelectedOtpOption: fSelectedOtpOption ?? this.fSelectedOtpOption,
      fSelectedCountryCode: fSelectedCountryCode ?? this.fSelectedCountryCode,
      fPhoneNumber: fPhoneNumber ?? this.fPhoneNumber,
    );
  }
}
