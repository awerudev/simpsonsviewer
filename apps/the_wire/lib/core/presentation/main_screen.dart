import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/app/helpers/extensions.dart';
import 'package:shared/app/themes/app_theme.dart';
import 'package:shared/app/utils/connectivity_utils.dart';
import 'package:shared/app/utils/dialog_utils.dart';
import 'package:shared/core/presentation/widgets/connectivity_checker.dart';
import 'package:shared/core/presentation/widgets/shared_app_bar.dart';
import 'package:the_wire/app/constants/constant.dart';
import 'package:the_wire/app/helpers/injection.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    required this.child,
    super.key,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () => DialogUtils.showExitDialog(context),
        child: ConnectivityChecker.scaffold(
          connectivityUtils: getIt<ConnectivityUtils>(),
          backgroundColor: context.colorScheme.background,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(AppTheme.defaultAppBarHeight),
            child: SharedAppBar(
              backgroundColor: context.colorScheme.primary,
              titleColor: context.colorScheme.onPrimary,
              title: Constant.appName,
              leading: GoRouter.of(context).location.contains('/viewer/')
                  ? BackButton(
                      color: context.colorScheme.onPrimary,
                      onPressed: () => GoRouter.of(context).canPop()
                          ? GoRouter.of(context).pop()
                          : null,
                    )
                  : null,
            ),
          ),
          body: Center(
            child: child,
          ),
        ),
      );
}
