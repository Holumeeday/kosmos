import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/constants/countries_list.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/data_transfer_objects/playkosmos_exception.dart';
import 'package:playkosmos_v3/enums/phone_otp_method_enum.dart';
import 'package:playkosmos_v3/models/country_model.dart';
import 'package:playkosmos_v3/models/generic_respose_model.dart';

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
  /// The authentication repository
  final AuthRemoteApiRepository fAuthRepository;

  /// Initializes the cubit with default state.
  SignUpWithPhoneNumberCubit({
    required this.fAuthRepository,
  }) : super(SignUpWithPhoneNumberState(
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

  /// Sign up with phone
  void signUpPhone() async {
    emit(state.copyWith(status: SignUpWithPhoneStatus.loading));
    try {
      final fResponse =
          await fAuthRepository.signUpPhone(phone: getFullPhoneNumber());
      // Emit the state if response status is failed or success with the error message
      // if available
      if (fResponse.status == true) {
        emit(
          state.copyWith(
            status: SignUpWithPhoneStatus.success,
            data: fResponse,
          ),
        );
      } else {
        addError(fResponse.status);
        emit(
          state.copyWith(
            status: SignUpWithPhoneStatus.failure,
            data: fResponse,
            errorMessage: fResponse.message,
          ),
        );
      }
    } on PlaykosmosException catch (e) {
      addError(e);
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: SignUpWithPhoneStatus.failure,
        ),
      );
    }
  }
}
