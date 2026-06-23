import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/widgets/app_scaffold.dart';
import '../../features/home/home_screen.dart';
import '../../features/services/services_screen.dart';
import '../../features/explore/explore_screen.dart';
import '../../features/report/report_screen.dart';
import '../../features/report/report_form_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/hotlines/hotlines_screen.dart';
import '../../features/services/service_detail_screen.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> _rootKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/home',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/home', builder: (c, s) => const HomeScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/services',
                builder: (c, s) => const ServicesScreen(),
                routes: [
                  GoRoute(
                    path: ':serviceId',
                    builder: (c, s) => ServiceDetailScreen(
                      serviceId: s.pathParameters['serviceId']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/explore',
                builder: (c, s) => const ExploreScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/report',
                builder: (c, s) => const ReportScreen(),
                routes: [
                  GoRoute(
                    path: 'new',
                    builder: (c, s) => const ReportFormScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (c, s) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),

      // Routes outside the bottom-nav shell (full-screen, no tab bar)
      GoRoute(
        path: '/hotlines',
        parentNavigatorKey: _rootKey,
        builder: (c, s) => const HotlinesScreen(),
      ),
    ],
  );
}
