abstract class LocalStorage {
  Future<void> writeData({required String key, required List<String> data});
  Future<List<String>?> readData({required String key});
}
