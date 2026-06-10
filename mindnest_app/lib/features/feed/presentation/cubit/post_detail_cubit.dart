import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/failures.dart';
import 'package:mindnest_app/shared/models/view_status.dart';

import '../../domain/entities/post.dart';
import '../../domain/usecases/feed_usecases.dart';

class PostDetailState extends Equatable {
  const PostDetailState({
    this.status = ViewStatus.initial,
    this.post,
    this.liked = false,
    this.saved = false,
    this.failure,
  });
  final ViewStatus status;
  final Post? post;
  final bool liked, saved;
  final Failure? failure;

  PostDetailState copyWith({
    ViewStatus? status,
    Post? post,
    bool? liked,
    bool? saved,
    Failure? failure,
  }) => PostDetailState(
    status: status ?? this.status,
    post: post ?? this.post,
    liked: liked ?? this.liked,
    saved: saved ?? this.saved,
    failure: failure ?? this.failure,
  );

  @override
  List<Object?> get props => [status, post, liked, saved, failure];
}

@injectable
class PostDetailCubit extends Cubit<PostDetailState> {
  PostDetailCubit(this._getPost) : super(const PostDetailState());
  final GetPost _getPost;

  Future<void> load(String id) async {
    emit(const PostDetailState(status: ViewStatus.loading));
    final result = await _getPost(id);
    result.fold(
      (failure) =>
          emit(PostDetailState(status: ViewStatus.error, failure: failure)),
      (post) => emit(
        PostDetailState(
          status: ViewStatus.loaded,
          post: post,
          liked: post.liked,
          saved: post.saved,
        ),
      ),
    );
  }

  void toggleLike() => emit(state.copyWith(liked: !state.liked));
  void toggleSave() => emit(state.copyWith(saved: !state.saved));
}
