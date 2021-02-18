
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../contracts/contracts.dart';

class SecureStorage implements LocalStorage {
  FlutterSecureStorage storage;

  @override
  Future<bool> init() async {
    if (storage == null) {
      storage = FlutterSecureStorage();
    }

    return await storage.init();
  }

  @override
  Future<String> read({@required String key}) async {
    try {
      return await storage.read(key: key);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> write({@required String key, @required String value}) async {
    try {
      await storage.write(key: key, value: value);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> clearAll() async {
    try {
      await storage.deleteAll();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> clear({String key}) async {
    try {
      await storage.delete(key: key);
      return true;
    } catch (e) {
      return false;
    }
  }
}