import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared/app/constants/enum.dart';
import 'package:shared/core/domain/model/failure.dart';
import 'package:shared/features/viewer/data/model/post.dto.dart';
import 'package:shared/features/viewer/data/model/post_icon.dto.dart';
import 'package:shared/features/viewer/domain/bloc/post/post_bloc.dart';
import 'package:shared/features/viewer/domain/interface/i_post_repository.dart';
import 'package:shared/features/viewer/domain/model/post.dart';

import 'post_bloc_test.mocks.dart';

@GenerateNiceMocks(
  <MockSpec<dynamic>>[
    MockSpec<IPostRepository>(),
  ],
)
void main() {
  late MockIPostRepository postRepository;

  late Failure failure;
  List<Post> posts = <Post>[];
  const String query = 'keywords';

  setUp(() {
    postRepository = MockIPostRepository();
    failure =
        const Failure.serverError(StatusCode.http500, 'INTERNAL SERVER ERROR');

    posts = <Post>[
      const PostDTO(
        firstUrl: 'https://duckduckgo.com/',
        icon: PostIconDTO(),
        result: 'result',
        text: 'text',
      ).toDomain(),
      const PostDTO(
        firstUrl: 'https://duckduckgo.com/',
        icon: PostIconDTO(),
        result: 'abc',
        text: 'abc text',
      ).toDomain(),
    ];
  });

  group('PostBloc getPosts', () {
    blocTest<PostBloc, PostState>(
      'should emit a success state with list of posts',
      setUp: () {
        provideDummy(
          Either<Failure, List<Post>>.right(posts),
        );
        when(postRepository.getPosts(query))
            .thenAnswer((_) async => Either<Failure, List<Post>>.right(posts));
      },
      build: () => PostBloc(postRepository),
      act: (PostBloc bloc) => bloc.getPosts(query),
      expect: () => <PostState>[
        const PostState.loading(),
        PostState.success(allPost: posts, filtered: <Post>[]),
      ],
    );
    blocTest<PostBloc, PostState>(
      'should emit a failed state with posts from local storage ',
      setUp: () {
        provideDummy(
          Either<Failure, List<Post>>.left(failure),
        );
        when(postRepository.getPosts(query))
            .thenAnswer((_) async => Either<Failure, List<Post>>.left(failure));
      },
      build: () => PostBloc(postRepository),
      act: (PostBloc bloc) => bloc.getPosts(query),
      expect: () =>
          <PostState>[const PostState.loading(), PostState.failed(failure)],
    );

    blocTest<PostBloc, PostState>(
      'should emit a failed state with throwsException error ',
      setUp: () {
        when(postRepository.getPosts(query)).thenThrow(throwsException);
      },
      build: () => PostBloc(postRepository),
      act: (PostBloc bloc) => bloc.getPosts(query),
      expect: () => <PostState>[
        const PostState.loading(),
        PostState.failed(
          Failure.unexpected(throwsException.toString()),
        ),
      ],
    );
  });

  group('onSearch', () {
    blocTest<PostBloc, PostState>(
      'should emit a filtered posts ',
      setUp: () {
        provideDummy(
          Either<Failure, List<Post>>.right(posts),
        );
        when(postRepository.getPosts(query))
            .thenAnswer((_) async => Either<Failure, List<Post>>.right(posts));
      },
      build: () => PostBloc(postRepository),
      seed: () => PostState.success(
        allPost: posts,
        filtered: <Post>[],
      ),
      act: (PostBloc bloc) => bloc.onSearch('abc'),
      expect: () => <PostState>[
        PostState.success(
          allPost: posts,
          filtered: <Post>[
            const PostDTO(
              firstUrl: 'https://duckduckgo.com/',
              icon: PostIconDTO(),
              result: 'abc',
              text: 'abc text',
            ).toDomain(),
          ],
        ),
      ],
    );
  });
}
