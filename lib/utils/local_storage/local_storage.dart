import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:hdi_test/utils/local_storage/local_storage_keys.dart';

class LocalStorage {
  static const _boxName = 'app';
  static late Box _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  static set boxForTest(Box box) => _box = box;

  static T? get<T>(String key) => _box.get(key) as T?;

  static Future<void> set<T>(String key, T value) => _box.put(key, value);

  static Future<void> remove(String key) => _box.delete(key);

  static bool get isLoggedIn => _box.get(LocalStorageKeys.isLoggedIn, defaultValue: false) as bool;

  static Future<void> setLoggedIn(bool value) => _box.put(LocalStorageKeys.isLoggedIn, value);

  static ThemeMode get themeMode {
    final saved = _box.get(LocalStorageKeys.themeMode) as String?;
    return switch (saved) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  static Future<void> setThemeMode(ThemeMode mode) => _box.put(LocalStorageKeys.themeMode, mode.name);
}
