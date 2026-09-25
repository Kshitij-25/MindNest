import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/load_status.dart';
import '../../domain/entities/practice_entities.dart';
import '../../domain/usecases/practice_usecases.dart';
import 'requests_bloc.dart';

part 'dashboard_cubit.freezed.dart';

@freezed
abstract class DashboardState with _$DashboardState {
  const factory DashboardState({
    @Default(LoadStatus.initial) LoadStatus status,
    PracticeDashboard? data,
    String? error,
  }) = _DashboardState;
}

@lazySingleton
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this._get, this._accepting, this._requests) : super(const DashboardState());

  final GetPracticeDashboard _get;
  final SetAcceptingClients _accepting;
  final RequestsBloc _requests;

  Future<void> load() async {
    _requests.add(const RequestsEvent.load());
    if (state.data == null) emit(state.copyWith(status: LoadStatus.loading));
    final r = await _get(const NoParams());
    r.fold(
      (f) => emit(state.copyWith(status: LoadStatus.failure, error: f.message)),
      (d) => emit(state.copyWith(status: LoadStatus.success, data: d)),
    );
  }

  Future<void> setAccepting(bool v) async {
    final d = state.data;
    if (d == null) return;
    emit(state.copyWith(data: d.copyWith(acceptingClients: v)));
    await _accepting(v);
  }
}
