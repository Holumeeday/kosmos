import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/constants/constants.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/data_transfer_objects/playkosmos_exception.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/models/country_model.dart';
import 'package:playkosmos_v3/models/generic_respose_model.dart';

part 'forgot_password_phone_state.dart';

class ForgotPasswordPhoneCubit extends Cubit<ForgotPasswordPhoneState> {
  /// The authentication api repository
  final AuthRemoteApiRepository fAuthRepository;

  ForgotPasswordPhoneCubit({
    required this.fAuthRepository,
  }) : super(
          ForgotPasswordPhoneState(
            fSelectedCountryCode:
                kCountriesList.where((x) => x.name == 'Finland').single,
            fPhoneNumber: '',
          ),
        );

  void changeOtpMethod(PhoneOtpMethodEnum fOtpMethod) {
    emit(state.copyWith(fSelectedOtpOption: fOtpMethod));
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

  /// Forgot password with phone
  void forgotPasswordPhone() async {
    emit(state.copyWith(status: ForgotPasswordPhoneStatus.loading));
    try {
      final fResponse = await fAuthRepository.forgotPasswordPhone(
          phone: getFullPhoneNumber());
      // Emit the state if response status is failed or success with the error message
      // if available
      if (fResponse.status == true) {
        emit(
          state.copyWith(
            status: ForgotPasswordPhoneStatus.success,
            data: fResponse,
          ),
        );
      } else {
        addError(fResponse.status);
        emit(
          state.copyWith(
            status: ForgotPasswordPhoneStatus.failure,
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
          status: ForgotPasswordPhoneStatus.failure,
        ),
      );
    }
  }
}
