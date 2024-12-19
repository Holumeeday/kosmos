import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// A storage system for managing cookies using FlutterSecureStorage.
///
/// This class implements the `Storage` interface for the `cookie_jar` package
/// to allow persistence of cookies in a secure format.
///
/// Author: Godwin Mathias
class CookiesStorage implements Storage {
  final FlutterSecureStorage _secureStorage;

  CookiesStorage({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  /// Initializes the secure storage.
  ///
  /// [persistSession]: Indicates whether session cookies should be persisted.
  /// [ignoreExpires]: If true, expired cookies are not removed.
  @override
  Future<void> init([
    bool persistSession = true,
    bool ignoreExpires = false,
  ]) async {
    printI('Secure storage initialized');
  }

  /// Writes a key-value pair to the secure storage.
  ///
  /// [key]: The key to store the value under.
  /// [value]: The value to store (converted to a string).
  @override
  Future<void> write(String key, Object value) async {
    final stringValue = value.toString();
    await _secureStorage.write(key: key, value: stringValue);
    printI('Cookie written: Key="$key", Value="$stringValue"');
  }

  /// Reads the value associated with a key from the secure storage.
  ///
  /// [key]: The key whose value is to be read.
  /// Returns: The stored value as a string, or `null` if the key does not exist.
  @override
  Future<String?> read(String key) async {
    final value = await _secureStorage.read(key: key);
    printI('Cookie read: Key="$key", Value="$value"');
    return value;
  }

  /// Deletes a key-value pair from the secure storage.
  ///
  /// [key]: The key to delete.
  @override
  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
    printI('Cookie deleted: Key="$key"');
  }

  /// Clears all cookies from the secure storage.
  Future<void> clear() async {
    await _secureStorage.deleteAll();
    printI('All cookies cleared');
  }

  /// Deletes multiple keys from the secure storage.
  ///
  /// [keys]: A list of keys to delete.
  @override
  Future<void> deleteAll(List<String> keys) async {
    for (var key in keys) {
      await _secureStorage.delete(key: key);
      printI('Cookie deleted in bulk: Key="$key"');
    }
  }

  /// Checks if the user is logged in by verifying the presence of cookies.
  ///
  /// Returns: `true` if there are cookies stored, `false` otherwise.
  Future<bool> isUserLoggedIn() async {
    final allKeys = await _secureStorage.readAll();
    final isLoggedIn = allKeys.isNotEmpty;
    printI('User logged in status: $isLoggedIn');
    return isLoggedIn;
  }
}
