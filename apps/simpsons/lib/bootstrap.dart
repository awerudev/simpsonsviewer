import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:shared/app/config/url_strategy_native.dart'
    if (dart.library.html) 'package:shared/app/config/url_strategy_web.dart';
import 'package:shared/app/constants/enum.dart';
import 'package:shared/app/observers/app_bloc_observer.dart';
import 'package:shared/app/utils/connectivity_utils.dart';
import 'package:shared/core/domain/bloc/app_life_cycle/app_life_cycle_bloc.dart';
import 'package:shared/core/domain/bloc/theme/theme_bloc.dart';
import 'package:shared/features/viewer/data/repository/post_repository.dart';
import 'package:shared/features/viewer/data/service/post_service.dart';
import 'package:shared/features/viewer/domain/bloc/post/post_bloc.dart';
import 'package:shared/features/viewer/domain/interface/i_post_repository.dart';
import 'package:simpsons/app/config/chopper_config.dart';
import 'package:simpsons/app/generated/assets.gen.dart';
import 'package:simpsons/app/helpers/injection.dart';

// ignore_for_file: prefer-static-class
Future<void> bootstrap(FutureOr<Widget> Function() builder, Env env) async {
  urlConfig();
  initializeSingletons();
  configureSharedDependencies();
  await initializeEnvironmentConfig(env);
  configureDependencies(env);

  final Logger logger = getIt<Logger>();
  Bloc.observer = AppBlocObserver(logger);

  FlutterError.onError = (FlutterErrorDetails details) {
    logger.f(
      details.exceptionAsString(),
      error: details,
      stackTrace: details.stack,
    );
  };
  WidgetsFlutterBinding.ensureInitialized();
  runApp(await builder());
}

void configureSharedDependencies() {
  getIt
    ..registerLazySingleton(AppLifeCycleBloc.new)
    ..registerLazySingleton(ThemeBloc.new)
    ..registerLazySingleton(ConnectivityUtils.new)
    ..registerLazySingleton<PostService>(
      () => getIt<ChopperClient>().getService<PostService>(),
    )
    ..registerLazySingleton<IPostRepository>(
      () => PostRepository(getIt<PostService>()),
    )
    ..registerLazySingleton(() => PostBloc(getIt<IPostRepository>()));
}

void initializeSingletons() {
  getIt
    ..registerLazySingleton<Logger>(
      () => Logger(
        filter: ProductionFilter(),
        printer: PrettyPrinter(),
        output: ConsoleOutput(),
      ),
    )
    ..registerLazySingleton<ChopperClient>(
      () => ChopperConfig.client,
    );
}

Future<void> initializeEnvironmentConfig(Env env) async {
  switch (env) {
    case Env.development:
    case Env.test:
      await dotenv.load(fileName: Assets.env.envDevelopment);
    case Env.staging:
      await dotenv.load(fileName: Assets.env.envStaging);
    case Env.production:
      await dotenv.load(fileName: Assets.env.envProduction);
  }
}
