import 'package:dartx/dartx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/core/domain/model/value_object.dart';
import 'package:shared/features/viewer/domain/model/post_icon.dart';

part 'post_icon.dto.freezed.dart';
part 'post_icon.dto.g.dart';

@freezed
class PostIconDTO with _$PostIconDTO {
  const factory PostIconDTO({
    @JsonKey(name: 'Height') @Default('') String? height,
    @JsonKey(name: 'URL') @Default('') String? url,
    @JsonKey(name: 'Width') @Default('') String? width,
  }) = _PostIconDTO;

  const PostIconDTO._();

  factory PostIconDTO.fromJson(Map<String, dynamic> json) =>
      _$PostIconDTOFromJson(json);

  factory PostIconDTO.fromDomain(PostIcon postIcon) {
    final num height = postIcon.height.getOrCrash();
    final num width = postIcon.width.getOrCrash();
    return PostIconDTO(
      height: height != 0 ? height.toString() : '',
      url: postIcon.url?.getOrCrash() ?? '',
      width: width != 0 ? width.toString() : '',
    );
  }
  PostIcon toDomain() => PostIcon(
        height: Number(height.isNotNullOrBlank ? double.parse(height!) : 0),
        url: url.isNotNullOrBlank ? Url('https://duckduckgo.com/$url') : null,
        width: Number(width.isNotNullOrBlank ? double.parse(width!) : 0),
      );
}
