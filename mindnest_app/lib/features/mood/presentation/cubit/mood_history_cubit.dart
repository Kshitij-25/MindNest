import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/failures.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';
import 'package:mindnest_app/shared/models/view_status.dart';

import '../../domain/entities/mood.dart';
import '../../domain/usecases/mood_usecases.dart';

class MoodHistoryState extends Equatable {
  const MoodHistoryState({
    this.status = ViewStatus.initial,
    this.history,
    this.failure,
  });
  final ViewStatus status;
  final MoodHistory? history;
  final Failure? failure;
  @override
  List<Object?> get props => [status, history, failure];
}

@injectable
class MoodHistoryCubit extends Cubit<MoodHistoryState> {
  MoodHistoryCubit(this._getHistory) : super(const MoodHistoryState());
  final GetMoodHistory _getHistory;

  Future<void> load() async {
    emit(const MoodHistoryState(status: ViewStatus.loading));
    final result = await _getHistory(const NoParams());
    result.fold(
      (failure) =>
          emit(MoodHistoryState(status: ViewStatus.error, failure: failure)),
      (history) =>
          emit(MoodHistoryState(status: ViewStatus.loaded, history: history)),
    );
  }
}
