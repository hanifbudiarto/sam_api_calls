import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../contracts/contracts.dart';

class UnsafeStorage implements LocalStorage {

  SharedPreferences prefs;

  @override
  Future<bool> init() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }

    return prefs != null;
  }

  @override
  Future<String> read({@required String key}) async {
    return await Future.value(prefs.getString(key));
  }

  @override
  Future<bool> write({@required String key, @required String value}) async {
    return await prefs.setString(key, value);
  }

  @override
  Future<bool> clearAll() async {
    return await prefs.clear();
  }

  @override
  Future<bool> clear({String key}) async {
    return await prefs.remove(key);
  }
}
