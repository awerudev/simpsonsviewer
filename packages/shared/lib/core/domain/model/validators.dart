import 'package:dartx/dartx.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/core/domain/model/failure.dart';

// ignore_for_file: prefer-static-class

Either<Failure, String> validateLink(String url) => Uri.parse(url).isAbsolute
    ? right(url)
    : left(Failure.invalidUrl(failedValue: url));

Either<Failure, String> validateStringEmpty(String input, String property) =>
    input.isNotNullOrBlank
        ? right(input)
        : left(Failure.emptyString(property: property));

Either<Failure, num> validateNegativeNumber(num value) =>
    value >= 0 ? right(value) : left(Failure.invalidValue(failedValue: value));
