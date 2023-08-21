import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/core/domain/model/failure.dart';
import 'package:shared/core/domain/model/value_object.dart';
import 'package:shared/features/viewer/domain/model/post_icon.dart';

part 'post.freezed.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required Url firstUrl,
    required PostIcon icon,
    required ValueString result,
    required ValueString text,
  }) = _Post;

  const Post._();

  Option<Failure> get failureOption => firstUrl.failureOrUnit
      .andThen(() => icon.failureOption.fold(() => right(unit), Either.left))
      .andThen(() => result.failureOrUnit)
      .andThen(() => text.failureOrUnit)
      .fold(some, (_) => none());

  String get character => text.getOrCrash().split('-')[0].trim();
  String get description =>
      text.getOrCrash().split('-').sublist(1).join('-').trim();
}
