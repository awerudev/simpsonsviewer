import 'package:fpdart/fpdart.dart';
import 'package:shared/core/domain/model/failure.dart';
import 'package:shared/features/viewer/domain/model/post.dart';

abstract interface class IPostRepository {
  Future<Either<Failure, List<Post>>> getPosts(String keyword);
}
