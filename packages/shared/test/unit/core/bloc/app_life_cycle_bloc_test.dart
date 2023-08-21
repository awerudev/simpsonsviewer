import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared/core/domain/bloc/app_life_cycle/app_life_cycle_bloc.dart';

// ignore_for_file: no-empty-block
void main() {
  setUp(TestWidgetsFlutterBinding.ensureInitialized);
  void setAppLifeCycleState(AppLifecycleState state) {
    final ByteData? message =
        const StringCodec().encodeMessage(state.toString());
    ServicesBinding.instance.channelBuffers
        .push('flutter/lifecycle', message, (_) {});
  }

  blocTest<AppLifeCycleBloc, AppLifeCycleState>(
    'should emit a paused lifecycle state',
    build: AppLifeCycleBloc.new,
    act: (AppLifeCycleBloc bloc) =>
        setAppLifeCycleState(AppLifecycleState.paused),
    expect: () => <dynamic>[const AppLifeCycleState.paused()],
  );

  blocTest<AppLifeCycleBloc, AppLifeCycleState>(
    'should emit a resumed lifecycle state',
    build: AppLifeCycleBloc.new,
    act: (AppLifeCycleBloc bloc) =>
        setAppLifeCycleState(AppLifecycleState.resumed),
    expect: () => <dynamic>[
      const AppLifeCycleState.hidden(),
      const AppLifeCycleState.inactive(),
      const AppLifeCycleState.resumed(),
    ],
  );

  blocTest<AppLifeCycleBloc, AppLifeCycleState>(
    'should emit a detached lifecycle state',
    build: AppLifeCycleBloc.new,
    act: (AppLifeCycleBloc bloc) =>
        setAppLifeCycleState(AppLifecycleState.detached),
    expect: () => <dynamic>[],
  );

  blocTest<AppLifeCycleBloc, AppLifeCycleState>(
    'should emit a hidden lifecycle state',
    build: AppLifeCycleBloc.new,
    act: (AppLifeCycleBloc bloc) =>
        setAppLifeCycleState(AppLifecycleState.hidden),
    expect: () => <dynamic>[
      const AppLifeCycleState.inactive(),
      const AppLifeCycleState.hidden(),
    ],
  );

  blocTest<AppLifeCycleBloc, AppLifeCycleState>(
    'should emit a inactive lifecycle state',
    build: AppLifeCycleBloc.new,
    act: (AppLifeCycleBloc bloc) =>
        setAppLifeCycleState(AppLifecycleState.inactive),
    expect: () => <dynamic>[const AppLifeCycleState.inactive()],
  );
}
