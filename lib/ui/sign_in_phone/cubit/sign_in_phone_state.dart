part of 'sign_in_phone_cubit.dart';

enum SignInPhoneStatus {
  initial,
  loading,
  success,
  failure,
}

class SignInPhoneState extends Equatable {
  /// The selected country code model.
  final CountryModel fSelectedCountryCode;

  /// The entered phone number.
  final String fPhoneNumber;

  /// The API request status
  final SignInPhoneStatus status;

  /// The request error message
  final String? errorMessage;

  /// The request response data
  final GenericResponse? data;

  /// The user data
  final UserModel? user;

  /// Constructor to initialize all state fields.
  const SignInPhoneState({
    required this.fSelectedCountryCode,
    required this.fPhoneNumber,
    this.data,
    this.errorMessage,
    this.status = SignInPhoneStatus.initial,
    this.user,
  });

  @override
  List<Object?> get props => [
        fSelectedCountryCode,
        fPhoneNumber,
        data,
        user,
        status,
        errorMessage,
      ];

  /// Creates a new state with updated values while keeping others unchanged.
  SignInPhoneState copyWith({
    CountryModel? fSelectedCountryCode,
    String? fPhoneNumber,
    GenericResponse? data,
    String? errorMessage,
    SignInPhoneStatus? status,
    UserModel? user,
  }) {
    return SignInPhoneState(
      user: user ?? this.user,
      data: data ?? this.data,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      fSelectedCountryCode: fSelectedCountryCode ?? this.fSelectedCountryCode,
      fPhoneNumber: fPhoneNumber ?? this.fPhoneNumber,
    );
  }
}
