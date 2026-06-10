import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/failures.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';
import 'package:mindnest_app/shared/models/view_status.dart';

import '../../domain/entities/journal_entry.dart';
import '../../domain/usecases/journal_usecases.dart';

class JournalListState extends Equatable {
  const JournalListState({
    this.status = ViewStatus.initial,
    this.entries = const [],
    this.view = 'List',
    this.failure,
  });
  final ViewStatus status;
  final List<JournalEntry> entries;
  final String view;
  final Failure? failure;

  JournalListState copyWith({
    ViewStatus? status,
    List<JournalEntry>? entries,
    String? view,
    Failure? failure,
  }) => JournalListState(
    status: status ?? this.status,
    entries: entries ?? this.entries,
    view: view ?? this.view,
    failure: failure ?? this.failure,
  );

  @override
  List<Object?> get props => [status, entries, view, failure];
}

@injectable
class JournalListCubit extends Cubit<JournalListState> {
  JournalListCubit(this._getEntries) : super(const JournalListState());
  final GetJournalEntries _getEntries;

  Future<void> load() async {
    emit(state.copyWith(status: ViewStatus.loading));
    final result = await _getEntries(const NoParams());
    result.fold(
      (failure) =>
          emit(state.copyWith(status: ViewStatus.error, failure: failure)),
      (entries) =>
          emit(state.copyWith(status: ViewStatus.loaded, entries: entries)),
    );
  }

  void setView(String view) => emit(state.copyWith(view: view));
}
