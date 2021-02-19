import 'package:flutter/material.dart';
import 'package:sam_api_calls/contracts/local_storage.dart';

abstract class LocalService {
  Future<LocalStorage> getStorage();

  Future<String> read({@required String key});

  Future<bool> write({@required String key, @required String value});

  Future<bool> clearAll();

  Future<bool> clear({@required String key});
}