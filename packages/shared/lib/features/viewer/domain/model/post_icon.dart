import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/core/domain/model/failure.dart';
import 'package:shared/core/domain/model/value_object.dart';

part 'post_icon.freezed.dart';

@freezed
class PostIcon with _$PostIcon {
  const factory PostIcon({
    required Number height,
    required Number width,
    Url? url,
  }) = _PostIcon;

  const PostIcon._();

  Option<Failure> get failureOption => height.failureOrUnit
      .andThen(() => url?.failureOrUnit ?? right(unit))
      .andThen(() => width.failureOrUnit)
      .fold(some, (_) => none());
}
