import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sam_api_calls/contracts/contracts.dart';

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
  Future<bool> clear({@required String key}) async {
    return await prefs.remove(key);
  }

  @override
  Future<bool> isContainsKey({@required String key}) async {
    return prefs.containsKey(key);
  }
}
