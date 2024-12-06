import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:playkosmos_v3/data/data_source/interfaces/storage.dart';
import 'package:sembast/sembast_io.dart';

/// Implementation of the [Storage] interface using the Sembast database.
/// This implementation provides non-secure storage for key-value pairs.
///
/// Features include:
/// - Reading and writing key-value pairs.
/// - Listening for changes on specific keys.
/// - Clearing and deleting specific records.
///
/// @author: Godwin Mathias
class NonSecureSembastStorageImpl implements Storage {
  /// Instance of the Sembast database.
  late Database _db;

  /// Store used for managing key-value pairs.
  final _store = StoreRef<String, dynamic>('playkosmos_preference');

  /// Initializes the Sembast database.
  ///
  /// This method sets up the database in the app's document directory with
  /// the file name `playkosmos.db`. Must be called before performing any
  /// read/write operations.
  @override
  Future<void> initialize() async {
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDir.path, 'playkosmos.db');
    _db = await databaseFactoryIo.openDatabase(dbPath);
  }

  /// Clears all key-value pairs stored in the database.
  ///
  /// This will delete all records from the store.
  @override
  Future<void> clear() async {
    await _store.delete(_db);
  }

  /// Deletes a specific key-value pair from the database.
  ///
  /// - [key]: The key of the record to be deleted.
  @override
  Future<void> delete(String key) async {
    await _store.record(key).delete(_db);
  }

  /// Reads the value associated with a specific key from the database.
  ///
  /// - [key]: The key of the record to be read.
  /// - Returns: The value associated with the key, or `null` if the key doesn't exist.
  @override
  Future<dynamic> read(String key) async {
    return await _store.record(key).get(_db);
  }

  /// Listens for changes to a specific key in the database.
  ///
  /// - [key]: The key to listen for changes.
  /// - Returns: A [Stream] that emits the updated value of the key whenever it changes.
  @override
  Stream<dynamic> listener(String key) {
    return _store.record(key).onSnapshot(_db);
  }

  /// Writes a value to the database with a specified key.
  ///
  /// - [key]: The key under which the value should be stored.
  /// - [value]: The value to be stored. Can be of any type that is JSON-compatible.
  @override
  Future<void> write(String key, value) async {
    await _store.record(key).put(_db, value);
  }
}
