import 'package:dinacom_2024/components/camera/camera.dart';
import 'package:dinacom_2024/components/camera/camera_result_preview.dart';
import 'package:dinacom_2024/features/classificator/automatic.dart';
import 'package:dinacom_2024/features/classificator/manual.dart';
import 'package:dinacom_2024/models/user_model.dart';
import 'package:dinacom_2024/page/addbin.dart';
import 'package:dinacom_2024/page/calculator.dart';
import 'package:dinacom_2024/page/classificator.dart';
import 'package:dinacom_2024/page/complaint.dart';
import 'package:dinacom_2024/page/garbages.dart';
import 'package:dinacom_2024/page/guide.dart';
import 'package:dinacom_2024/page/onboarding.dart';
import 'package:dinacom_2024/page/profile.dart';
import 'package:dinacom_2024/page/profile/forgot_password.dart';
import 'package:dinacom_2024/page/profile/login.dart';
import 'package:dinacom_2024/page/profile/register.dart';
import 'package:dinacom_2024/page/profile/settings.dart';
import 'package:dinacom_2024/page/profile/trash_bin.dart';
import 'package:dinacom_2024/page/profile/user_profile.dart';
import 'package:dinacom_2024/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    initialLocation: '/garbage',
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
                          builder: (context, state) {
                            File file = state.extra as File;
                            return AutomaticClassificator(file);
                          },
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
                        path: 'addbin',
                        name: 'addbin',
                        pageBuilder: (context, state) =>
                            CustomTransitionPage<void>(
                          key: state.pageKey,
                          child: AddBinPage(
                            lat: state.uri.queryParameters['lat'],
                            lng: state.uri.queryParameters['lng'],
                            adrs: state.uri.queryParameters['adrs'],
                          ),
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
                          child:
                              ComplaintPage(adrs: state.pathParameters['adrs']),
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
                  )
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

      GoRoute(
          name: 'Camera',
          path: '/camera',
          builder: (context, state) {
            return const Camera();
          },
          routes: [
            GoRoute(
              name: 'Camera Preview',
              path: 'preview',
              builder: (context, state) {
                XFile file = state.extra as XFile;
                return CameraShootPreview(file);
              },
            )
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

      // User Profile
      GoRoute(
        name: 'User Profile',
        path: '/user-profile',
        builder: (context, state) =>
            UserProfile(user: state.extra! as UserModel),
      ),

      // Settings
      GoRoute(
        name: 'Settings',
        path: '/settings',
        builder: (context, state) => Settings(user: state.extra! as UserModel),
      ),

      // Trash Bin
      GoRoute(
        name: 'Trash Bin',
        path: '/trash-bin/:id',
        builder: (context, state) =>
            TrashBin(trashBinID: state.pathParameters['id'] ?? '1'),
      ),

      GoRoute(
        name: 'Onboarding',
        path: '/onboarding',
        builder: (context, state) => const Onboarding(),
      )
    ],
  );

  static Future<void> checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool onboardingComplete = prefs.getBool('onboarding_completed') ?? false;

    print('This is onboarding complete status $onboardingComplete');

    if (!onboardingComplete) {
      _router.go('/onboarding');
    }
  }

  static GoRouter getRouter() {
    checkOnboardingStatus();
    return _router;
  }
}
