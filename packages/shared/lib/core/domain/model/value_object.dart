import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/core/domain/model/failure.dart';
import 'package:shared/core/domain/model/validators.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  @override
  int get hashCode => value.hashCode;

  Either<Failure, T> get value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueObject<T> && other.value == value;
  }

  Either<Failure, Unit> get failureOrUnit =>
      value.fold(left, (T r) => right(unit));

  T getOrCrash() => value.fold(
        (Failure failure) => throw Exception(failure.toString()),
        identity,
      );

  bool isValid() => value.isRight();

  @override
  String toString() => 'Value:$value';
}

class Url extends ValueObject<String> {
  factory Url(String input) => Url._(
        validateLink(input) // try uri parsing of the input
            .andThen(
          () => validateStringEmpty(input, 'URL'),
        ), // must not be empty
      );
  const Url._(this.value);
  @override
  final Either<Failure, String> value;
}

class Number extends ValueObject<num> {
  factory Number([num? input]) => Number._(
        validateNegativeNumber(input ?? 0),
      );
  const Number._(this.value); // must only contain positive numbers
  @override
  final Either<Failure, num> value;
}

class ValueString extends ValueObject<String> {
  factory ValueString([String? input]) => ValueString._(right(input ?? ''));
  const ValueString._(this.value);
  @override
  final Either<Failure, String> value;
}
