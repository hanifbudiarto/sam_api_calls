import 'package:flutter/material.dart';

abstract class LocalStorage {
  Future<bool> init();

  Future<String> read({@required String key});

  Future<bool> write({@required String key, @required String value});

  Future<bool> clearAll();

  Future<bool> clear({@required String key});
}
