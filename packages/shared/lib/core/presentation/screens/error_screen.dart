import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/app/helpers/extensions.dart';
import 'package:shared/app/themes/app_spacing.dart';

class ErrorScreen extends HookWidget {
  const ErrorScreen({
    required this.onRefresh,
    required this.errorMessage,
    super.key,
  });

  final Future<void> Function()? onRefresh;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) => onRefresh != null
      ? RefreshIndicator(
          onRefresh: onRefresh!,
          child: _ErrorContent(errorMessage: errorMessage),
        )
      : _ErrorContent(errorMessage: errorMessage);
}

class _ErrorContent extends StatelessWidget {
  const _ErrorContent({
    required this.errorMessage,
  });

  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final Color textColor = context.colorScheme.onSurface;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error, size: 50, color: context.colorScheme.error),
          Padding(
            padding:
                const EdgeInsets.only(top: Insets.small, bottom: Insets.xsmall),
            child: Text(
              context.commonL10n.common_generic_error,
              style: context.textTheme.titleMedium?.copyWith(color: textColor),
            ),
          ),
          if (kDebugMode && (errorMessage?.isNotNullOrBlank ?? false))
            FractionallySizedBox(
              widthFactor: 0.5,
              child: Text(
                errorMessage!,
                style: context.textTheme.titleSmall?.copyWith(color: textColor),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
