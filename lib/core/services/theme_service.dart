import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class ThemeService {
  final _box = GetStorage();
  final _key = "isDarkMode";

  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void saveTheme(bool isDark) => _box.write(_key, isDark);

  void toggleTheme() {
    bool newMode = !_loadThemeFromBox();
    saveTheme(newMode);
    Get.changeThemeMode(newMode ? ThemeMode.dark : ThemeMode.light);
  }
}
