import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/failures.dart';
import 'package:mindnest_app/shared/models/view_status.dart';

import '../../domain/entities/journal_entry.dart';
import '../../domain/usecases/journal_usecases.dart';

class JournalEntryState extends Equatable {
  const JournalEntryState({
    this.status = ViewStatus.initial,
    this.entry,
    this.failure,
  });
  final ViewStatus status;
  final JournalEntry? entry;
  final Failure? failure;
  @override
  List<Object?> get props => [status, entry, failure];
}

@injectable
class JournalEntryCubit extends Cubit<JournalEntryState> {
  JournalEntryCubit(this._getEntry) : super(const JournalEntryState());
  final GetJournalEntry _getEntry;

  Future<void> load(String id) async {
    emit(const JournalEntryState(status: ViewStatus.loading));
    final result = await _getEntry(id);
    result.fold(
      (failure) =>
          emit(JournalEntryState(status: ViewStatus.error, failure: failure)),
      (entry) =>
          emit(JournalEntryState(status: ViewStatus.loaded, entry: entry)),
    );
  }
}
