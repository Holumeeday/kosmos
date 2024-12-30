part of 'create_password_cubit.dart';

enum CreatePasswordStatus {
  initial,
  loading,
  failure,
  success,
}

class CreatePasswordState extends Equatable {
  final String? errorMessage;
  final GenericResponse? data;
  final CreatePasswordStatus status;

  const CreatePasswordState({
    this.status = CreatePasswordStatus.initial,
    this.data,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage, data, status];

  CreatePasswordState copyWith({
    String? errorMessage,
    GenericResponse? data,
    CreatePasswordStatus? status,
  }) {
    return CreatePasswordState(
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
      status: status ?? this.status,
    );
  }
}
