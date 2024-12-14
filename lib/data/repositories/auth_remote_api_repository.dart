import 'package:playkosmos_v3/data/data_source/interfaces/remote_api.dart';
import 'package:playkosmos_v3/models/generic_respose_model.dart';

/// The authentication flow repository for nodejs/Java backend
///
/// @author: Godwin Mathias
class AuthRemoteApiRepository {
  /// The remote api to be used nodejs/java
  final RemoteApi _remoteApi;

  const AuthRemoteApiRepository({
    required RemoteApi remoteApi,
  }) : _remoteApi = remoteApi;

  /// Register with email
  Future<GenericResponse> signUpEmail({
    required String email,
  }) async {
    try {
      final res = await _remoteApi.post(
        'auth/register/email',
        body: {'email': email},
      );
      return GenericResponse.fromJson(res.data as Map<String, dynamic>);
    } catch (_) {
      rethrow;
    }
  }

  /// Verify email using OTP
  Future<GenericResponse> verifyEmailOtp({
    required String email,
    required int otp,
  }) async {
    try {
      final res = await _remoteApi.post(
        'auth/register/email/verify',
        body: {
          'email': email,
          'otp': otp,
        },
      );
      return GenericResponse.fromJson(res.data as Map<String, dynamic>);
    } catch (_) {
      rethrow;
    }
  }

  /// Create password for both email/phone sign up
  Future<GenericResponse> createPassword({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _remoteApi.post(
        'auth/register/set-password',
        body: {
          'email': email,
          'password': password,
        },
      );
      return GenericResponse.fromJson(res.data as Map<String, dynamic>);
    } catch (_) {
      rethrow;
    }
  }
}
