import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/load_status.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/feed_usecases.dart';

part 'post_detail_cubit.freezed.dart';

@freezed
abstract class PostDetailState with _$PostDetailState {
  const factory PostDetailState({
    @Default(LoadStatus.initial) LoadStatus status,
    Post? post,
    @Default(<PostComment>[]) List<PostComment> comments,
    @Default(false) bool commentsLoading,
    @Default(false) bool sending,
    String? error,
  }) = _PostDetailState;
}

@injectable
class PostDetailCubit extends Cubit<PostDetailState> {
  PostDetailCubit(this._get, this._like, this._save, this._comments, this._add, this._likeComment)
      : super(const PostDetailState());

  final GetPost _get;
  final TogglePostLike _like;
  final TogglePostSave _save;
  final GetComments _comments;
  final AddComment _add;
  final ToggleCommentLike _likeComment;

  Future<void> load(String id) async {
    emit(state.copyWith(status: LoadStatus.loading));
    final res = await _get(id);
    res.fold(
      (f) => emit(state.copyWith(status: LoadStatus.failure, error: f.message)),
      (p) => emit(state.copyWith(status: LoadStatus.success, post: p)),
    );
  }

  Future<void> toggleLike() async {
    final p = state.post;
    if (p == null) return;
    emit(state.copyWith(post: p.copyWith(liked: !p.liked, likes: p.likes + (p.liked ? -1 : 1))));
    await _like(p);
  }

  Future<void> toggleSave() async {
    final p = state.post;
    if (p == null) return;
    emit(state.copyWith(post: p.copyWith(saved: !p.saved)));
    await _save(p);
  }

  Future<void> loadComments() async {
    final p = state.post;
    if (p == null) return;
    emit(state.copyWith(commentsLoading: true));
    final res = await _comments(p.id);
    emit(state.copyWith(commentsLoading: false, comments: res.getOrElse((_) => const [])));
  }

  Future<bool> addComment(String text) async {
    final p = state.post;
    if (p == null) return false;
    emit(state.copyWith(sending: true));
    final res = await _add(AddCommentParams(p.id, text));
    return res.fold((f) {
      emit(state.copyWith(sending: false, error: f.message));
      return false;
    }, (c) {
      emit(state.copyWith(
        sending: false,
        comments: [...state.comments, c],
        post: p.copyWith(comments: p.comments + 1),
      ));
      return true;
    });
  }

  Future<void> toggleCommentLike(PostComment c) async {
    final p = state.post;
    if (p == null) return;
    emit(state.copyWith(comments: [
      for (final x in state.comments)
        x.id == c.id ? x.copyWith(liked: !x.liked, likes: x.likes + (x.liked ? -1 : 1)) : x,
    ]));
    await _likeComment(ToggleCommentLikeParams(p.id, c));
  }
}
