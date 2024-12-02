import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:playkosmos_v3/services/storage_service.dart';
import 'package:sembast/sembast_io.dart';

class SembastPreference implements Storage {
  // The Sembast database
  late Database _db;

  // The store used for storing key-value pairs
  final _store = StoreRef<String, dynamic>('playkosmos_preference');

  /// Initialize Sembast database
  @override
  Future<void> initialize() async {
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDir.path, 'playkosmos.db');
    _db = await databaseFactoryIo.openDatabase(dbPath);
  }

  @override
  Future<void> clear() async {
    await _store.delete(_db);
  }

  @override
  Future<void> delete(String key) async {
    await _store.record(key).delete(_db);
  }

  @override
  read(String key) async {
    return await _store.record(key).get(_db);
  }

  @override
  ValueListenable<List<MapEntry<String, dynamic>>> listenable(
      List<String> keys) {
    // Simulate `ValueListenable` using a `Stream`.
    // Wrap it into a `ValueListenable` for compatibility.
    final controller = ValueNotifier<List<MapEntry<String, dynamic>>>([]);
    _store.query().onSnapshots(_db).listen((snapshots) {
      final filteredEntries = snapshots
          .where((snapshot) => keys.contains(snapshot.key))
          .map((snapshot) => MapEntry(snapshot.key, snapshot.value))
          .toList();
      controller.value = filteredEntries;
    });
    return controller;
  }

  @override
  Future<void> write(String key, value) async {
    await _store.record(key).put(_db, value);
  }
}
