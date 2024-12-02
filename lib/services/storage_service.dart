import 'package:flutter/foundation.dart';

/// Interface which is used to persist and retrieve data from user device.
abstract class Storage {
  /// Returns value for key
  dynamic read(String key);

  /// Persists key value pair
  Future<void> write(String key, dynamic value);

  /// Deletes key value pair
  Future<void> delete(String key);

  /// Clears all key value pairs from storage
  Future<void> clear();

  /// To react to certain changes in the [keys]
  ValueListenable<dynamic> listenable(List<String> keys);

  // Storage initializer
  Future<void> initialize();
}
