import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/constants/countries_states/countries_states_constant.dart';
import 'package:playkosmos_v3/models/countries_states_model.dart';

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
  final List<String> otpOptions = ['sms', 'whatsapp'];

  /// Initializes the cubit with default state.
  SignUpWithPhoneNumberCubit()
      : super(SignUpWithPhoneNumberState(
          fSelectedOtpOption: 'sms',
          fSelectedCountryCode:
              kCountriesStatesList.where((x) => x.name == 'Finland').single,
          fPhoneNumber: '',
        ));

  /// Updates the selected OTP option.
  void setOtpOption(String option) {
    if (otpOptions.contains(option)) {
      emit(state.copyWith(fSelectedOtpOption: option));
    }
  }

  /// Updates the selected country code.
  void setCountryCode(CountriesStatesModel code) {
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
