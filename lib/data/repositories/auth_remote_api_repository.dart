import 'dart:io';

import 'package:playkosmos_v3/data/data_source/interfaces/remote_api.dart';
import 'package:playkosmos_v3/data_transfer_objects/playkosmos_exception.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/models/activity_interest_groups.dart';
import 'package:playkosmos_v3/models/generic_respose_model.dart';
import 'package:playkosmos_v3/models/location_model.dart';

/// The authentication flow repository for nodejs/Java backend
///
/// @author: Godwin Mathias
class AuthRemoteApiRepository {
  /// The remote api to be used nodejs/java
  final RemoteApi _remoteApi;

  const AuthRemoteApiRepository({
    required RemoteApi remoteApi,
  }) : _remoteApi = remoteApi;

  //Genericmethod to handle API calls
  Future<GenericResponse> _apiCall(String method, String url,
      {Map<String, dynamic>? body}) async {
    try {
      final response = method == 'POST'
          ? await _remoteApi.post(url, body: body)
          : await _remoteApi.put(url, body: body);
      return GenericResponse.fromJson(response.data as Map<String, dynamic>);
    } catch (_) {
      rethrow;
    }
  }

  /// POST API helper
  Future<GenericResponse> _post(String url, {Map<String, dynamic>? body}) =>
      _apiCall('POST', url, body: body);

  /// PUT API helper
  Future<GenericResponse> _put(String url, {Map<String, dynamic>? body}) =>
      _apiCall('PUT', url, body: body);

  /// Register with email

  Future<GenericResponse> signUpEmail({
    required String email}) =>  _post('auth/register/email', body: {'email': email});

  /// Register with phone
  Future<GenericResponse> signUpPhone({required String phone,}) =>  
  _post('auth/register/phone', body: {'phone': phone}); 

  /// Verify email using OTP
  Future<GenericResponse> verifyEmailOtp({
    required String email,
    required int otp,
  }) =>
      _post('auth/register/email/verify', body: {
        'email': email,
        'otp': otp,
      });

  /// Verify phone using OTP
  Future<GenericResponse> verifyPhoneOtp({
    required String phone,
    required int otp,
  }) =>
      _post('auth/register/phone/verify', body: {
        'phone': phone,
        'otp': otp,
      });

  /// Create password for both email/phone sign up
  Future<GenericResponse> createPassword({
  String? phone,
  String? email,
  required String password,
  }) =>
      _post('auth/register/set-password', body: {
        if (phone != null && phone.isNotEmpty) 'phone': phone,
        if (email != null && email.isNotEmpty) 'email': email,
        'password': password,
      });


  /// Request forgot password otp
  Future<GenericResponse> forgotPasswordEmail({
    required String email,}) => _post('auth/forgot-password/email', body: {'email': email});


  /// Request forgot password otp for phone
  Future<GenericResponse> forgotPasswordPhone({
    required String phone,}) =>  _post('auth/forgot-password/phone', body: {'phone': phone});

  /// Forgot password email verification
  Future<GenericResponse> verifyForgotPasswordEmail({
    required String otp,
    required String email,
  }) =>
      _post('auth/forgot-password/email/verify', body: {
        'email': email,
        'otp': otp,
      });


  /// Forgot password phone verification
  Future<GenericResponse> verifyForgotPasswordPhone({
    required String otp,
    required String phone,
  }) =>
      _post('auth/forgot-password/phone/verify', body: {
        'phone': phone,
        'otp': otp,
      });

  /// Resend OTP for email
  Future<GenericResponse> resendOtpEmail({
    required String email,
  }) =>
      _post('auth/register/email/resend-otp', body: {'email': email});

  /// Resend OTP for phone
  Future<GenericResponse> resendOtpPhone({
    required String phone,
  })  =>
      _post('auth/register/phone/resend-otp', body: {'phone': phone});

  /// Resend OTP for forgot password email
  Future<GenericResponse> resendOtpForgotPasswordEmail({
    required String email,
  })  =>
      _post('auth/forgot-password/email/resend-otp', body: {'email': email});

  /// Resend OTP for forgot password phone
  Future<GenericResponse> resendOtpForgotPasswordPhone({
    required String phone,
  }) =>
      _post('auth/forgot-password/phone/resend-otp', body: {'phone': phone});
      

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

  /// Verify otp for forgot password phone
  Future<GenericResponse> verifyOtpForgotPasswordPhone({
    required String otp,
    required String phone,
  }) async {
    try {
      final res = await _remoteApi.post(
        'auth/forgot-password/phone/verify',
        body: {
          'phone': phone,
          'otp': otp,
        },
      );
      return GenericResponse.fromJson(res.data as Map<String, dynamic>);
    } catch (_) {
      rethrow;
    }
  }

/// Reset password email/phone
  Future<GenericResponse> resetPassword({
    String? email,
    String? phone,
    required String password,
  }) =>
      _post('auth/forgot-password/change-password', body: {
        if (email != null) 'email': email,
        if (phone != null) 'phone': phone,
        'password': password,
      });


