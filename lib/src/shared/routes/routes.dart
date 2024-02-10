import 'package:flutter/cupertino.dart';
import 'package:fulltime_force_task/src/pages/activity/ui/activity.dart';
import 'package:fulltime_force_task/src/pages/branches/ui/branches.dart';
import 'package:fulltime_force_task/src/pages/home/ui/home.dart';
import 'package:fulltime_force_task/src/pages/settings/settings_view.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String home = '/home';
  static const String branchs = '/branches';
  static const String commits = '/commit';
  static const String activity = '/activity';
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
      builder: (context, state) => const Branches(),
    ),
    GoRoute(
      name: Routes.commits,
      path: '/commit',
      builder: (context, state) => const Branches(),
    ),
    GoRoute(
      name: Routes.activity,
      path: '/activity',
      builder: (context, state) => const Activity(),
    ),
  ],
);
