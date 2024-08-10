import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mytodo/theme/theme.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _boxName = 'themeBox'; // Box name to store theme settings
  static const String _key = 'isDarkMode'; // Key to store the theme preference
  bool _isDarkMode = false; // Default theme mode

  ThemeProvider() {
    loadTheme(); // Load the stored theme preference when the provider is initialized
  }

  bool get isDarkMode => _isDarkMode; // Getter for the current theme mode

  ThemeData get themeData =>
      _isDarkMode ? darkMode : lightMode; // Use the custom themes

  void toggleTheme() {
    _isDarkMode = !_isDarkMode; // Toggle between dark and light mode
    _saveTheme(); // Save the new theme preference
    notifyListeners(); // Notify listeners about the change
  }

  Future<void> loadTheme() async {
    final box = await Hive.openBox(_boxName); // Open the box
    _isDarkMode =
        box.get(_key, defaultValue: false); // Load the theme preference
  }

  Future<void> _saveTheme() async {
    final box = await Hive.openBox(_boxName); // Open the box
    box.put(_key, _isDarkMode); // Save the theme preference
  }
}
