import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/core/domain/model/value_object.dart';
import 'package:shared/features/viewer/data/model/post_icon.dto.dart';
import 'package:shared/features/viewer/domain/model/post.dart';

part 'post.dto.freezed.dart';
part 'post.dto.g.dart';

@freezed
class PostDTO with _$PostDTO {
  const factory PostDTO({
    @JsonKey(name: 'FirstURL') required String firstUrl,
    @JsonKey(name: 'Icon') required PostIconDTO icon,
    @JsonKey(name: 'Result') required String result,
    @JsonKey(name: 'Text') required String text,
  }) = _PostDTO;

  const PostDTO._();

  factory PostDTO.fromJson(Map<String, dynamic> json) =>
      _$PostDTOFromJson(json);

  factory PostDTO.fromDomain(Post post) => PostDTO(
        firstUrl: post.firstUrl.getOrCrash(),
        icon: PostIconDTO.fromDomain(post.icon),
        result: post.result.getOrCrash(),
        text: post.text.getOrCrash(),
      );

  Post toDomain() => Post(
        firstUrl: Url(firstUrl),
        icon: icon.toDomain(),
        result: ValueString(result),
        text: ValueString(text),
      );
}
