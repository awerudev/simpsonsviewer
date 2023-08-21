import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final class GoRouteObserver extends NavigatorObserver {
  GoRouteObserver(this.logger);

  final Logger logger;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logger.t(
      '${route.settings.name} pushed from ${previousRoute?.settings.name}',
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logger.t(
      '${route.settings.name} popped from ${previousRoute?.settings.name}',
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logger.t(
      '${route.settings.name} removed ${previousRoute?.settings.name}',
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    logger.t(
      '${newRoute?.settings.name} replaced ${oldRoute?.settings.name}',
    );
  }
}
