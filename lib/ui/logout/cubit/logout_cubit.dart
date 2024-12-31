import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/data_transfer_objects/playkosmos_exception.dart';
import 'package:playkosmos_v3/models/generic_respose_model.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  /// The authentication api repository
  final AuthRemoteApiRepository fAuthRepository;

  LogoutCubit({
    required this.fAuthRepository,
  }) : super(const LogoutState());

  /// Logout
  void logout() async {
    emit(state.copyWith(status: LogoutStatus.loading));
    try {
      final fResponse = await fAuthRepository.logout();
      // Emit the state if response status is failed or success with the error message
      // if available
      if (fResponse.status == true) {
        emit(
          state.copyWith(
            status: LogoutStatus.success,
            data: fResponse,
          ),
        );
      } else {
        addError(fResponse.status);
        emit(
          state.copyWith(
            status: LogoutStatus.failure,
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
          status: LogoutStatus.failure,
        ),
      );
    }
  }
}
