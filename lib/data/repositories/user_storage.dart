import 'package:playkosmos_v3/constants/constants.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/models/user_model.dart';

/// A service that manages user profile data
///
/// This service relies on a non-secure storage mechanism to persist
/// and react to authentication-related changes.
///
/// @author: Godwin Mathias
class UserProfileStorage {
  /// Creates an instance of [UserProfileStorage].
  ///
  /// Requires a [NonSecureStorage] instance for local storage operations.
  UserProfileStorage({
    required NonSecureStorage fStorage,
  }) : _fLocalStorage = fStorage;

  /// Reference to the non-secure local storage service.
  final NonSecureStorage _fLocalStorage;

  /// Stream to listen for changes to the authentication storage key.
  ///
  /// This stream reacts to updates in the stored authentication data,
  /// allowing real-time updates to be processed.
  Stream get listener => _fLocalStorage.listenToChanges(kUserStorageKey);

  /// Returns the current [UserModel] stored in the local storage.
  ///
  /// Parses the JSON stored in the local storage to construct
  /// the [UserModel] object.
  UserModel get fUserModel => UserModel.fromMapLocal(
      _fLocalStorage.getValue(kUserStorageKey) ?? <String, dynamic>{});

  Future<void> setUser(UserModel fUser) async {
    _fLocalStorage.setValue(kUserStorageKey, fUser.toMap());
  }

  Future<void> removeUser() async {
    _fLocalStorage.delKey(kUserStorageKey);
  }
}
