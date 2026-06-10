import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/failures.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';
import 'package:mindnest_app/shared/models/view_status.dart';

import '../../domain/entities/mood.dart';
import '../../domain/usecases/mood_usecases.dart';

class MoodInsightsState extends Equatable {
  const MoodInsightsState({
    this.status = ViewStatus.initial,
    this.insights,
    this.range = 'Week',
    this.failure,
  });
  final ViewStatus status;
  final MoodInsights? insights;
  final String range;
  final Failure? failure;

  MoodInsightsState copyWith({
    ViewStatus? status,
    MoodInsights? insights,
    String? range,
    Failure? failure,
  }) => MoodInsightsState(
    status: status ?? this.status,
    insights: insights ?? this.insights,
    range: range ?? this.range,
    failure: failure ?? this.failure,
  );

  @override
  List<Object?> get props => [status, insights, range, failure];
}

@injectable
class MoodInsightsCubit extends Cubit<MoodInsightsState> {
  MoodInsightsCubit(this._getInsights) : super(const MoodInsightsState());
  final GetMoodInsights _getInsights;

  Future<void> load() async {
    emit(state.copyWith(status: ViewStatus.loading));
    final result = await _getInsights(const NoParams());
    result.fold(
      (failure) =>
          emit(state.copyWith(status: ViewStatus.error, failure: failure)),
      (insights) =>
          emit(state.copyWith(status: ViewStatus.loaded, insights: insights)),
    );
  }

  void setRange(String range) => emit(state.copyWith(range: range));
}
