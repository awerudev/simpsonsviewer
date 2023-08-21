import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared/app/helpers/extensions.dart';
import 'package:shared/core/domain/model/failure.dart';

// ignore_for_file: avoid_dynamic_calls
final class ErrorMessageUtils {
  static String generate(BuildContext context, dynamic error) {
    if (error is String) {
      return error;
    } else if (error is Failure) {
      if (error is ServerError) {
        return _parseMessage(context, error);
      } else if (error is UnexpectedError) {
        return error.error ?? context.commonL10n.common_error_unexpected_error;
      } else if (error is EmptyString) {
        return context.commonL10n
            .common_error_empty_string(error.property.toString());
      } else {
        return errorString(error);
      }
    } else {
      return errorString(error);
    }
  }

  static String errorString(dynamic error) {
    final String errorString = error.toString();

    return errorString != 'null' ? errorString : '';
  }

  static String _parseMessage(BuildContext context, dynamic error) {
    try {
      final Map<String, dynamic> object =
          jsonDecode(error.error?.toString() ?? '{}') as Map<String, dynamic>;
      final String errorCode = error.code.value.toString();
      return switch (object) {
        {'message': final String message} =>
          context.commonL10n.common_error_server_error(errorCode, message),
        {'error': final String errorMessage} =>
          context.commonL10n.common_error_server_error(
            errorCode,
            errorMessage,
          ),
        _ => context.commonL10n.common_error_server_error(
            errorCode,
            error.error.toString(),
          )
      };
    } catch (e) {
      return e.toString();
    }
  }
}
