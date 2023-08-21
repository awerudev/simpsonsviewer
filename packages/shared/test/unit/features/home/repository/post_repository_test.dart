import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared/core/domain/model/failure.dart';
import 'package:shared/features/viewer/data/model/post.dto.dart';
import 'package:shared/features/viewer/data/repository/post_repository.dart';
import 'package:shared/features/viewer/data/service/post_service.dart';
import 'package:shared/features/viewer/domain/model/post.dart';

import '../../../../utils/test_utils.dart';
import 'post_repository_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<dynamic>>[MockSpec<PostService>()])
void main() {
  late MockPostService postService;
  late PostRepository postRepository;
  late PostDTO postDTO;
  late String query;
  late Map<String, dynamic> mockJsonPost;

  setUp(() {
    postService = MockPostService();
    postRepository = PostRepository(postService);
    postDTO = mockPostDTO;
    query = 'keywords';
    mockJsonPost = <String, dynamic>{
      'FirstURL': 'https://duckduckgo.com/',
      'Icon': <String, String>{
        'Height': '',
        'URL': '',
        'Width': '',
      },
      'Result': 'result',
      'Text': 'text',
    };
  });

  group('Get Posts', () {
    test(
      'should return a list of posts',
      () async {
        final Map<String, dynamic> data = <String, dynamic>{
          'RelatedTopics': <Map<String, dynamic>>[
            mockJsonPost,
            mockJsonPost,
          ],
        };
        provideDummy<chopper.Response<dynamic>>(
          generateMockResponse<Map<String, dynamic>>(data, 200),
        );
        when(postService.getPosts(query)).thenAnswer(
          (_) async => generateMockResponse<Map<String, dynamic>>(data, 200),
        );

        final Either<Failure, List<Post>> result =
            await postRepository.getPosts(query);

        expect(result.isRight(), true);
      },
    );

    test(
      'should return a invalid value failure',
      () async {
        final Map<String, dynamic> data = <String, dynamic>{
          'RelatedTopics': <Map<String, dynamic>>[
            mockJsonPost,
            <String, dynamic>{
              'FirstURL': '1',
              'Icon': <String, String>{
                'Height': '',
                'URL': '',
                'Width': '',
              },
              'Result': 'result',
              'Text': 'text',
            },
          ],
        };
        provideDummy<chopper.Response<dynamic>>(
          generateMockResponse<Map<String, dynamic>>(data, 200),
        );
        when(postService.getPosts(query)).thenAnswer(
          (_) async => generateMockResponse<Map<String, dynamic>>(data, 200),
        );

        final Either<Failure, List<Post>> result =
            await postRepository.getPosts(query);

        expect(result.isLeft(), true);
      },
    );

    test(
      'should return a failure when a server error occurs',
      () async {
        final Map<String, dynamic> data = <String, dynamic>{
          'RelatedTopics': <Map<String, dynamic>>[
            postDTO.toJson(),
            postDTO.toJson(),
          ],
        };
        provideDummy<chopper.Response<dynamic>>(
          generateMockResponse<Map<String, dynamic>>(data, 500),
        );
        when(postService.getPosts(query)).thenAnswer(
          (_) async => generateMockResponse<Map<String, dynamic>>(data, 500),
        );

        final Either<Failure, List<Post>> result =
            await postRepository.getPosts(query);

        expect(result.isLeft(), true);
      },
    );
    test(
      'should return a failure when an unexpected error occurs',
      () async {
        when(postService.getPosts(query)).thenThrow(throwsException);

        final Either<Failure, List<Post>> result =
            await postRepository.getPosts(query);

        expect(result.isLeft(), true);
      },
    );
  });
}
