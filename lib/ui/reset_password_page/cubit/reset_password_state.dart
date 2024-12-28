part of 'reset_password_cubit.dart';

enum ResetPasswordStatus {
  initial,
  loading,
  failure,
  success,
}

class ResetPasswordState extends Equatable {
  final String? errorMessage;
  final GenericResponse? data;
  final ResetPasswordStatus status;

  const ResetPasswordState({
    this.status = ResetPasswordStatus.initial,
    this.data,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage, data, status];

  ResetPasswordState copyWith({
    String? errorMessage,
    GenericResponse? data,
    ResetPasswordStatus? status,
  }) {
    return ResetPasswordState(
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
      status: status ?? this.status,
    );
  }
}
