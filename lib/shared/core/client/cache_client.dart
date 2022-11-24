abstract class LocalStorage {
  Future<void> writeData({required String key, required List<String> list});
  Future<List<String>?> readData({required String key});
}
