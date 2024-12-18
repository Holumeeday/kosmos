part of 'sign_in_cubit.dart';

enum SignInWithEmailStatus {
  initial,
  loading,
  failure,
  success,
}

class SignInWithEmailState extends Equatable {
  final String? errorMessage;
  final GenericResponse? data;
  final SignInWithEmailStatus status;

  const SignInWithEmailState({
    this.status = SignInWithEmailStatus.initial,
    this.data,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage, data, status];

  SignInWithEmailState copyWith({
    String? errorMessage,
    GenericResponse? data,
    SignInWithEmailStatus? status,
  }) {
    return SignInWithEmailState(
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
      status: status ?? this.status,
    );
  }
}
