part of 'logout_cubit.dart';

enum LogoutStatus {
  initial,
  loading,
  failure,
  success,
}

class LogoutState extends Equatable {
  final String? errorMessage;
  final GenericResponse? data;
  final LogoutStatus status;

  const LogoutState({
    this.status = LogoutStatus.initial,
    this.data,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage, data, status];

  LogoutState copyWith({
    String? errorMessage,
    GenericResponse? data,
    LogoutStatus? status,
  }) {
    return LogoutState(
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
      status: status ?? this.status,
    );
  }
}
