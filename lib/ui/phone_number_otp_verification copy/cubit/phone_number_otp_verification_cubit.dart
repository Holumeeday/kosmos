import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/data_transfer_objects/playkosmos_exception.dart';
import 'package:playkosmos_v3/models/generic_respose_model.dart';

part 'phone_number_otp_verification_state.dart';

class PhoneNumberOtpVerificationCubit
    extends Cubit<PhoneNumberOtpVerificationState> {
  /// The authentication api repository
  final AuthRemoteApiRepository fAuthRepository;

  /// The user phone
  final String fPhone;

  PhoneNumberOtpVerificationCubit({
    required this.fPhone,
    required this.fAuthRepository,
  }) : super(
          const PhoneNumberOtpVerificationState(),
        );

  /// Setting the [dCanResendOtp] value
  void setResendingOtp(bool value) {
    emit(state.copyWith(dCanResendOtp: value));
  }

  /// Verify the otp
  void verifyOtp() async {
    if (state.otp == null) return;
    emit(state.copyWith(status: PhoneNumberOtpVerificationStatus.loading));
    try {
      final fResponse = await fAuthRepository.verifyPhoneOtp(
        phone: fPhone,
        otp: int.parse(state.otp!),
      );
      // Emit the state if response status is failed or success with the error message
      // if available
      if (fResponse.status == true) {
        emit(
          state.copyWith(
            status: PhoneNumberOtpVerificationStatus.success,
            data: fResponse,
          ),
        );
      } else {
        addError(fResponse.status);
        emit(
          state.copyWith(
            status: PhoneNumberOtpVerificationStatus.failure,
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
          status: PhoneNumberOtpVerificationStatus.failure,
        ),
      );
    }
  }

  /// Set otp value
  void setOtp({required String fOtp}) {
    emit(state.copyWith(otp: fOtp));
  }

  /// To resend the otp
  void resendOtp() async {
    emit(state.copyWith(
      resendOtpStatus: PhoneNumberResendOtpVerificationStatus.loading,
    ));
    try {
      final fResponse = await fAuthRepository.resendOtpPhone(
        phone: fPhone,
      );
      // Emit the state if response status is failed or success with the error message
      // if available
      if (fResponse.status == true) {
        emit(
          state.copyWith(
            resendOtpStatus: PhoneNumberResendOtpVerificationStatus.success,
            data: fResponse,
            dCanResendOtp: false,
          ),
        );
      } else {
        addError(fResponse.status);
        emit(
          state.copyWith(
            resendOtpStatus: PhoneNumberResendOtpVerificationStatus.failure,
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
          resendOtpStatus: PhoneNumberResendOtpVerificationStatus.failure,
        ),
      );
    }
  }
}
