import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/app/constants/enum.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.emptyString({required String? property}) = EmptyString;

  const factory Failure.invalidValue({required dynamic failedValue}) =
      InvalidValue;

  const factory Failure.invalidUrl({required String failedValue}) = InvalidUrl;

  const factory Failure.unexpected(String? error) = UnexpectedError;

  const factory Failure.serverError(StatusCode code, String? error) =
      ServerError;
}
