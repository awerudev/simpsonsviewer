import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/app/constants/enum.dart';
import 'package:shared/app/utils/transition_page_utils.dart';
import 'package:shared/core/presentation/screens/splash_screen.dart';
import 'package:shared/features/viewer/domain/model/post.dart';
import 'package:shared/features/viewer/presentation/screens/home_screen.dart';
import 'package:shared/features/viewer/presentation/screens/post_details.dart';
import 'package:simpsons/app/constants/constant.dart';
import 'package:simpsons/app/constants/route_name.dart';
import 'package:simpsons/core/presentation/main_screen.dart';

// ignore_for_file: long-method
@injectable
final class AppRoutes {
  AppRoutes(
    @factoryParam this.shellNavigatorKey,
    @factoryParam this.scaffoldKey,
  );

  final GlobalKey<NavigatorState> shellNavigatorKey;
  final ValueKey<String> scaffoldKey;

  List<RouteBase> get routes => <RouteBase>[
        GoRoute(
          path: RouteName.initial.path,
          name: RouteName.initial.name,
          builder: (BuildContext context, GoRouterState state) =>
              const SplashScreen(appTitle: Constant.appName),
        ),
        ShellRoute(
          navigatorKey: shellNavigatorKey,
          builder: (BuildContext context, GoRouterState state, Widget child) =>
              MainScreen(child: child),
          routes: <RouteBase>[
            GoRoute(
              path: RouteName.viewer.path,
              name: RouteName.viewer.name,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  FadeTransitionPage(
                key: scaffoldKey,
                child: const HomeScreen(),
              ),
              routes: <RouteBase>[
                GoRoute(
                  path: RouteName.postDetails.path,
                  name: RouteName.postDetails.name,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    if (state.extra is! Post) {
                      return FadeTransitionPage(
                        key: state.pageKey,
                        child: const HomeScreen(),
                      );
                    }
                    final Post post = state.extra! as Post;

                    return SlideTransitionPage(
                      key: state.pageKey,
                      transitionType: SlideTransitionType.rightToLeft,
                      child: PostDetails(post: post),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ];
}
