import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/load_status.dart';
import '../../domain/entities/practice_entities.dart';
import '../../domain/usecases/practice_usecases.dart';

part 'requests_bloc.freezed.dart';

@freezed
sealed class RequestsEvent with _$RequestsEvent {
  const factory RequestsEvent.load() = RequestsLoad;
  const factory RequestsEvent.responded(String id, RequestStatus status) = RequestsResponded;
}

@freezed
abstract class RequestsState with _$RequestsState {
  const factory RequestsState({
    @Default(LoadStatus.initial) LoadStatus status,
    @Default(<SessionRequest>[]) List<SessionRequest> requests,
    String? error,
  }) = _RequestsState;

  const RequestsState._();

  int get pendingCount => requests.where((r) => r.status == RequestStatus.pending).length;
  SessionRequest? byId(String id) => requests.where((r) => r.id == id).firstOrNull;
}

/// Shared by dashboard, requests list/detail and the calendar rail.
@lazySingleton
class RequestsBloc extends Bloc<RequestsEvent, RequestsState> {
  RequestsBloc(this._get, this._respond) : super(const RequestsState()) {
    on<RequestsLoad>((e, emit) async {
      if (state.requests.isEmpty) emit(state.copyWith(status: LoadStatus.loading));
      final r = await _get(const NoParams());
      r.fold(
        (f) => emit(state.copyWith(status: LoadStatus.failure, error: f.message)),
        (l) => emit(state.copyWith(status: LoadStatus.success, requests: l)),
      );
    });
    on<RequestsResponded>((e, emit) async {
      emit(state.copyWith(requests: [for (final r in state.requests) r.id == e.id ? r.copyWith(status: e.status) : r]));
      await _respond(RespondParams(e.id, e.status));
    });
  }

  final GetSessionRequests _get;
  final RespondToRequest _respond;
}
