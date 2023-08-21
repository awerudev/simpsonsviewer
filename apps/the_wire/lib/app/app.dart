import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared/app/config/scroll_behavior_config.dart';
import 'package:shared/app/constants/shared_constant.dart';
import 'package:shared/app/generated/l10n.dart';
import 'package:shared/app/themes/app_theme.dart';
import 'package:shared/core/domain/bloc/app_life_cycle/app_life_cycle_bloc.dart';
import 'package:shared/core/domain/bloc/theme/theme_bloc.dart';
import 'package:shared/features/viewer/domain/bloc/post/post_bloc.dart';
import 'package:the_wire/app/constants/constant.dart';
import 'package:the_wire/app/generated/l10n.dart';
import 'package:the_wire/app/helpers/injection.dart';
import 'package:the_wire/app/routes/app_router.dart';

// ignore_for_file: avoid-returning-widgets
class App extends StatelessWidget {
  App({super.key});

  final AppRouter appRouter = getIt<AppRouter>(
    param1: getIt<PostBloc>()..getPosts('the wire characters'),
  );

  List<BlocProvider<dynamic>> get providers => <BlocProvider<dynamic>>[
        BlocProvider<ThemeBloc>(
          create: (BuildContext context) => getIt<ThemeBloc>(),
        ),
        BlocProvider<AppLifeCycleBloc>(
          create: (BuildContext context) => getIt<AppLifeCycleBloc>(),
        ),
        BlocProvider<PostBloc>(
          create: (BuildContext context) => getIt<PostBloc>(),
        ),
      ];

  List<ResponsiveBreakpoint> get breakpoints => <ResponsiveBreakpoint>[
        const ResponsiveBreakpoint.autoScaleDown(
          SharedConstant.mobileBreakpoint,
          name: PHONE,
        ),
        const ResponsiveBreakpoint.resize(
          SharedConstant.mobileBreakpoint,
          name: MOBILE,
        ),
        const ResponsiveBreakpoint.resize(
          SharedConstant.tabletBreakpoint,
          name: TABLET,
        ),
        const ResponsiveBreakpoint.resize(
          SharedConstant.desktopBreakpoint,
          name: DESKTOP,
        ),
      ];

  List<LocalizationsDelegate<dynamic>> get localizationsDelegates =>
      <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        SharedLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: providers,
        child: BlocBuilder<ThemeBloc, ThemeMode>(
          builder: (BuildContext context, ThemeMode themeMode) =>
              MaterialApp.router(
            routerConfig: appRouter.router,
            builder: (BuildContext context, Widget? child) =>
                ResponsiveWrapper.builder(
              child,
              minWidth: SharedConstant.mobileBreakpoint,
              breakpoints: breakpoints,
            ),
            title: Constant.appName,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            localizationsDelegates: localizationsDelegates,
            supportedLocales: AppLocalizations.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            scrollBehavior: ScrollBehaviorConfig(),
          ),
        ),
      );
}
