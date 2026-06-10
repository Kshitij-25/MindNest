import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/failures.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';
import 'package:mindnest_app/shared/models/view_status.dart';

import '../../domain/entities/professional.dart';
import '../../domain/usecases/professional_usecases.dart';

class ProRequestsState extends Equatable {
  const ProRequestsState({
    this.status = ViewStatus.initial,
    this.requests = const [],
    this.overrides = const {},
    this.failure,
  });

  final ViewStatus status;
  final List<BookingRequest> requests;
  final Map<String, String> overrides;
  final Failure? failure;

  /// Effective status for a request, honouring any local override.
  String statusOf(BookingRequest r) => overrides[r.id] ?? r.status;

  ProRequestsState copyWith({
    ViewStatus? status,
    List<BookingRequest>? requests,
    Map<String, String>? overrides,
    Failure? failure,
  }) => ProRequestsState(
    status: status ?? this.status,
    requests: requests ?? this.requests,
    overrides: overrides ?? this.overrides,
    failure: failure ?? this.failure,
  );

  @override
  List<Object?> get props => [status, requests, overrides, failure];
}

@injectable
class ProRequestsCubit extends Cubit<ProRequestsState> {
  ProRequestsCubit(this._getRequests) : super(const ProRequestsState());
  final GetBookingRequests _getRequests;

  Future<void> load() async {
    emit(state.copyWith(status: ViewStatus.loading));
    final result = await _getRequests(const NoParams());
    result.fold(
      (failure) =>
          emit(state.copyWith(status: ViewStatus.error, failure: failure)),
      (requests) =>
          emit(state.copyWith(status: ViewStatus.loaded, requests: requests)),
    );
  }

  void act(String id, String status) =>
      emit(state.copyWith(overrides: {...state.overrides, id: status}));
}
