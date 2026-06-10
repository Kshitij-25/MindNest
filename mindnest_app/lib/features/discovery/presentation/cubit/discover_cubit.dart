import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/failures.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';
import 'package:mindnest_app/shared/models/view_status.dart';

import '../../domain/entities/therapist.dart';
import '../../domain/usecases/discovery_usecases.dart';

class DiscoverState extends Equatable {
  const DiscoverState({
    this.status = ViewStatus.initial,
    this.all = const [],
    this.query = '',
    this.spec = 'All',
    this.failure,
  });

  final ViewStatus status;
  final List<Therapist> all;
  final String query;
  final String spec;
  final Failure? failure;

  List<Therapist> get filtered => all.where((t) {
    final matchSpec =
        spec == 'All' ||
        t.tags.any((tg) => tg.toLowerCase().contains(spec.toLowerCase())) ||
        t.spec.toLowerCase().contains(spec.toLowerCase());
    final matchQuery =
        query.isEmpty ||
        t.name.toLowerCase().contains(query.toLowerCase()) ||
        t.spec.toLowerCase().contains(query.toLowerCase());
    return matchSpec && matchQuery;
  }).toList();

  DiscoverState copyWith({
    ViewStatus? status,
    List<Therapist>? all,
    String? query,
    String? spec,
    Failure? failure,
  }) => DiscoverState(
    status: status ?? this.status,
    all: all ?? this.all,
    query: query ?? this.query,
    spec: spec ?? this.spec,
    failure: failure ?? this.failure,
  );

  @override
  List<Object?> get props => [status, all, query, spec, failure];
}

@injectable
class DiscoverCubit extends Cubit<DiscoverState> {
  DiscoverCubit(this._getTherapists) : super(const DiscoverState());
  final GetTherapists _getTherapists;

  Future<void> load() async {
    emit(state.copyWith(status: ViewStatus.loading));
    final result = await _getTherapists(const NoParams());
    result.fold(
      (failure) =>
          emit(state.copyWith(status: ViewStatus.error, failure: failure)),
      (therapists) =>
          emit(state.copyWith(status: ViewStatus.loaded, all: therapists)),
    );
  }

  void setQuery(String query) => emit(state.copyWith(query: query));
  void setSpec(String spec) => emit(state.copyWith(spec: spec));
  void clearFilters() => emit(state.copyWith(query: '', spec: 'All'));
}
