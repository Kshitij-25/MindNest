import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/shared/models/view_status.dart';

import '../../domain/entities/post.dart';
import '../../domain/usecases/feed_usecases.dart';

class CommentsState extends Equatable {
  const CommentsState({
    this.status = ViewStatus.initial,
    this.comments = const [],
  });
  final ViewStatus status;
  final List<PostComment> comments;

  CommentsState copyWith({ViewStatus? status, List<PostComment>? comments}) =>
      CommentsState(
        status: status ?? this.status,
        comments: comments ?? this.comments,
      );

  @override
  List<Object?> get props => [status, comments];
}

@injectable
class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit(this._getComments, this._addComment)
    : super(const CommentsState());
  final GetComments _getComments;
  final AddComment _addComment;

  late String _postId;

  Future<void> load(String postId) async {
    _postId = postId;
    emit(const CommentsState(status: ViewStatus.loading));
    final result = await _getComments(postId);
    result.fold(
      (_) => emit(const CommentsState(status: ViewStatus.error)),
      (comments) =>
          emit(CommentsState(status: ViewStatus.loaded, comments: comments)),
    );
  }

  Future<void> add(String text) async {
    if (text.trim().isEmpty) return;
    await _addComment(AddCommentParams(_postId, text.trim()));
    final comment = PostComment(
      id: 'new${DateTime.now().millisecondsSinceEpoch}',
      name: 'Maya L.',
      time: 'now',
      text: text.trim(),
      likes: 0,
    );
    emit(state.copyWith(comments: [...state.comments, comment]));
  }
}
