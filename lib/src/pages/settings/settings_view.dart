import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fulltime_force_task/src/shared/locale/localization_cubit.dart';
import 'package:fulltime_force_task/src/shared/theme/theme_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeCubit themeCubit = context.watch<ThemeCubit>();
    LocaleCubit localeCubit = context.watch<LocaleCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsTitle),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  ListTile(
                    enableFeedback: false,
                    splashColor: Colors.transparent,
                    title: Text(
                      AppLocalizations.of(context)!.settingsTheme,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    trailing: DropdownButton<ThemeMode>(
                      value: themeCubit.themeMode,
                      // Call the updateThemeMode method any time the user selects a theme.
                      onChanged: (theme) {
                        themeCubit.updateThemeMode(theme);
                      },
                      items: [
                        DropdownMenuItem(
                          value: ThemeMode.system,
                          child: Text(AppLocalizations.of(context)!
                              .settingsThemeSystem),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.light,
                          child: Text(
                              AppLocalizations.of(context)!.settingsThemeLight),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.dark,
                          child: Text(
                              AppLocalizations.of(context)!.settingsThemeDark),
                        )
                      ],
                      underline: Container(),
                      hint: const Text("Seleccione Tema"),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    enableFeedback: false,
                    splashColor: Colors.transparent,
                    title: Text(
                      AppLocalizations.of(context)!.settingsLocale,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    trailing: DropdownButton<Locale>(
                      value: localeCubit.locale,
                      // Call the updateThemeMode method any time the user selects a theme.
                      onChanged: (locale) {
                        localeCubit.updatelocale(locale);
                      },
                      items: [
                        DropdownMenuItem(
                          value: const Locale('en'),
                          child: Text(
                              AppLocalizations.of(context)!.settingsLocaleEn),
                        ),
                        DropdownMenuItem(
                          value: const Locale('es'),
                          child: Text(
                              AppLocalizations.of(context)!.settingsLocaleEs),
                        )
                      ],
                      underline: Container(),
                      hint: const Text("Seleccione Tema"),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
