import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class ThemeService extends GetxService {
  final _box = GetStorage();
  final _key = "isDarkMode";

  // Reactive boolean
  final isDarkMode = false.obs;

  ThemeService() {
    // Initialize from storage
    isDarkMode.value = _loadThemeFromBox();
  }

  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  ThemeMode get theme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  void saveTheme(bool isDark) => _box.write(_key, isDark);

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value; // Update reactive variable
    saveTheme(isDarkMode.value);
    Get.changeThemeMode(theme); // Apply theme immediately
  }
}
