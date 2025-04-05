import 'package:get_storage/get_storage.dart';

class LLocalStorage {
  static LLocalStorage? _instance;
  late final GetStorage _storage;

  LLocalStorage._internal(String bucketName) {
    _storage = GetStorage(bucketName);
  }

  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance = LLocalStorage._internal(bucketName);
  }

  factory LLocalStorage.instance() {
    if (_instance == null) {
      throw Exception("LLocalStorage is not initialized. Call init() first.");
    }
    return _instance!;
  }

  // Save data
  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  // Read data
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  // Remove data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  // Clear all data
  Future<void> clearAll() async {
    await _storage.erase();
  }
}
