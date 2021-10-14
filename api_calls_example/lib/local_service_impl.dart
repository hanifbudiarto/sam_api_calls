import 'package:api_calls_example/secure_storage.dart';
import 'package:api_calls_example/unsafe_storage.dart';
import 'package:flutter/material.dart';
import 'package:sam_api_calls/contracts/contracts.dart';
class LocalServiceImpl implements LocalService {
  LocalStorage _storage;

  @override
  Future<LocalStorage> getStorage({String path}) async {
    if (_storage == null) {
      _storage = SecureStorage();
      bool secureStorageComplete = await _storage.init();

      print("Secure storage initialization $secureStorageComplete");
      if (!secureStorageComplete) {
        _storage = UnsafeStorage();
        await _storage.init();
      }
    }

    return _storage;
  }

  @override
  Future<String> read({@required String key}) async {
    return await getStorage()
        .then((storage) async => await storage.read(key: key));
  }

  @override
  Future<bool> write({@required String key, @required String value}) async {
    return await getStorage()
        .then((storage) async => await storage.write(key: key, value: value));
  }

  @override
  Future<bool> clearAll() async {
    return await getStorage().then((storage) async => await storage.clearAll());
  }

  @override
  Future<bool> clear({@required String key}) async {
    return await getStorage()
        .then((storage) async => await storage.clear(key: key));
  }

  @override
  Future<bool> isContainsKey({@required String key}) async {
    return await getStorage()
        .then((storage) async => await storage.isContainsKey(key: key));
  }
}
