part of 'app_life_cycle_bloc.dart';

@freezed
class AppLifeCycleState with _$AppLifeCycleState {
  const factory AppLifeCycleState.detached() = _Detached;
  const factory AppLifeCycleState.inactive() = _Inactive;
  const factory AppLifeCycleState.paused() = _Paused;
  const factory AppLifeCycleState.resumed() = _Resumed;
  const factory AppLifeCycleState.hidden() = _Hidden;

  const AppLifeCycleState._();
}
