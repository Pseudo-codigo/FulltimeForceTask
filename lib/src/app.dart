import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fulltime_force_task/src/pages/activity/bloc/activity_bloc.dart';
import 'package:fulltime_force_task/src/pages/branches/bloc/branches_bloc.dart';
import 'package:fulltime_force_task/src/pages/home/bloc/home_bloc.dart';
import 'package:fulltime_force_task/src/shared/locale/localization_cubit.dart';
import 'package:fulltime_force_task/src/shared/routes/routes.dart';
import 'package:fulltime_force_task/src/shared/theme/theme_cubit.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  MyApp({
    super.key,
    // required this.settingsController,
  });

  // final SettingsController settingsController;
  late final _router = routes;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()..init()),
        BlocProvider(create: (context) => LocaleCubit()..init()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => BranchesBloc()),
        BlocProvider(create: (context) => ActivityBloc()),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            // Providing a restorationScopeId allows the Navigator built by the
            // MaterialApp to restore the navigation stack when a user leaves and
            // returns to the app after it has been killed while running in the
            // background.
            restorationScopeId: 'app',
            debugShowCheckedModeBanner: false,

            // Provide the generated AppLocalizations to the MaterialApp. This
            // allows descendant Widgets to display the correct translations
            // depending on the user's locale.
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,

            // Use AppLocalizations to configure the correct application title
            // depending on the user's locale.
            locale: context.watch<LocaleCubit>().locale,
            //
            // The appTitle is defined in .arb files found in the localization
            // directory.
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context)!.homeTitle,

            // Define a light and dark color theme. Then, read the user's
            // preferred ThemeMode (light, dark, or system default) from the
            // SettingsController to display the correct theme.
            theme: ThemeData(),
            darkTheme: ThemeData.dark(),
            themeMode: context.watch<ThemeCubit>().themeMode,
            routerConfig: _router,
          );
        },
      ),
    );
  }
}
