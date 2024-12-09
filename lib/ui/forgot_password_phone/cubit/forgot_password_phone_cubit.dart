import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/enums/enums.dart';

part 'forgot_password_phone_state.dart';

class ForgotPasswordPhoneCubit extends Cubit<ForgotPasswordPhoneState> {
  ForgotPasswordPhoneCubit()
      : super(
          const ForgotPasswordPhoneState(
            fOtpMethod: PhoneOtpMethodEnum.whatsapp,
          ),
        );

  void changeOtpMethod(PhoneOtpMethodEnum fOtpMethod) {
    emit(state.copyWith(fOtpMethod: fOtpMethod));
  }
}
