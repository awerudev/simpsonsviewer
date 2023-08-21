// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef MessageIfAbsent = String Function(
    String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(property) => "${property} is empty";

  static String m1(code, error) => "Error ${code}: ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "common_error_email_format":
            MessageLookupByLibrary.simpleMessage("Invalid email format"),
        "common_error_empty_string": m0,
        "common_error_invalid_password": MessageLookupByLibrary.simpleMessage(
            "Password does not meet the required format"),
        "common_error_max_characters": MessageLookupByLibrary.simpleMessage(
            "Exceeds the number of allowable characters"),
        "common_error_min_characters": MessageLookupByLibrary.simpleMessage(
            "Does not meet the required character length"),
        "common_error_server_error": m1,
        "common_error_unexpected_error":
            MessageLookupByLibrary.simpleMessage("Unexpected Error"),
        "common_generic_error":
            MessageLookupByLibrary.simpleMessage("Oops! Something went wrong"),
        "common_home": MessageLookupByLibrary.simpleMessage("home"),
        "common_no": MessageLookupByLibrary.simpleMessage("no"),
        "common_profile": MessageLookupByLibrary.simpleMessage("profile"),
        "common_yes": MessageLookupByLibrary.simpleMessage("yes"),
        "dialog__message__exit_message": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to close the application?"),
        "post__empty_post__message":
            MessageLookupByLibrary.simpleMessage("No posts available"),
        "post__empty_post_details__message":
            MessageLookupByLibrary.simpleMessage("Select a character"),
        "post__search_bar__label":
            MessageLookupByLibrary.simpleMessage("Search")
      };
}
