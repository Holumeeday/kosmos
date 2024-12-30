part of 'sign_up_with_email_cubit.dart';

enum SignUpWithEmailStatus {
  initial,
  loading,
  failure,
  success,
}

class SignUpWithEmailState extends Equatable {
  final String? errorMessage;
  final GenericResponse? data;
  final SignUpWithEmailStatus status;

  const SignUpWithEmailState({
    this.status = SignUpWithEmailStatus.initial,
    this.data,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage, data, status];

  SignUpWithEmailState copyWith({
    String? errorMessage,
    GenericResponse? data,
    SignUpWithEmailStatus? status,
  }) {
    return SignUpWithEmailState(
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
      status: status ?? this.status,
    );
  }
}
