import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en'));

  // Make Locale a private variable so it is not updated directly without
  Locale? _locale;

  // Allow Widgets to read the user's preferred Locale.
  Locale get locale => _locale ?? const Locale('en');

  Future<void> init() async {
    //verify local storage
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var loc = prefs.getString('locale');

    var currentLocale = locale;
    if (loc != null) {
      currentLocale = Locale(loc);
    }
    _locale = currentLocale;
    emit(currentLocale);
  }

  /// Update and persist the locale based on the user's selection.
  Future<void> updatelocale(Locale? newLocale) async {
    if (newLocale == null) return;

    // Do not perform any work if new and old locale are identical
    if (newLocale == _locale) return;

    // Otherwise, store the new locale in memory
    _locale = newLocale;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('locale', locale.languageCode.toString());
    // Persist the changes to a local database or the internet using the
    // SettingService.
    emit(newLocale);
  }
}
