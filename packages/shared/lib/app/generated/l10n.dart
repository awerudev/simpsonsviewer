// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class SharedLocalizations {
  SharedLocalizations();

  static SharedLocalizations? _current;

  static SharedLocalizations get current {
    assert(_current != null,
        'No instance of SharedLocalizations was loaded. Try to initialize the SharedLocalizations delegate before accessing SharedLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<SharedLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = SharedLocalizations();
      SharedLocalizations._current = instance;

      return instance;
    });
  }

  static SharedLocalizations of(BuildContext context) {
    final instance = SharedLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of SharedLocalizations present in the widget tree. Did you add SharedLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static SharedLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<SharedLocalizations>(context, SharedLocalizations);
  }

  /// `Invalid email format`
  String get common_error_email_format {
    return Intl.message(
      'Invalid email format',
      name: 'common_error_email_format',
      desc: '',
      args: [],
    );
  }

  /// `{property} is empty`
  String common_error_empty_string(Object property) {
    return Intl.message(
      '$property is empty',
      name: 'common_error_empty_string',
      desc: '',
      args: [property],
    );
  }

  /// `Password does not meet the required format`
  String get common_error_invalid_password {
    return Intl.message(
      'Password does not meet the required format',
      name: 'common_error_invalid_password',
      desc: '',
      args: [],
    );
  }

  /// `Exceeds the number of allowable characters`
  String get common_error_max_characters {
    return Intl.message(
      'Exceeds the number of allowable characters',
      name: 'common_error_max_characters',
      desc: '',
      args: [],
    );
  }

  /// `Does not meet the required character length`
  String get common_error_min_characters {
    return Intl.message(
      'Does not meet the required character length',
      name: 'common_error_min_characters',
      desc: '',
      args: [],
    );
  }

  /// `Error {code}: {error}`
  String common_error_server_error(Object code, Object error) {
    return Intl.message(
      'Error $code: $error',
      name: 'common_error_server_error',
      desc: '',
      args: [code, error],
    );
  }

  /// `Unexpected Error`
  String get common_error_unexpected_error {
    return Intl.message(
      'Unexpected Error',
      name: 'common_error_unexpected_error',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong`
  String get common_generic_error {
    return Intl.message(
      'Oops! Something went wrong',
      name: 'common_generic_error',
      desc: '',
      args: [],
    );
  }

  /// `home`
  String get common_home {
    return Intl.message(
      'home',
      name: 'common_home',
      desc: '',
      args: [],
    );
  }

  /// `no`
  String get common_no {
    return Intl.message(
      'no',
      name: 'common_no',
      desc: '',
      args: [],
    );
  }

  /// `profile`
  String get common_profile {
    return Intl.message(
      'profile',
      name: 'common_profile',
      desc: '',
      args: [],
    );
  }

  /// `yes`
  String get common_yes {
    return Intl.message(
      'yes',
      name: 'common_yes',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to close the application?`
  String get dialog__message__exit_message {
    return Intl.message(
      'Are you sure you want to close the application?',
      name: 'dialog__message__exit_message',
      desc: '',
      args: [],
    );
  }

  /// `No posts available`
  String get post__empty_post__message {
    return Intl.message(
      'No posts available',
      name: 'post__empty_post__message',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get post__search_bar__label {
    return Intl.message(
      'Search',
      name: 'post__search_bar__label',
      desc: '',
      args: [],
    );
  }

  /// `Select a character`
  String get post__empty_post_details__message {
    return Intl.message(
      'Select a character',
      name: 'post__empty_post_details__message',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate
    extends LocalizationsDelegate<SharedLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<SharedLocalizations> load(Locale locale) =>
      SharedLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
