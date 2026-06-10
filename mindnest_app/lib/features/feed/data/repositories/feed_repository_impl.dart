import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/error_mapper.dart';
import 'package:mindnest_app/core/error/result.dart';
import 'package:mindnest_app/core/network/wellness_api.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';

import '../../domain/entities/post.dart';
import '../../domain/repositories/feed_repository.dart';

@LazySingleton(as: FeedRepository)
class FeedRepositoryImpl implements FeedRepository {
  FeedRepositoryImpl();

  static String _s(Object? v, [String d = '']) => v is String ? v : d;

  /// Curated library article → the feed's [Post] shape (read-only, no social).
  Post _fromJson(Map<String, dynamic> j) => Post(
    id: _s(j['id']),
    authorId: 'mindnest',
    authorName: _s(j['source'], 'MindNest Library'),
    authorTitle: _s(j['category'], 'Wellness'),
    topic: _s(j['topic']),
    time: '',
    image: j['image'] == true,
    read: j['readMinutes'] is num ? (j['readMinutes'] as num).toInt() : 3,
    likes: 0,
    comments: 0,
    title: _s(j['title']),
    body: _s(j['body']),
    saved: false,
    liked: false,
  );

  @override
  Future<Result<List<Post>>> getPosts() async {
    try {
      final raw = await wellnessApi.library();
      return Ok(raw.map(_fromJson).toList());
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }

  @override
  Future<Result<Post>> getPost(String id) async {
    try {
      return Ok(_fromJson(await wellnessApi.libraryArticle(id)));
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }

  // Library content is read-only — no comments in MVP 1.
  @override
  Future<Result<List<PostComment>>> getComments(String postId) async =>
      const Ok(<PostComment>[]);

  @override
  Future<Result<Unit>> addComment(String postId, String text) async =>
      const Ok(unit);
}
