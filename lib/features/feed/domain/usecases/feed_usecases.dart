import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/post.dart';
import '../repositories/feed_repository.dart';

class GetPostsParams extends Equatable {
  const GetPostsParams({this.topic = 'For you', this.savedOnly = false});
  final String topic;
  final bool savedOnly;

  @override
  List<Object?> get props => [topic, savedOnly];
}

@injectable
class GetPosts implements UseCase<List<Post>, GetPostsParams> {
  const GetPosts(this._repo);
  final FeedRepository _repo;

  @override
  ResultFuture<List<Post>> call(GetPostsParams p) => _repo.getPosts(topic: p.topic, savedOnly: p.savedOnly);
}

@injectable
class GetPost implements UseCase<Post, String> {
  const GetPost(this._repo);
  final FeedRepository _repo;

  @override
  ResultFuture<Post> call(String id) => _repo.getPost(id);
}

@injectable
class TogglePostLike implements UseCase<void, Post> {
  const TogglePostLike(this._repo);
  final FeedRepository _repo;

  @override
  ResultFuture<void> call(Post p) => _repo.setLiked(p.id, !p.liked);
}

@injectable
class TogglePostSave implements UseCase<void, Post> {
  const TogglePostSave(this._repo);
  final FeedRepository _repo;

  @override
  ResultFuture<void> call(Post p) => _repo.setSaved(p.id, !p.saved);
}

@injectable
class GetComments implements UseCase<List<PostComment>, String> {
  const GetComments(this._repo);
  final FeedRepository _repo;

  @override
  ResultFuture<List<PostComment>> call(String postId) => _repo.getComments(postId);
}

class AddCommentParams extends Equatable {
  const AddCommentParams(this.postId, this.text);
  final String postId;
  final String text;

  @override
  List<Object?> get props => [postId, text];
}

@injectable
class AddComment implements UseCase<PostComment, AddCommentParams> {
  const AddComment(this._repo);
  final FeedRepository _repo;

  @override
  ResultFuture<PostComment> call(AddCommentParams p) async {
    if (p.text.trim().isEmpty) return const Left(ValidationFailure('Write a comment first.'));
    return _repo.addComment(p.postId, p.text.trim());
  }
}

class ToggleCommentLikeParams extends Equatable {
  const ToggleCommentLikeParams(this.postId, this.comment);
  final String postId;
  final PostComment comment;

  @override
  List<Object?> get props => [postId, comment];
}

@injectable
class ToggleCommentLike implements UseCase<void, ToggleCommentLikeParams> {
  const ToggleCommentLike(this._repo);
  final FeedRepository _repo;

  @override
  ResultFuture<void> call(ToggleCommentLikeParams p) => _repo.setCommentLiked(p.postId, p.comment.id, !p.comment.liked);
}

@injectable
class GetMyPosts implements UseCase<List<Post>, NoParams> {
  const GetMyPosts(this._repo);
  final FeedRepository _repo;

  @override
  ResultFuture<List<Post>> call(NoParams _) => _repo.getMyPosts();
}

class PublishPostParams extends Equatable {
  const PublishPostParams(this.post, {this.asDraft = false});
  final NewPost post;
  final bool asDraft;

  @override
  List<Object?> get props => [post, asDraft];
}

@injectable
class PublishPost implements UseCase<Post, PublishPostParams> {
  const PublishPost(this._repo);
  final FeedRepository _repo;

  @override
  ResultFuture<Post> call(PublishPostParams p) async {
    if (p.post.title.trim().isEmpty) return const Left(ValidationFailure('Add a title.'));
    if (!p.asDraft && p.post.body.trim().length < 20) {
      return const Left(ValidationFailure('Write a little more before publishing.'));
    }
    return _repo.publish(p.post, asDraft: p.asDraft);
  }
}
