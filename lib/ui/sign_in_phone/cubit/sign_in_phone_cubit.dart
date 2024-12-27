import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/constants/constants.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/data_transfer_objects/playkosmos_exception.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/models/country_model.dart';
import 'package:playkosmos_v3/models/generic_respose_model.dart';
import 'package:playkosmos_v3/models/user_model.dart';

part 'sign_in_phone_state.dart';

class SignInPhoneCubit extends Cubit<SignInPhoneState> {
  /// The authentication repository
  final AuthRemoteApiRepository fAuthRepository;

  /// The user profile storage
  final UserProfileStorage fUserStorage;

  SignInPhoneCubit({
    required this.fAuthRepository,
    required this.fUserStorage,
  }) : super(
          SignInPhoneState(
            fSelectedCountryCode:
                kCountriesList.where((x) => x.name == 'Finland').single,
            fPhoneNumber: '',
          ),
        );

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
    return '${state.fSelectedCountryCode.phoneCodeAndPlus}${state.fPhoneNumber.truncateLeadingZero()}';
  }

  /// Sign in with phone
  void signInPhone({
    required String password,
  }) async {
    emit(state.copyWith(status: SignInPhoneStatus.loading));
    try {
      final fResponse = await fAuthRepository.loginWithPhone(
        password: password,
        phone: getFullPhoneNumber(),
      );
      // Emit the state if response status is failed or success with the error message
      // if available
      if (fResponse.status == true) {
        final user = UserModel.fromMapRemote(fResponse.data);
        // Save the user data
        fUserStorage.setUser(user);
        emit(
          state.copyWith(
            status: SignInPhoneStatus.success,
            data: fResponse,
            user: user,
          ),
        );
      } else {
        addError(fResponse.status);
        emit(
          state.copyWith(
            status: SignInPhoneStatus.failure,
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
          status: SignInPhoneStatus.failure,
        ),
      );
    }
  }
}
