import 'package:playkosmos_v3/data/data_source/interfaces/remote_api.dart';
import 'package:playkosmos_v3/data_transfer_objects/activity_interest_groups.dart';
import 'package:playkosmos_v3/models/generic_respose_model.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/models/profile_creation_flow_model.dart';

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

  /// Request forgot password otp
  Future<GenericResponse> forgotPasswordEmail({
    required String email,
  }) async {
    try {
      final res = await _remoteApi.post(
        'auth/forgot-password/email',
        body: {'email': email},
      );
      return GenericResponse.fromJson(res.data as Map<String, dynamic>);
    } catch (_) {
      rethrow;
    }
  }

  /// Forgot password email verification
  Future<GenericResponse> verifyForgotPasswordEmail({
    required String otp,
    required String email,
  }) async {
    try {
      final res = await _remoteApi.post(
        'auth/forgot-password/verify',
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

  /// Resend OTP for forgot password email
  Future<GenericResponse> resendOtpForgotPasswordEmail({
    required String email,
  }) async {
    try {
      final res = await _remoteApi.post(
        'auth/forgot-password/email/resend-otp',
        body: {
          'email': email,
        },
      );
      return GenericResponse.fromJson(res.data as Map<String, dynamic>);
    } catch (_) {
      rethrow;
    }
  }

  /// Verify otp for forgot password email
  Future<GenericResponse> verifyOtpForgotPasswordEmail({
    required String otp,
    required String email,
  }) async {
    try {
      final res = await _remoteApi.post(
        'auth/forgot-password/email/verify',
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

  /// Reset password email
  Future<GenericResponse> resetPasswordEmail({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _remoteApi.post(
        'auth/forgot-password/change-password',
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

  /// Login with email
  Future<GenericResponse> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _remoteApi.post(
        'auth/login',
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

  /// -----------  Profile creation flow ------------

  /// Create profile name and bio
  Future<GenericResponse> setUsernameBio({
    required String fullName,
    String? bio,
  }) async {
    try {
      final res = await _remoteApi.post(
        'user/profile/update/name',
        body: {
          'fullName': fullName,
          if (bio != null) 'bio': bio,
        },
      );
      return GenericResponse.fromJson(res.data as Map<String, dynamic>);
    } catch (_) {
      rethrow;
    }
  }

  /// Update profile second step
  Future<GenericResponse> updateProfileSecondStep({
    int? searchRadius,
    String? birthday,
    List<String>? pictures,
    GenderEnum? gender,
    List<ActivityInterestGroups>? interests,
    Map<String, String>? location,
  }) async {
    try {
      final res = await _remoteApi.post(
        'user/profile/update',
        body: {
          if (searchRadius != null) 'searchRadius': searchRadius,
          if (birthday != null) 'birthday': birthday,
          if (pictures != null) 'pictures': pictures,
          if (interests != null)
            'interests': interests.map((e) => {e.categoryName: e.interests}),
          if (location != null) 'location': location,
        },
      );
      return GenericResponse.fromJson(res.data as Map<String, dynamic>);
    } catch (_) {
      rethrow;
    }
  }

  /// Update search radius
  Future<GenericResponse> updateSearchRadius(int searchRadius) async {
    try {
      final res = await _remoteApi.post(
        'user/profile/update/search-radius',
        body: {'searchRadius': searchRadius},
      );
      return GenericResponse.fromJson(res.data as Map<String, dynamic>);
    } catch (_) {
      rethrow;
    }
  }

  /// Update birthday
  Future<GenericResponse> updateBirthday(String birthday) async {
    try {
      final res = await _remoteApi.post(
        'user/profile/update/birthday',
        body: {'birthday': birthday},
      );
      return GenericResponse.fromJson(res.data as Map<String, dynamic>);
    } catch (_) {
      rethrow;
    }
  }

  /// Update pictures
  Future<GenericResponse> updatePictures(List<String> pictures) async {
    try {
      final res = await _remoteApi.post(
        'user/profile/update/pictures',
        body: {'pictures': pictures},
      );
      return GenericResponse.fromJson(res.data as Map<String, dynamic>);
    } catch (_) {
      rethrow;
    }
  }

  /// Update gender
  Future<GenericResponse> updateGender(GenderEnum gender) async {
    try {
      final res = await _remoteApi.post(
        'user/profile/update/gender',
        body: {'gender': gender.name},
      );
      return GenericResponse.fromJson(res.data as Map<String, dynamic>);
    } catch (_) {
      rethrow;
    }
  }

  /// Update interests
  Future<GenericResponse> updateInterests(
      List<ActivityInterestGroups> interests) async {
    try {
      final formattedInterests =
          interests.map((e) => {e.categoryName: e.interests}).toList();
      final res = await _remoteApi.post(
        'user/profile/interests',
        body: {'interests': formattedInterests},
      );
      return GenericResponse.fromJson(res.data as Map<String, dynamic>);
    } catch (_) {
      rethrow;
    }
  }

  /// Update location
  Future<GenericResponse> updateLocation(Map<String, String> location) async {
    try {
      final res = await _remoteApi.post(
        'user/profile/update/location',
        body: {'location': location},
      );
      return GenericResponse.fromJson(res.data as Map<String, dynamic>);
    } catch (_) {
      rethrow;
    }
  }
}
