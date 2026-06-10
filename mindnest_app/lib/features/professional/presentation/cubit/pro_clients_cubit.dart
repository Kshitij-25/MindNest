import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/failures.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';
import 'package:mindnest_app/shared/models/view_status.dart';

import '../../domain/entities/professional.dart';
import '../../domain/usecases/professional_usecases.dart';

class ProClientsState extends Equatable {
  const ProClientsState({
    this.status = ViewStatus.initial,
    this.clients = const [],
    this.failure,
  });

  final ViewStatus status;
  final List<ProClient> clients;
  final Failure? failure;

  ProClientsState copyWith({
    ViewStatus? status,
    List<ProClient>? clients,
    Failure? failure,
  }) => ProClientsState(
    status: status ?? this.status,
    clients: clients ?? this.clients,
    failure: failure ?? this.failure,
  );

  @override
  List<Object?> get props => [status, clients, failure];
}

@injectable
class ProClientsCubit extends Cubit<ProClientsState> {
  ProClientsCubit(this._getClients) : super(const ProClientsState());
  final GetProClients _getClients;

  Future<void> load() async {
    emit(state.copyWith(status: ViewStatus.loading));
    final result = await _getClients(const NoParams());
    result.fold(
      (failure) =>
          emit(state.copyWith(status: ViewStatus.error, failure: failure)),
      (clients) =>
          emit(state.copyWith(status: ViewStatus.loaded, clients: clients)),
    );
  }
}
