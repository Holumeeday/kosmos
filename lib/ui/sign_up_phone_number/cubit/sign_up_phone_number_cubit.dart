import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/constants/countries_list.dart';
import 'package:playkosmos_v3/enums/phone_otp_method_enum.dart';
import 'package:playkosmos_v3/models/country_model.dart';

part 'sign_up_phone_number_state.dart';

/* Manages the state for signing up with a phone number.
 This includes:
 - OTP option selection (SMS or WhatsApp).
 - Country code selection.
 - Phone number input.
 - Combines country code and phone number into a full phone number.
 
 @author: Chidera Chijama
*/
class SignUpWithPhoneNumberCubit extends Cubit<SignUpWithPhoneNumberState> {
  /// The list of OTP options (SMS and WhatsApp).

  /// Initializes the cubit with default state.
  SignUpWithPhoneNumberCubit()
      : super(SignUpWithPhoneNumberState(
          fSelectedOtpOption: PhoneOtpMethodEnum.sms.name,
          fSelectedCountryCode:
              kCountriesList.where((x) => x.name == 'Finland').single,
          fPhoneNumber: '',
        ));

  /// Updates the selected OTP option.
  void setOtpOption(String option) {
    final selectedOption = PhoneOtpMethodEnum.values
        .firstWhere(
          (element) => element.name.toLowerCase() == option.toLowerCase(),
        )
        .name;
    emit(state.copyWith(fSelectedOtpOption: selectedOption));
  }

  /// Updates the selected country code.
  void setCountryCode(CountryModel code) {
    emit(state.copyWith(fSelectedCountryCode: code));
  }

  /// Updates the entered phone number.
  void setPhoneNumber(String number) {
    emit(state.copyWith(fPhoneNumber: number));
  }

  /// Combines the selected country code and phone number into a full phone number.
  String getFullPhoneNumber() {
    return '${state.fSelectedCountryCode.phoneCode}${state.fPhoneNumber}';
  }
}
