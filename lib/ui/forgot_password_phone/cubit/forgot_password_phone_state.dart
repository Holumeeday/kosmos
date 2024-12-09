part of 'forgot_password_phone_cubit.dart';

class ForgotPasswordPhoneState extends Equatable {
  /// The otp sending method
  final PhoneOtpMethodEnum fOtpMethod;

  const ForgotPasswordPhoneState({
    required this.fOtpMethod,
  });

  @override
  List<Object> get props => [fOtpMethod];

  ForgotPasswordPhoneState copyWith({
    PhoneOtpMethodEnum? fOtpMethod,
  }) {
    return ForgotPasswordPhoneState(
      fOtpMethod: fOtpMethod ?? this.fOtpMethod,
    );
  }
}
