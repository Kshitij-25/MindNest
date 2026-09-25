import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/load_status.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/feed_usecases.dart';

part 'feed_bloc.freezed.dart';

@freezed
sealed class FeedEvent with _$FeedEvent {
  const factory FeedEvent.load({@Default(false) bool savedOnly}) = FeedLoad;
  const factory FeedEvent.topicChanged(String topic) = FeedTopicChanged;
  const factory FeedEvent.likeToggled(Post post) = FeedLikeToggled;
  const factory FeedEvent.saveToggled(Post post) = FeedSaveToggled;
  const factory FeedEvent.postUpdated(Post post) = FeedPostUpdated;
}

@freezed
abstract class FeedState with _$FeedState {
  const factory FeedState({
    @Default(LoadStatus.initial) LoadStatus status,
    @Default('For you') String topic,
    @Default(<Post>[]) List<Post> posts,
    @Default(false) bool savedOnly,
    String? error,
  }) = _FeedState;
}

@injectable
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc(this._get, this._like, this._save) : super(const FeedState()) {
    on<FeedLoad>((e, emit) async {
      emit(state.copyWith(savedOnly: e.savedOnly));
      await _fetch(emit);
    }, transformer: restartable());
    on<FeedTopicChanged>((e, emit) async {
      emit(state.copyWith(topic: e.topic));
      await _fetch(emit);
    }, transformer: restartable());
    on<FeedLikeToggled>((e, emit) async {
      final p = e.post;
      _replace(emit, p.copyWith(liked: !p.liked, likes: p.likes + (p.liked ? -1 : 1)));
      await _like(p);
    });
    on<FeedSaveToggled>((e, emit) async {
      final p = e.post;
      if (state.savedOnly && p.saved) {
        emit(state.copyWith(posts: state.posts.where((x) => x.id != p.id).toList()));
      } else {
        _replace(emit, p.copyWith(saved: !p.saved));
      }
      await _save(p);
    });
    on<FeedPostUpdated>((e, emit) => _replace(emit, e.post));
  }

  final GetPosts _get;
  final TogglePostLike _like;
  final TogglePostSave _save;

  void _replace(Emitter<FeedState> emit, Post p) =>
      emit(state.copyWith(posts: [for (final x in state.posts) x.id == p.id ? p : x]));

  Future<void> _fetch(Emitter<FeedState> emit) async {
    if (state.posts.isEmpty) emit(state.copyWith(status: LoadStatus.loading));
    final res = await _get(GetPostsParams(topic: state.topic, savedOnly: state.savedOnly));
    res.fold(
      (f) => emit(state.copyWith(status: LoadStatus.failure, error: f.message)),
      (list) => emit(state.copyWith(status: LoadStatus.success, posts: list)),
    );
  }
}
