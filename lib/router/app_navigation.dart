import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dinacom_2024/components/camera/camera.dart';
import 'package:dinacom_2024/components/camera/camera_result_preview.dart';
import 'package:dinacom_2024/features/classificator/automatic.dart';
import 'package:dinacom_2024/features/classificator/manual.dart';
import 'package:dinacom_2024/page/calculator.dart';
import 'package:dinacom_2024/page/classificator.dart';
import 'package:dinacom_2024/page/garbages.dart';
import 'package:dinacom_2024/page/guide.dart';
import 'package:dinacom_2024/page/profile.dart';
import 'package:dinacom_2024/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  AppNavigation._();

  static String initial = "/calculator";

  // Private navigators
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorCalculator =
      GlobalKey<NavigatorState>(debugLabel: 'shellCalculator');
  static final _shellNavigatorClassificator =
      GlobalKey<NavigatorState>(debugLabel: 'shellClassificator');
  static final _shellNavigatorGarbages =
      GlobalKey<NavigatorState>(debugLabel: 'shellGarbages');
  static final _shellNavigatorGuide =
      GlobalKey<NavigatorState>(debugLabel: 'shellGuide');
  static final _shellNavigatorProfile =
      GlobalKey<NavigatorState>(debugLabel: 'shellProfile');
  static final _shellNavigatorCamera = 
      GlobalKey<NavigatorState>(debugLabel: 'shellCamera');

  // GoRouter configuration
  static final GoRouter router = GoRouter(
    initialLocation: initial,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      /// MainWrapper
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Wrapper(
            navigationShell: navigationShell,
          );
        },
        branches: <StatefulShellBranch>[
          /// Calculator
          StatefulShellBranch(
            navigatorKey: _shellNavigatorCalculator,
            routes: <RouteBase>[
              GoRoute(
                path: "/calculator",
                name: "Calculator",
                builder: (BuildContext context, GoRouterState state) =>
                    const Calculator(),
              ),
            ],
          ),

          // Classificator
          StatefulShellBranch(
            navigatorKey: _shellNavigatorClassificator,
            routes: <RouteBase>[
              GoRoute(
                path: "/classificator",
                name: "Classificator",
                builder: (BuildContext context, GoRouterState state ) =>
                    const Classificator(),
              ),
              GoRoute(
                path: "/classificator/manual",
                name: "Manual Classificator",
                builder:(context, state) => 
                  const ManualClassificator(),
              ),
              GoRoute(
                path: "/classificator/automatic",
                name: "Automatic Classificator",
                builder:(context, state) => 
                  const AutomaticClassificator(),
              )
            ],
          ),

          // Garbages
          StatefulShellBranch(
            navigatorKey: _shellNavigatorGarbages,
            routes: <RouteBase>[
              GoRoute(
                path: "/garbages",
                name: "Garbages",
                builder: (BuildContext context, GoRouterState state) =>
                    const Garbages(),
              ),
            ],
          ),

          // Guide
          StatefulShellBranch(
            navigatorKey: _shellNavigatorGuide,
            routes: <RouteBase>[
              GoRoute(
                path: "/guide",
                name: "Guide",
                builder: (BuildContext context, GoRouterState state) =>
                    const Guide(),
              ),
              GoRoute(
                path: "/guide/:id",
                name: "Guide Content",
                builder: (BuildContext context, GoRouterState state) =>
                    const GuideArticle(),
              ),
            ],
          ),

          // Profile
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfile,
            routes: <RouteBase>[
              GoRoute(
                path: "/profile",
                name: "Profile",
                builder: (BuildContext context, GoRouterState state) =>
                    const Profile(),
              ),
            ],
          ),

          StatefulShellBranch(
            navigatorKey: _shellNavigatorCamera,
            routes: <RouteBase>[
              GoRoute(
                path: "/camera",
                name: "Camera",
                builder:(context, state) => 
                  const Camera(),
              ),
              GoRoute(
                path: "/camera/preview",
                name: "Camera Preview",
                builder: (context, state) {
                  XFile file = state.extra as XFile;
                  return CameraShootPreview(file);
                },
              )
            ]
          ),

        ],
      ),
    ],
  );
}