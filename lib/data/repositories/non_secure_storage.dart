import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/utils/logger.dart';

/// Stores user non-secure essential data. Works like SharedPreference
/// but uses any storage system that implements [Storage].
/// ## Usage:
/// ```dart
/// main() {
/// ...
/// final nonSecure = NonSecureStorage(storage: SomeStorage());
/// // Don't forget to initialize
/// nonSecure.initDb();
/// // Then use the instance to store any data that doesn't needs to be secure
/// nonSecure.setValue(key, value);
/// }
///
/// ```
class NonSecureStorage {
  NonSecureStorage({
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
      printI(value);
    } catch (e) {
      printE(e);
    }
    return value;
  }

  /// Add value to database using key
  Future<void> setValue(String key, dynamic value) async {
    try {
      await _storage.write(key, value);
    } catch (e, s) {
      printE(e, s);
    }
  }

  /// Deletes the value in key
  Future<void> delKey(String key) async {
    try {
      await _storage.delete(key);
    } catch (e, s) {
      printE(e, s);
    }
  }

  /// This is used to react to changes to keys
  Stream<dynamic> listenToChanges(String key) {
    return _storage.listener(key);
  }
}
