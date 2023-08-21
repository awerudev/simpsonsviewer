part of 'post_bloc.dart';

@freezed
class PostState with _$PostState {
  const factory PostState.initial() = _Initial;
  const factory PostState.loading() = _Loading;
  const factory PostState.success({
    required List<Post> allPost,
    required List<Post> filtered,
  }) = PostSuccess;

  const factory PostState.failed(Failure failure) = PostFailure;

  const PostState._();
}
