import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:shared/app/observers/go_route_observer.dart';
import 'package:shared/features/viewer/domain/bloc/post/post_bloc.dart';
import 'package:simpsons/app/constants/route_name.dart';
import 'package:simpsons/app/helpers/injection.dart';
import 'package:simpsons/app/routes/app_routes.dart';

@injectable
final class AppRouter {
  AppRouter(@factoryParam this.postBloc);

  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  final ValueKey<String> scaffoldKey = const ValueKey<String>('scaffold');
  final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');
  final PostBloc postBloc;

  late final GoRouter router = GoRouter(
    routes:
        getIt<AppRoutes>(param1: shellNavigatorKey, param2: scaffoldKey).routes,
    redirect: _routeGuard,
    refreshListenable: GoRouterRefreshStream(postBloc.stream),
    initialLocation: RouteName.initial.path,
    observers: <NavigatorObserver>[GoRouteObserver(getIt<Logger>())],
    navigatorKey: rootNavigatorKey,
  );

  String? _routeGuard(_, GoRouterState goRouterState) {
    final String initialPath = RouteName.initial.path;
    final String viewerPath = RouteName.viewer.path;

    return postBloc.state.mapOrNull(
      initial: (_) => initialPath,
      success: (_) =>
          goRouterState.matchedLocation == initialPath ? viewerPath : null,
    );
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
