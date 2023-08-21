import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:shared/app/constants/enum.dart';
import 'package:shared/app/helpers/extensions.dart';
import 'package:shared/app/themes/app_spacing.dart';
import 'package:shared/app/utils/connectivity_utils.dart';

// ignore_for_file: long-parameter-list
class ConnectivityChecker extends StatefulWidget {
  const ConnectivityChecker({
    required this.child,
    required this.connectivityUtils,
    super.key,
  });

  final Widget child;
  final ConnectivityUtils connectivityUtils;

  static Widget scaffold({
    required Widget body,
    required ConnectivityUtils connectivityUtils,
    PreferredSizeWidget? appBar,
    Widget? bottomNavigationBar,
    Color? backgroundColor,
  }) =>
      ConnectivityChecker(
        connectivityUtils: connectivityUtils,
        child: Scaffold(
          body: body,
          appBar: appBar,
          backgroundColor: backgroundColor,
          bottomNavigationBar: bottomNavigationBar,
        ),
      );

  @override
  State<ConnectivityChecker> createState() => _ConnectivityCheckerState();
}

class _ConnectivityCheckerState extends State<ConnectivityChecker> {
  StreamSubscription<ConnectionStatus>? _connectionSubscription;
  bool _isDialogShowing = false;
  FlashController<void>? _controller;

  Future<void> _showOfflineDialog(BuildContext context) async {
    await showFlash<void>(
      context: context,
      builder: (BuildContext context, FlashController<void> controller) {
        _controller = controller;
        return FlashBar<void>(
          controller: controller,
          elevation: 3,
          backgroundColor: context.colorScheme.background,
          surfaceTintColor: context.colorScheme.surfaceTint,
          indicatorColor: context.colorScheme.error,
          icon: Icon(Icons.wifi_off, color: context.colorScheme.onSurface),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
            child: Text(
              ConnectionStatus.offline.name.capitalize(),
              style: TextStyle(color: context.colorScheme.onBackground),
            ),
          ),
        );
      },
    );
  }

  Future<void> _onStatusChanged(ConnectionStatus connectionStatus) async {
    switch (connectionStatus) {
      case ConnectionStatus.offline:
        if (!_isDialogShowing) {
          _isDialogShowing = true;
          await _showOfflineDialog(context);
          _isDialogShowing = false;
        }
      case ConnectionStatus.online:
        if (_isDialogShowing) {
          await _controller?.dismiss();
          _isDialogShowing = false;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _onStatusChanged(await widget.connectivityUtils.checkInternet());

      _connectionSubscription ??= widget.connectivityUtils
          .internetStatus()
          .listen((ConnectionStatus event) async {
        await _onStatusChanged(event);
      });
    });

    return widget.child;
  }

  @override
  void dispose() {
    _connectionSubscription?.cancel();
    super.dispose();
  }
}
