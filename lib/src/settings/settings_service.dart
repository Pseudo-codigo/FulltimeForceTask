import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> themeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var a = prefs.getString('theme');

    var currentTheme = ThemeMode.system;
    if (a != null) {
      switch (a) {
        case 'dark':
          currentTheme = ThemeMode.dark;
          break;
        case 'light':
          currentTheme = ThemeMode.light;
          break;
        default:
          currentTheme = ThemeMode.system;
          break;
      }
    }

    return currentTheme;
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', theme.name.toString());
  }
}
