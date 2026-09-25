import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/load_status.dart';
import '../../../feed/domain/entities/post.dart';
import '../../../feed/domain/usecases/feed_usecases.dart';

part 'content_cubit.freezed.dart';

enum ContentFilter { all, published, drafts }

@freezed
abstract class ContentState with _$ContentState {
  const factory ContentState({
    @Default(LoadStatus.initial) LoadStatus status,
    @Default(<Post>[]) List<Post> posts,
    @Default(ContentFilter.published) ContentFilter filter,
  }) = _ContentState;

  const ContentState._();

  List<Post> get visible => switch (filter) {
        ContentFilter.all => posts,
        ContentFilter.published => posts.where((p) => p.status == PostStatus.published).toList(),
        ContentFilter.drafts => posts.where((p) => p.status == PostStatus.draft).toList(),
      };

  int get totalViews => posts.fold(0, (a, p) => a + p.views);
  int get totalLikes => posts.fold(0, (a, p) => a + p.likes);
  int get totalComments => posts.fold(0, (a, p) => a + p.comments);
}

@lazySingleton
class ContentCubit extends Cubit<ContentState> {
  ContentCubit(this._get) : super(const ContentState());
  final GetMyPosts _get;

  Future<void> load() async {
    if (state.posts.isEmpty) emit(state.copyWith(status: LoadStatus.loading));
    final r = await _get(const NoParams());
    r.fold((_) => emit(state.copyWith(status: LoadStatus.failure)), (p) => emit(state.copyWith(status: LoadStatus.success, posts: p)));
  }

  void setFilter(ContentFilter f) => emit(state.copyWith(filter: f));
  void added(Post p) => emit(state.copyWith(posts: [p, ...state.posts]));
}

@freezed
abstract class CreatePostState with _$CreatePostState {
  const factory CreatePostState({
    @Default(NewPost(topic: '')) NewPost post,
    @Default(false) bool submitting,
    Post? published,
    String? error,
  }) = _CreatePostState;

  const CreatePostState._();

  bool get canPublish => post.title.trim().isNotEmpty && post.body.trim().isNotEmpty && post.topic.isNotEmpty;
}

@injectable
class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit(this._publish, this._content) : super(const CreatePostState());

  final PublishPost _publish;
  final ContentCubit _content;

  void start(Post? existing) {
    if (existing == null) return;
    emit(state.copyWith(
      post: NewPost(title: existing.title, body: existing.body, topic: existing.topic, hasImage: existing.hasImage),
    ));
  }

  void setTitle(String v) => emit(state.copyWith(post: state.post.copyWith(title: v)));
  void setBody(String v) => emit(state.copyWith(post: state.post.copyWith(body: v)));
  void setTopic(String v) => emit(state.copyWith(post: state.post.copyWith(topic: v)));
  void toggleImage() => emit(state.copyWith(post: state.post.copyWith(hasImage: !state.post.hasImage)));
  void toggleComments() => emit(state.copyWith(post: state.post.copyWith(allowComments: !state.post.allowComments)));

  Future<void> submit({bool asDraft = false}) async {
    emit(state.copyWith(submitting: true, error: null));
    final r = await _publish(PublishPostParams(state.post, asDraft: asDraft));
    r.fold(
      (f) => emit(state.copyWith(submitting: false, error: f.message)),
      (p) {
        _content.added(p);
        emit(state.copyWith(submitting: false, published: p));
      },
    );
  }
}
