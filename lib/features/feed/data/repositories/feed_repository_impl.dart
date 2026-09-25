import 'package:injectable/injectable.dart';

import '../../../../core/error/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/feed_repository.dart';
import '../datasources/feed_data_source.dart';
import '../models/post_model.dart';

@LazySingleton(as: FeedRepository)
class FeedRepositoryImpl implements FeedRepository {
  const FeedRepositoryImpl(this._ds, this._auth);
  final FeedDataSource _ds;
  final AuthRepository _auth;

  @override
  ResultFuture<List<Post>> getPosts({String topic = 'For you', bool savedOnly = false}) => guard(() async =>
      (await _ds.posts())
          .where((p) => topic == 'For you' || p.topic == topic)
          .where((p) => !savedOnly || p.saved)
          .map((p) => p.toEntity())
          .toList());

  @override
  ResultFuture<Post> getPost(String id) => guard(() async => (await _ds.post(id)).toEntity());

  @override
  ResultFuture<void> setLiked(String id, bool liked) => guard(() => _ds.setLiked(id, liked));

  @override
  ResultFuture<void> setSaved(String id, bool saved) => guard(() => _ds.setSaved(id, saved));

  @override
  ResultFuture<List<PostComment>> getComments(String postId) =>
      guard(() async => (await _ds.comments(postId)).map((c) => c.toEntity()).toList());

  @override
  ResultFuture<PostComment> addComment(String postId, String text) => guard(() async {
        final name = _auth.cachedUser?.name ?? 'You';
        final parts = name.split(' ');
        final short = parts.length > 1 ? '${parts.first} ${parts.last[0]}.' : name;
        return (await _ds.addComment(postId, short, text)).toEntity();
      });

  @override
  ResultFuture<void> setCommentLiked(String postId, String commentId, bool liked) =>
      guard(() => _ds.setCommentLiked(postId, commentId, liked));

  @override
  ResultFuture<List<Post>> getMyPosts() => guard(() async => (await _ds.myPosts()).map((p) => p.toEntity()).toList());

  @override
  ResultFuture<Post> publish(NewPost p, {bool asDraft = false}) => guard(() async => (await _ds.create(PostModel(
        id: '',
        author: const PostAuthorModel(id: '', name: '', title: '', spec: ''),
        topic: p.topic,
        title: p.title.trim(),
        body: p.body.trim(),
        publishedAt: DateTime.now(),
        image: p.hasImage,
        status: asDraft ? PostStatus.draft : PostStatus.published,
      )))
          .toEntity());
}
