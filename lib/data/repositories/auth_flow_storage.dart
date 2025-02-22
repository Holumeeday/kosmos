import 'package:playkosmos_v3/constants/constants.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/models/auth_model.dart';
import 'package:playkosmos_v3/utils/cookies/cookie_storage.dart';

/// A service that manages authentication flow,
/// including initialization, onboarding, login, and verification states.
///
/// This service relies on a non-secure storage mechanism to persist
/// and react to authentication-related changes.
///
/// @author: Godwin Mathias
class AuthFlowStorage {
  /// Creates an instance of [AuthFlowStorage].
  ///
  /// Requires a [NonSecureStorage] instance for local storage operations.
  AuthFlowStorage({
    required NonSecureStorage fStorage,
    required CookiesStorage fCookiesStorage,
  })  : _fLocalStorage = fStorage,
        _fCookiesStorage = fCookiesStorage;

  /// Reference to the non-secure local storage service.
  final NonSecureStorage _fLocalStorage;

  /// The app cookies storage (for getting the user session infos)
  final CookiesStorage _fCookiesStorage;

  /// Stream to listen for changes to the authentication storage key.
  ///
  /// This stream reacts to updates in the stored authentication data,
  /// allowing real-time updates to be processed.
  Stream get listener => _fLocalStorage.listenToChanges(kAuthStorageKey);

  /// Returns the current [AuthModel] stored in the local storage.
  ///
  /// Parses the JSON stored in the local storage to construct
  /// the [AuthModel] object.
  AuthModel get fAuthModel =>
      AuthModel.fromJson(_fLocalStorage.getValue(kAuthStorageKey));

  /// Updates the authentication data in the local storage.
  ///
  /// This method serializes the provided [json] and updates the
  /// value associated with the authentication storage key.
  Future<void> _updateAuthStorage(Map<String, dynamic> json) async {
    await _fLocalStorage.setValue(kAuthStorageKey, json);
  }

  /// Sets the initialization state of the app.
  ///
  /// Defaults to `true` if no value is provided.
  void setInitialized([bool value = true]) {
    final jsonModel = fAuthModel.copyWith(isInitialized: value).toJson();
    _updateAuthStorage(jsonModel);
  }

  /// Updates the onboarding state of the app.
  ///
  /// Defaults to `true` if no value is provided.
  void setOnboarding([bool value = true]) {
    final jsonModel = fAuthModel.copyWith(isOnboarded: value).toJson();
    _updateAuthStorage(jsonModel);
  }

  /// Sets the state indicating that the user has created an account.
  ///
  /// Defaults to `true` if no value is provided.
  void setCreateAccount([bool value = true]) {
    final jsonModel = fAuthModel.copyWith(isLoggedIn: value).toJson();
    _updateAuthStorage(jsonModel);
  }

  /// Sets the logged-in state for the user.
  ///
  /// Updates multiple states:
  /// - `isLoggedIn` to `true`
  /// - `hasCompletedStep2` to `true`
  /// - `isVerified` to `true`
  Future<void> setLogIn({
    required bool hasCompletedStep2,
  }) async {
    if (!(await _fCookiesStorage.isUserLoggedIn())) return;
    final jsonModel = fAuthModel
        .copyWith(
          isLoggedIn: true,
          isVerified: true,
          hasCreatePassword: true,
          hasJustCreatedAccount: true,
          hasCompletedStep2: hasCompletedStep2,
        )
        .toJson();
    await _updateAuthStorage(jsonModel);
  }

  /// Sets the verification state for the user.
  ///
  /// Defaults to `true` if no value is provided.
  // void setVerified([bool value = true]) {
  //   final jsonModel = fAuthModel.copyWith(isVerified: value).toJson();
  //   _updateAuthStorage(jsonModel);
  // }

  Future<void> setVerified([bool value = true]) async {
  final jsonModel = fAuthModel.copyWith(isVerified: value).toJson();
  await _updateAuthStorage(jsonModel);
}
  /// Updates the state indicating that the user has completed step 2.
  ///
  /// Defaults to `true` if no value is provided.
  void setHasCompletedStep2([bool value = true]) {
    final jsonModel = fAuthModel.copyWith(hasCompletedStep2: value).toJson();
    _updateAuthStorage(jsonModel);
  }

  /// Logs the user out and resets related authentication states.
  ///
  /// Updates the following states:
  /// - `isLoggedIn` to `false`
  /// - `isVerified` to `false`
  /// - `hasCompletedStep2` to `false`
  Future<void> logOut() async {
    final jsonModel = fAuthModel
        .copyWith(
          isLoggedIn: false,
          isVerified: false,
          hasCompletedStep2: false,
        )
        .toJson();
    return _updateAuthStorage(jsonModel);
  }


Future<void> hasCreatePassword([bool value = true]) async {
    final jsonModel = fAuthModel.copyWith(hasCreatePassword: value).toJson();
    await _updateAuthStorage(jsonModel);
  }

  Future<void> hasJustCreatedAccount([bool value = true]) async {
    final jsonModel =
        fAuthModel.copyWith(hasJustCreatedAccount: value).toJson();
    await _updateAuthStorage(jsonModel);
  }
}
