import 'package:chopper/chopper.dart';

part 'post_service.chopper.dart';

@ChopperApi(baseUrl: '')
abstract interface class PostService extends ChopperService {
  @Get(path: '')
  Future<Response<dynamic>> getPosts(
    @Query() String q, {
    @Query('format') String format = 'json',
  });

  static PostService create() => _$PostService();
}
