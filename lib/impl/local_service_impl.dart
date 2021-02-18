import 'package:flutter/material.dart';

import '../contracts/contracts.dart';
import 'secure_storage.dart';
import 'unsafe_storage.dart';

class LocalServiceImpl implements LocalService {
  LocalStorage _storage;

  @override
  Future<LocalStorage> getStorage() async {
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
  Future<bool> clear({String key}) async {
    return await getStorage()
        .then((storage) async => await storage.clear(key: key));
  }
}
