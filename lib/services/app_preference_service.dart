import 'package:flutter/foundation.dart';
import 'package:playkosmos_v3/services/services.dart';
import 'package:playkosmos_v3/utils/logger.dart';

/// Stores user non-secure essential data. Works like SharedPreference
/// but uses any storage system that implements [Storage].
/// ## Usage:
/// ```dart
/// main() {
/// ...
/// final appPreference = AppPreferenceService(storage: SomeStorage());
/// // Don't forget to initialize
/// appPreference.initDb();
/// // Then use the instance to store any data that needs to be secure
/// appPreference.setValue(key, value);
/// }
///
/// ```
class AppPreferenceService {
  AppPreferenceService({
    required Storage storage,
  }) : _storage = storage;

  final Storage _storage;

  /// Initializes the database
  Future<void> initDb() async {
    await _storage.initialize();
  }

  /// Get value using key
  dynamic getValue(String key) {
    dynamic value;
    try {
      value = _storage.read(key);
    } catch (e) {
      printE(e);
    }
    return value;
  }

  /// Add value to database using key
  void setValue(String key, dynamic value) {
    try {
      _storage.write(key, value);
    } catch (e, s) {
      printE(e, s);
    }
  }

  /// Deletes the value in key
  void delKey(String key) {
    try {
      _storage.delete(key);
    } catch (e, s) {
      printE(e, s);
    }
  }

  /// This is used to react to changes to keys
  ValueListenable<dynamic> reactToKeys(List<String> keys) {
    return _storage.listenable(keys);
  }
}
