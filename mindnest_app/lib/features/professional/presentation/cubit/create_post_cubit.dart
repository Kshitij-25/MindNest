import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/shared/models/view_status.dart';

import '../../domain/entities/professional.dart';
import '../../domain/usecases/professional_usecases.dart';

class CreatePostState extends Equatable {
  const CreatePostState({
    this.status = ViewStatus.initial,
    this.topic,
    this.hasImage = false,
    this.published = false,
    this.seed,
  });

  final ViewStatus status;
  final String? topic;
  final bool hasImage;
  final bool published;

  /// The existing post when editing (used to seed page controllers).
  final ProPost? seed;

  CreatePostState copyWith({
    ViewStatus? status,
    String? topic,
    bool? hasImage,
    bool? published,
    ProPost? seed,
  }) => CreatePostState(
    status: status ?? this.status,
    topic: topic ?? this.topic,
    hasImage: hasImage ?? this.hasImage,
    published: published ?? this.published,
    seed: seed ?? this.seed,
  );

  @override
  List<Object?> get props => [status, topic, hasImage, published, seed];
}

@injectable
class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit(this._getPost)
    : super(const CreatePostState(status: ViewStatus.loaded));
  final GetProPost _getPost;

  Future<void> load(String? postId) async {
    if (postId == null) {
      emit(const CreatePostState(status: ViewStatus.loaded));
      return;
    }
    emit(const CreatePostState(status: ViewStatus.loading));
    final result = await _getPost(postId);
    result.fold(
      (_) => emit(const CreatePostState(status: ViewStatus.loaded)),
      (post) => emit(
        CreatePostState(
          status: ViewStatus.loaded,
          seed: post,
          topic: post.topic,
          hasImage: post.image,
        ),
      ),
    );
  }

  void selectTopic(String topic) {
    final next = state.topic == topic ? null : topic;
    emit(
      CreatePostState(
        status: state.status,
        topic: next,
        hasImage: state.hasImage,
        published: state.published,
        seed: state.seed,
      ),
    );
  }

  void toggleImage() => emit(state.copyWith(hasImage: !state.hasImage));
  void publish() => emit(state.copyWith(published: true));
}
