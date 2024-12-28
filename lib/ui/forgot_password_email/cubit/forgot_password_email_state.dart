part of 'forgot_password_email_cubit.dart';

enum ForgotPasswordEmailStatus {
  initial,
  loading,
  failure,
  success,
}

class ForgotPasswordEmailState extends Equatable {
  final String? errorMessage;
  final GenericResponse? data;
  final ForgotPasswordEmailStatus status;

  const ForgotPasswordEmailState({
    this.status = ForgotPasswordEmailStatus.initial,
    this.data,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage, data, status];

  ForgotPasswordEmailState copyWith({
    String? errorMessage,
    GenericResponse? data,
    ForgotPasswordEmailStatus? status,
  }) {
    return ForgotPasswordEmailState(
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
      status: status ?? this.status,
    );
  }
}
