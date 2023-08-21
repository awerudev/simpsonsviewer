import 'dart:developer';

import 'package:dartx/dartx.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/app/helpers/extensions.dart';
import 'package:shared/core/domain/model/failure.dart';
import 'package:shared/features/viewer/domain/interface/i_post_repository.dart';
import 'package:shared/features/viewer/domain/model/post.dart';

part 'post_bloc.freezed.dart';
part 'post_state.dart';

class PostBloc extends Cubit<PostState> {
  PostBloc(
    this._postRepository,
  ) : super(const PostState.initial());

  final IPostRepository _postRepository;

  Future<void> getPosts(String keyword) async {
    try {
      safeEmit(const PostState.loading());

      final Either<Failure, List<Post>> possibleFailure =
          await _postRepository.getPosts(keyword);

      safeEmit(
        possibleFailure.fold(
          PostState.failed,
          (List<Post> posts) =>
              PostState.success(allPost: posts, filtered: <Post>[]),
        ),
      );
    } catch (error) {
      log(error.toString());

      safeEmit(
        PostState.failed(
          Failure.unexpected(error.toString()),
        ),
      );
    }
  }

  void onSearch(String keyword) {
    state.mapOrNull(
      success: (PostSuccess successState) {
        keyword.isNotNullOrBlank
            ? safeEmit(
                successState.copyWith(
                  filtered: _searchPost(successState.allPost, keyword),
                ),
              )
            : safeEmit(successState.copyWith(filtered: <Post>[]));
      },
    );
  }

  List<Post> _searchPost(List<Post> posts, String keyword) {
    final List<Post> filtered = posts.where((Post element) {
      final String searchText = element.character.toLowerCase();
      final String searchResult = element.description.toLowerCase();

      return searchText.contains(keyword.toLowerCase()) ||
          searchResult.contains(keyword.toLowerCase());
    }).toList();
    return filtered;
  }
}
