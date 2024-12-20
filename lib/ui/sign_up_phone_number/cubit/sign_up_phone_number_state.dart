part of 'sign_up_phone_number_cubit.dart';

/*
 Represents the state for signing up with a phone number.

 Contains:
 - The selected OTP option (e.g., SMS or WhatsApp).
 - The selected country code.
 - The entered phone number.
  @author: Chidera Chijama
*/

enum SignUpWithPhoneStatus {
  initial,
  loading,
  success,
  failure,
}

class SignUpWithPhoneNumberState extends Equatable {
  /// The selected OTP option for receiving the code.
  final String fSelectedOtpOption;

  /// The selected country code model.
  final CountryModel fSelectedCountryCode;

  /// The entered phone number.
  final String fPhoneNumber;

  /// The API request status
  final SignUpWithPhoneStatus status;

  /// The request error message
  final String? errorMessage;

  /// The request response data
  final GenericResponse? data;

  /// Constructor to initialize all state fields.
  const SignUpWithPhoneNumberState({
    required this.fSelectedOtpOption,
    required this.fSelectedCountryCode,
    required this.fPhoneNumber,
    this.data,
    this.errorMessage,
    this.status = SignUpWithPhoneStatus.initial,
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
  SignUpWithPhoneNumberState copyWith({
    String? fSelectedOtpOption,
    CountryModel? fSelectedCountryCode,
    String? fPhoneNumber,
    GenericResponse? data,
    String? errorMessage,
    SignUpWithPhoneStatus? status,
  }) {
    return SignUpWithPhoneNumberState(
      data: data ?? this.data,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      fSelectedOtpOption: fSelectedOtpOption ?? this.fSelectedOtpOption,
      fSelectedCountryCode: fSelectedCountryCode ?? this.fSelectedCountryCode,
      fPhoneNumber: fPhoneNumber ?? this.fPhoneNumber,
    );
  }
}
