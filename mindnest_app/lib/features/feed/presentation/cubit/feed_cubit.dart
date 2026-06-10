import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/failures.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';
import 'package:mindnest_app/shared/models/view_status.dart';

import '../../domain/entities/post.dart';
import '../../domain/usecases/feed_usecases.dart';

class FeedState extends Equatable {
  const FeedState({
    this.status = ViewStatus.initial,
    this.posts = const [],
    this.topic = 'For you',
    this.likes = const {},
    this.saves = const {},
    this.failure,
  });

  final ViewStatus status;
  final List<Post> posts;
  final String topic;
  final Map<String, bool> likes;
  final Map<String, bool> saves;
  final Failure? failure;

  List<Post> get filtered =>
      posts.where((p) => topic == 'For you' || p.topic == topic).toList();
  bool liked(Post p) => likes[p.id] ?? p.liked;
  bool saved(Post p) => saves[p.id] ?? p.saved;

  FeedState copyWith({
    ViewStatus? status,
    List<Post>? posts,
    String? topic,
    Map<String, bool>? likes,
    Map<String, bool>? saves,
    Failure? failure,
  }) => FeedState(
    status: status ?? this.status,
    posts: posts ?? this.posts,
    topic: topic ?? this.topic,
    likes: likes ?? this.likes,
    saves: saves ?? this.saves,
    failure: failure ?? this.failure,
  );

  @override
  List<Object?> get props => [status, posts, topic, likes, saves, failure];
}

@injectable
class FeedCubit extends Cubit<FeedState> {
  FeedCubit(this._getPosts) : super(const FeedState());
  final GetPosts _getPosts;

  Future<void> load() async {
    emit(state.copyWith(status: ViewStatus.loading));
    final result = await _getPosts(const NoParams());
    result.fold(
      (failure) =>
          emit(state.copyWith(status: ViewStatus.error, failure: failure)),
      (posts) => emit(state.copyWith(status: ViewStatus.loaded, posts: posts)),
    );
  }

  void setTopic(String topic) => emit(state.copyWith(topic: topic));

  void toggleLike(Post p) =>
      emit(state.copyWith(likes: {...state.likes, p.id: !state.liked(p)}));
  void toggleSave(Post p) =>
      emit(state.copyWith(saves: {...state.saves, p.id: !state.saved(p)}));
}
