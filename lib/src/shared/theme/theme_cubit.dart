import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  // Make ThemeMode a private variable so it is not updated directly without
  // also persisting the changes with the SettingsService.
  ThemeMode? _themeMode;

  // Allow Widgets to read the user's preferred ThemeMode.
  ThemeMode get themeMode => _themeMode??ThemeMode.system;

  Future<void> init() async {
    //verify local storage
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
    _themeMode = currentTheme;
    emit(currentTheme);
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    // Do not perform any work if new and old ThemeMode are identical
    if (newThemeMode == _themeMode) return;

    // Otherwise, store the new ThemeMode in memory
    _themeMode = newThemeMode;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', themeMode.name.toString());
    // Persist the changes to a local database or the internet using the
    // SettingService.
    emit(newThemeMode);
  }
}
