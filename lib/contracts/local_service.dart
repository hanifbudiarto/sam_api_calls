part of sam_contracts;

abstract class LocalService {
  Future<LocalStorage> getStorage({String path});

  Future<String?> read({required String key});

  Future<bool> write({required String key, required String value});

  Future<bool> clearAll();

  Future<bool> clear({required String key});

  Future<bool> isContainsKey({required String key});
}