import 'package:flutter/foundation.dart';
import 'package:playkosmos_v3/constants/constants.dart';
import 'package:playkosmos_v3/models/auth_model.dart';
import 'package:playkosmos_v3/services/services.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/*
A service that aids in the redirection and checks for authentication
@author: Godwin Mathias
 */
class AuthStorageService {
  /// Access the App preference service
  final AppPreferenceService _fAppPreference = locator<AppPreferenceService>();

  /// React to changes in initialized, onboarding and login
  ValueListenable get listenable =>
      _fAppPreference.reactToKeys([kAuthStorageKey]);

  /// The auth model
  AuthModel get fAuthModel =>
      AuthModel.fromJson(_fAppPreference.getValue(kAuthStorageKey));

  /// To update the storage
  void _updateAuthStorage(Map<String, dynamic> json) {
    _fAppPreference.setValue(kAuthStorageKey, json);
  }

  /// A convenient setter to set the initialization state
  void setInitialized([bool value = true]) {
    final jsonModel = fAuthModel.copyWith(isInitialized: value).toJson();
    _updateAuthStorage(jsonModel);
  }

  /// A convenient setter to update the onboarding state
  void setOnboarding([bool value = true]) {
    final jsonModel = fAuthModel.copyWith(isOnboarded: value).toJson();
    _updateAuthStorage(jsonModel);
  }

  /// A convenient setter to set the create account state
  void setCreateAccount([bool value = true]) {
    final jsonModel = fAuthModel.copyWith(isLoggedIn: value).toJson();
    _updateAuthStorage(jsonModel);
  }

  /// A convenient setter to set the logged in state
  void setLogIn() {
    final jsonModel = fAuthModel
        .copyWith(
          isLoggedIn: true,
          hasCompletedStep2: true,
          isVerified: true,
        )
        .toJson();
    _updateAuthStorage(jsonModel);
  }

  /// A setter to set that the user has verified
  void setVerified([bool value = true]) {
    final jsonModel = fAuthModel.copyWith(isVerified: value).toJson();
    _updateAuthStorage(jsonModel);
  }

  /// A setter to set that the user has completed the step 2 process
  void setHasCompletedStep2([bool value = true]) {
    final jsonModel = fAuthModel.copyWith(hasCompletedStep2: true).toJson();
    _updateAuthStorage(jsonModel);
  }

  /// A convenient setter for the logging out
  void logOut() {
    final jsonModel = fAuthModel
        .copyWith(
          isLoggedIn: false,
          isVerified: false,
          hasCompletedStep2: false,
        )
        .toJson();
    _updateAuthStorage(jsonModel);
  }
}
