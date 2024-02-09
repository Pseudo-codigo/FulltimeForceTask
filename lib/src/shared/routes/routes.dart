import 'package:flutter/cupertino.dart';
import 'package:fulltime_force_task/src/pages/home/ui/home.dart';
import 'package:fulltime_force_task/src/sample_feature/sample_item_list_view.dart';
import 'package:fulltime_force_task/src/pages/settings/settings_view.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String home = '/home';
  static const String branchs = '/branches';
  static const String commits = '/settings';
  static const String settings = '/settings';
}

final navigatorKey = GlobalKey<NavigatorState>();

var routes = GoRouter(
  observers: [HeroController()],
  initialLocation: Routes.home,
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      name: Routes.home,
      path: '/home',
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      name: Routes.settings,
      path: '/settings',
      builder: (context, state) => const SettingsView(),
    ),
    GoRoute(
      name: Routes.branchs,
      path: '/branches',
      builder: (context, state) => const SampleItemListView(),
    ),
  ],
);
