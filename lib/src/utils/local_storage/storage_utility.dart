import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();

  factory LocalStorage() => _instance;

  LocalStorage._internal();

  final _storage = GetStorage();

  /// Read data from local storage
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  /// Save data to local storage
  Future<void> saveData<T>(String key, dynamic value) async {
    await _storage.write(key, value);
  }

  /// Remove data from local storage
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  Future<void> clearAll() async {
    await _storage.erase();
  }
}
