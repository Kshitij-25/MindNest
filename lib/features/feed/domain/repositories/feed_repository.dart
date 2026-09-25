import '../../../../core/usecase/usecase.dart';
import '../entities/post.dart';

abstract interface class FeedRepository {
  ResultFuture<List<Post>> getPosts({String topic = 'For you', bool savedOnly = false});
  ResultFuture<Post> getPost(String id);
  ResultFuture<void> setLiked(String id, bool liked);
  ResultFuture<void> setSaved(String id, bool saved);
  ResultFuture<List<PostComment>> getComments(String postId);
  ResultFuture<PostComment> addComment(String postId, String text);
  ResultFuture<void> setCommentLiked(String postId, String commentId, bool liked);

  // Authoring (professionals)
  ResultFuture<List<Post>> getMyPosts();
  ResultFuture<Post> publish(NewPost post, {bool asDraft = false});
}