  // /// Reset password phone
  // Future<GenericResponse> resetPasswordPhone({
  //   required String phone,
  //   required String password,
  // }) async {
  //   try {
  //     final res = await _remoteApi.post(
  //       'auth/forgot-password/change-password',
  //       body: {
  //         'phone': phone,
  //         'password': password,
  //       },
  //     );
  //     return GenericResponse.fromJson(res.data as Map<String, dynamic>);
  //   } catch (_) {
  //     rethrow;
  //   }
  // }

  /// Login with email
  Future<GenericResponse> loginWithEmail({
    required String email,
    required String password,
  }) =>
      _post('auth/login', body: {
        'email': email,
        'password': password,
      });


   /// Login with phone
  Future<GenericResponse> loginWithPhone({
    required String phone,
    required String password,
  }) =>
      _post('auth/login', body: {
        'phone': phone,
        'password': password,
      });

  /// -----------  Profile creation flow ------------

  /// Create profile name and bio
  Future<GenericResponse> setUsernameBio({
    required String fullName,
    String? bio,
  }) =>
      _post('user/profile/update/name', body: {
        'fullName': fullName,
        if (bio != null) 'bio': bio,
      });


  /// Update profile second step
  Future<GenericResponse> setOnboarding({
    String? fullName,
    double? searchRadius,
    String? birthday,
    List<String>? pictures,
    GenderEnum? gender,
    ActivityInterestGroupsList? interests,
    Locations? location,
  }) =>
      _post('user/onboarding', body: {
        if (fullName != null) 'fullName': fullName,
        if (searchRadius != null) 'searchRadius': searchRadius.round(),
        if (birthday != null) 'birthday': birthday,
        if (pictures != null) 'pictures': pictures,
        if (gender != null) 'gender': gender.backendName,
        if (interests != null) 'interests': interests.toJson(),
        if (location != null) 'locations': location.toMap(),
      });


  /// Update search radius
  Future<GenericResponse> updateSearchRadius(int searchRadius) =>
      _post('user/profile/update/search-radius', body: {
        'searchRadius': searchRadius,
      });

  /// Update birthday
  Future<GenericResponse> updateBirthday(String birthday) =>
      _post('user/profile/update/birthday', body: {'birthday': birthday});

  /// Update pictures
  Future<GenericResponse> updatePictures(List<String> pictures) =>
      _post('user/profile/update/pictures', body: {'pictures': pictures});

  /// Update gender
  Future<GenericResponse> updateGender(GenderEnum gender) =>
      _post('user/profile/update/gender', body: {
        'gender': gender.name,
      });

  /// Update interests
  Future<GenericResponse> updateInterests(
          List<ActivityInterestGroups> interests) =>
      _post('user/profile/interests', body: {
        'interests':
            interests.map((e) => {e.categoryName: e.interests}).toList(),
      });


  /// Update location
   Future<GenericResponse> updateLocation(Locations location) =>
      _post('user/profile/update/location', body: {
        'location': location.toMap(),
      });

  /// Upload multiple image files
  Future<GenericResponse> uploadImagesWithFiles({
    required List<File> images,
  }) async {
    try {
      // Get file upload url
      final fUrlRes = await getOnboardingImageUrls(totalImages: images.length);
      if (fUrlRes.status) {
        final fPayload = fUrlRes.data['url']['fields'];

        // Prepare the multipart form data
        final formData = FormData.fromMap({
          ...fPayload,
          "file": images
              .map(((image) => MultipartFile.fromFileSync(image.path,
                  filename: image.path.split('/').last)))
              .toList(),
        });
        final res = await _remoteApi.put(
          'file/upload-url',
          body: formData,
        );

        return GenericResponse.fromJson(res.data as Map<String, dynamic>);
      } else {
        throw PlaykosmosException(error: ErrorEnum.responseError);
      }
    } catch (_) {
      rethrow;
    }
  }

  /// Upload a single image
Future<void> uploadImagesWithFile({
    required File image,
    required String uploadPath,
  }) async {
    // Prepare the multipart form data
    final formData = FormData.fromMap({
      "file": MultipartFile.fromFile(image.path,
          filename: image.path.split('/').last),
    });

    try {
      // ignore: unused_local_variable
      final res = await _remoteApi.put(
        uploadPath,
        body: formData,
      );
    } catch (_) {
      rethrow;
    }
  }
  /// Get image upload urls
  
  Future<GenericResponse> getOnboardingImageUrls({required int totalImages}) =>
      _post('file/get-upload-urls', body: {
        "totalImages": totalImages,
      });


  /// Logout of the app
Future<GenericResponse> logout()
 => _post('auth/logout');
}


