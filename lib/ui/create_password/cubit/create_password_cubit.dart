import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/data_transfer_objects/playkosmos_exception.dart';
import 'package:playkosmos_v3/models/generic_respose_model.dart';

part 'create_password_state.dart';

class CreatePasswordCubit extends Cubit<CreatePasswordState> {
  /// The authentication api repository
  final AuthRemoteApiRepository fAuthRepository;

  CreatePasswordCubit({
    required this.fAuthRepository,
  }) : super(const CreatePasswordState());

  /// Create new password email or phone
  void createPassword({
    String? email,
    String? phone,
    required String password,
  }) async {
    emit(state.copyWith(status: CreatePasswordStatus.loading));
    try {
      final fResponse = await fAuthRepository.createPassword(
        email: email,
        password: password,
        phone: phone,
      );

      // Emit the state if response status is failed or success with the error message
      // if available
      if (fResponse.status == true) {
        emit(
          state.copyWith(
            status: CreatePasswordStatus.success,
            data: fResponse,
          ),
        );
      } else {
        addError(fResponse.status);
        emit(
          state.copyWith(
            status: CreatePasswordStatus.failure,
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
          status: CreatePasswordStatus.failure,
        ),
      );
    }
  }
}
