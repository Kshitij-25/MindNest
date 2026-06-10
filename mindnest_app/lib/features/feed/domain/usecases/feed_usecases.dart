import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/result.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';

import '../entities/post.dart';
import '../repositories/feed_repository.dart';

@lazySingleton
class GetPosts implements UseCase<List<Post>, NoParams> {
  GetPosts(this._repo);
  final FeedRepository _repo;
  @override
  Future<Result<List<Post>>> call(NoParams params) => _repo.getPosts();
}

@lazySingleton
class GetPost implements UseCase<Post, String> {
  GetPost(this._repo);
  final FeedRepository _repo;
  @override
  Future<Result<Post>> call(String id) => _repo.getPost(id);
}

@lazySingleton
class GetComments implements UseCase<List<PostComment>, String> {
  GetComments(this._repo);
  final FeedRepository _repo;
  @override
  Future<Result<List<PostComment>>> call(String postId) =>
      _repo.getComments(postId);
}

class AddCommentParams extends Equatable {
  const AddCommentParams(this.postId, this.text);
  final String postId, text;
  @override
  List<Object?> get props => [postId, text];
}

@lazySingleton
class AddComment implements UseCase<Unit, AddCommentParams> {
  AddComment(this._repo);
  final FeedRepository _repo;
  @override
  Future<Result<Unit>> call(AddCommentParams params) =>
      _repo.addComment(params.postId, params.text);
}
