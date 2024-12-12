part of 'sign_up_phone_number_cubit.dart';

/*
 Represents the state for signing up with a phone number.

 Contains:
 - The selected OTP option (e.g., SMS or WhatsApp).
 - The selected country code.
 - The entered phone number.
  @author: Chidera Chijama
*/
class SignUpWithPhoneNumberState extends Equatable {
  /// The selected OTP option for receiving the code.
  final String fSelectedOtpOption;

  /// The selected country code model.
  final CountryModel fSelectedCountryCode;

  /// The entered phone number.
  final String fPhoneNumber;

  /// Constructor to initialize all state fields.
  const SignUpWithPhoneNumberState({
    required this.fSelectedOtpOption,
    required this.fSelectedCountryCode,
    required this.fPhoneNumber,
  });

  @override
  List<Object> get props =>
      [fSelectedOtpOption, fSelectedCountryCode, fPhoneNumber];

  /// Creates a new state with updated values while keeping others unchanged.
  SignUpWithPhoneNumberState copyWith({
    String? fSelectedOtpOption,
    CountryModel? fSelectedCountryCode,
    String? fPhoneNumber,
  }) {
    return SignUpWithPhoneNumberState(
      fSelectedOtpOption: fSelectedOtpOption ?? this.fSelectedOtpOption,
      fSelectedCountryCode: fSelectedCountryCode ?? this.fSelectedCountryCode,
      fPhoneNumber: fPhoneNumber ?? this.fPhoneNumber,
    );
  }
}
