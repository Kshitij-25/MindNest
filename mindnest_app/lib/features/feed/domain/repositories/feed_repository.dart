import 'package:mindnest_app/core/error/result.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';

import '../entities/post.dart';

abstract interface class FeedRepository {
  Future<Result<List<Post>>> getPosts();
  Future<Result<Post>> getPost(String id);
  Future<Result<List<PostComment>>> getComments(String postId);
  Future<Result<Unit>> addComment(String postId, String text);
}
