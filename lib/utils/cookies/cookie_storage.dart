import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

class CookiesStorage implements Storage {
  late Database _db;
  final _store = StoreRef<String, String>("cookie_store");

  CookiesStorage();

  @override
  Future<void> init([
    bool persistSession = true,
    bool ignoreExpires = false,
  ]) async {
    final dbFactory = databaseFactoryIo;
    final dbPath = await getDbPath('cookie_database.db');
    _db = await dbFactory.openDatabase(dbPath);
  }

  @override
  Future<void> write(String key, Object value) async {
    final stringValue = value.toString();
    await _store.record(key).put(_db, stringValue);
  }

  @override
  Future<String?> read(String key) async {
    return await _store.record(key).get(_db);
  }

  @override
  Future<void> delete(String key) async {
    await _store.record(key).delete(_db);
  }

  /// Clear all entries in the store
  Future<void> clear() async {
    await _store.delete(_db);
  }

  @override
  Future<void> deleteAll(List<String> keys) async {
    for (var key in keys) {
      await _store.record(key).delete(_db);
    }
  }

  /// Close the database connection
  Future<void> close() async {
    await _db.close();
  }

  Future<String> getDbPath(String dbName) async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$dbName').path;
  }

  bool isUserLoggedIn() {
    final cookie = _store.countSync(_db);
    return cookie > 0;
  }
}
