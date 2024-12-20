import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/data_transfer_objects/playkosmos_exception.dart';
import 'package:playkosmos_v3/models/generic_respose_model.dart';
import 'package:playkosmos_v3/models/user_model.dart';

part 'sign_in_state.dart';

class SignInWithEmailCubit extends Cubit<SignInWithEmailState> {
  /// The authentication api repository
  final AuthRemoteApiRepository fAuthRepository;

  /// The user profile storage
  final UserProfileStorage fUserStorage;
  SignInWithEmailCubit({
    required this.fAuthRepository,
    required this.fUserStorage,
  }) : super(const SignInWithEmailState());

  /// Sign in with email
  void signInEmail({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: SignInWithEmailStatus.loading));
    try {
      final fResponse = await fAuthRepository.loginWithEmail(
        email: email,
        password: password,
      );
      // Emit the state if response status is failed or success with the error message
      // if available
      if (fResponse.status == true) {
        final user = UserModel.fromMap(fResponse.data);
        // Save the user data
        fUserStorage.setUser(user);

        emit(
          state.copyWith(
            status: SignInWithEmailStatus.success,
            data: fResponse,
          ),
        );
      } else {
        addError(fResponse.status);
        emit(
          state.copyWith(
            status: SignInWithEmailStatus.failure,
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
          status: SignInWithEmailStatus.failure,
        ),
      );
    }
  }
}
