import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/failures.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';
import 'package:mindnest_app/shared/models/view_status.dart';

import '../../domain/entities/professional.dart';
import '../../domain/usecases/professional_usecases.dart';

class ProContentState extends Equatable {
  const ProContentState({
    this.status = ViewStatus.initial,
    this.posts = const [],
    this.tab = 'Published',
    this.failure,
  });

  final ViewStatus status;
  final List<ProPost> posts;
  final String tab;
  final Failure? failure;

  List<ProPost> get published =>
      posts.where((p) => p.status == 'Published').toList();
  List<ProPost> get drafts => posts.where((p) => p.status == 'Draft').toList();
  List<ProPost> get filtered => tab == 'Drafts' ? drafts : published;

  int get totalPosts => posts.length;
  int get totalViews => posts.fold(0, (sum, p) => sum + p.views);
  int get totalLikes => posts.fold(0, (sum, p) => sum + p.likes);

  ProContentState copyWith({
    ViewStatus? status,
    List<ProPost>? posts,
    String? tab,
    Failure? failure,
  }) => ProContentState(
    status: status ?? this.status,
    posts: posts ?? this.posts,
    tab: tab ?? this.tab,
    failure: failure ?? this.failure,
  );

  @override
  List<Object?> get props => [status, posts, tab, failure];
}

@injectable
class ProContentCubit extends Cubit<ProContentState> {
  ProContentCubit(this._getPosts) : super(const ProContentState());
  final GetProPosts _getPosts;

  Future<void> load() async {
    emit(state.copyWith(status: ViewStatus.loading));
    final result = await _getPosts(const NoParams());
    result.fold(
      (failure) =>
          emit(state.copyWith(status: ViewStatus.error, failure: failure)),
      (posts) => emit(state.copyWith(status: ViewStatus.loaded, posts: posts)),
    );
  }

  void setTab(String tab) => emit(state.copyWith(tab: tab));
}
