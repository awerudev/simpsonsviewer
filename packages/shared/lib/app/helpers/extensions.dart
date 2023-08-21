import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/app/constants/enum.dart';
import 'package:shared/app/generated/l10n.dart';

// ignore_for_file: prefer-match-file-name,invalid_use_of_protected_member
// ignore_for_file: invalid_use_of_visible_for_testing_member,prefer-enums-by-name
extension BuildContextX on BuildContext {
  SharedLocalizations get commonL10n => SharedLocalizations.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;
}

extension GoRouterExt on GoRouter {
  String get location => routerDelegate.currentConfiguration.uri.toString();
}

extension CubitX<S> on Cubit<S> {
  void safeEmit(S state) {
    if (isClosed) return;
    emit(state);
  }
}

extension StatusCodeX on StatusCode {
  bool get isSuccess => value == 200 || value == 201 || value == 204;
}

extension IntX on int {
  StatusCode get statusCode => StatusCode.values.firstWhere(
        (StatusCode element) => element.value == this,
        orElse: () => StatusCode.http000,
      );
}
