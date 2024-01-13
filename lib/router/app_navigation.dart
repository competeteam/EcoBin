import 'package:dinacom_2024/components/camera/camera.dart';
import 'package:dinacom_2024/features/classificator/automatic.dart';
import 'package:dinacom_2024/features/classificator/manual.dart';
import 'package:dinacom_2024/page/addbin.dart';
import 'package:dinacom_2024/page/calculator.dart';
import 'package:dinacom_2024/page/classificator.dart';
import 'package:dinacom_2024/page/complaint.dart';
import 'package:dinacom_2024/page/garbages.dart';
import 'package:dinacom_2024/page/guide.dart';
import 'package:dinacom_2024/page/profile/forgot_password.dart';
import 'package:dinacom_2024/page/profile/login.dart';
import 'package:dinacom_2024/page/profile/profile.dart';
import 'package:dinacom_2024/page/profile/register.dart';
import 'package:dinacom_2024/page/profile/settings.dart';
import 'package:dinacom_2024/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../page/profile/trash_bin.dart';

class AppNavigation {
  // Private navigators
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _calculatorNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'calculatorNavigator');
  static final _classificatorNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'classificatorNavigator');
  static final _garbageNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'garbageNavigator');
  static final _guidesNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'guidesNavigator');
  static final _profileNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'profileNavigator');

  static final _router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/profile',
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return Wrapper(navigationShell: navigationShell);
          },
          branches: <StatefulShellBranch>[
            // Guides
            StatefulShellBranch(
                navigatorKey: _guidesNavigatorKey,
                routes: <RouteBase>[
                  GoRoute(
                    name: 'Guides',
                    path: '/guides',
                    builder: (context, state) => const Guide(),
                  ),
                  GoRoute(
                      name: 'Guide Content',
                      path: '/guide/:id',
                      builder: (context, state) => const GuideArticle()
                  )
                ]),

            // Classificator
            StatefulShellBranch(
                navigatorKey: _classificatorNavigatorKey,
                routes: <RouteBase>[
                  GoRoute(
                      name: 'Classificator',
                      path: '/classificator',
                      builder: (context, state) => const Classificator(),
                      routes: <RouteBase>[
                        GoRoute(
                          name: 'Manual Classificator',
                          path: 'manual',
                          builder: (context, state) =>
                              const ManualClassificator(),
                        ),
                        GoRoute(
                          name: 'Automatic Classificator',
                          path: 'automatic',
                          builder: (context, state) =>
                              const AutomaticClassificator(),
                        )
                      ])
                ]),

            // Garbage
            StatefulShellBranch(
                navigatorKey: _garbageNavigatorKey,
                routes: <RouteBase>[
                  GoRoute(
                    name: 'Garbage',
                    path: '/garbage',
                    builder: (context, state) => const Garbages(),
                    routes: [
                      GoRoute(
                        path: 'addbin/:adrs',
                        name: 'addbin',
                        pageBuilder: (context, state) =>
                            CustomTransitionPage<void>(
                          key: state.pageKey,
                          child:
                              AddBinPage(adrs: state.pathParameters['adrs']),
                          transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                        ),
                      ),
                      GoRoute(
                        path: 'complaint/:adrs',
                        name: 'complaint',
                        pageBuilder: (context, state) =>
                            CustomTransitionPage<void>(
                          key: state.pageKey,
                          child: ComplaintPage(adrs: state.pathParameters['adrs']),
                          transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                        ),
                      ),
                    ],
                  )
                ]),

            // Calculator
            StatefulShellBranch(
                navigatorKey: _calculatorNavigatorKey,
                routes: <RouteBase>[
                  GoRoute(
                    name: 'Calculator',
                    path: '/calculator',
                    builder: (context, state) => const Calculator(),
                  ),
                ]),

            // Profile
            StatefulShellBranch(
                navigatorKey: _profileNavigatorKey,
                routes: <RouteBase>[
                  GoRoute(
                    name: 'Profile',
                    path: '/profile',
                    builder: (context, state) => const Profile(),
                  )
                ]),
          ]),

      // Login
      GoRoute(
        name: 'Login',
        path: '/login',
        builder: (context, state) => const Login(),
      ),

      // Register
      GoRoute(
        name: 'Register',
        path: '/register',
        builder: (context, state) => const Register(),
      ),

      // Forgot Password
      GoRoute(
        name: 'Forgot Password',
        path: '/forgot-password',
        builder: (context, state) => const ForgotPassword(),
      ),

      // Settings
      GoRoute(
        name: 'Settings',
        path: '/settings',
        builder: (context, state) => const Settings(),
      ),

      // Trash Bin
      GoRoute(
        name: 'Trash Bin',
        path: '/trash-bin/:id',
        builder: (context, state) =>
            TrashBin(trashBinID: state.pathParameters['id'] ?? '1'),
      )
    ],
  );

  static GoRouter getRouter() {
    return _router;
  }
}
