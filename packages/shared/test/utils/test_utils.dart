import 'dart:convert';

import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;
import 'package:shared/features/viewer/data/model/post.dto.dart';
import 'package:shared/features/viewer/data/model/post_icon.dto.dart';
import 'package:shared/features/viewer/domain/model/post.dart';

PostDTO get mockPostDTO => const PostDTO(
      firstUrl: 'https://duckduckgo.com/',
      icon: PostIconDTO(),
      result: 'result',
      text: 'text',
    );

Post get mockPost => mockPostDTO.toDomain();

List<Post> get mockPosts => <Post>[
      mockPost,
      mockPost,
    ];

chopper.Response<T> generateMockResponse<T>(T body, int statusCode) =>
    chopper.Response<T>(http.Response(json.encode(body), statusCode), body);
