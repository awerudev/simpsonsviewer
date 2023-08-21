import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/app/helpers/extensions.dart';

part 'app_life_cycle_bloc.freezed.dart';
part 'app_life_cycle_state.dart';

class AppLifeCycleBloc extends Cubit<AppLifeCycleState>
    with WidgetsBindingObserver {
  AppLifeCycleBloc() : super(const AppLifeCycleState.resumed()) {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);

    return super.close();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        safeEmit(const AppLifeCycleState.resumed());
      case AppLifecycleState.paused:
        safeEmit(const AppLifeCycleState.paused());
      case AppLifecycleState.inactive:
        safeEmit(const AppLifeCycleState.inactive());
      case AppLifecycleState.detached:
        safeEmit(const AppLifeCycleState.detached());
      case AppLifecycleState.hidden:
        safeEmit(const AppLifeCycleState.hidden());
    }
  }
}
