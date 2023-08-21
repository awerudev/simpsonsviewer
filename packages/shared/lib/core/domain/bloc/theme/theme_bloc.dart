import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/app/helpers/extensions.dart';

class ThemeBloc extends Cubit<ThemeMode> {
  ThemeBloc() : super(ThemeMode.system);

  void switchTheme(Brightness brightness) => safeEmit(
        brightness == Brightness.dark //
            ? ThemeMode.light
            : ThemeMode.dark,
      );
}
