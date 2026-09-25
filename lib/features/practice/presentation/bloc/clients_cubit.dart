import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/load_status.dart';
import '../../domain/entities/practice_entities.dart';
import '../../domain/usecases/practice_usecases.dart';

part 'clients_cubit.freezed.dart';

@freezed
abstract class ClientsState with _$ClientsState {
  const factory ClientsState({
    @Default(LoadStatus.initial) LoadStatus status,
    @Default(<Client>[]) List<Client> clients,
    @Default('') String query,
    String? selectedId,
  }) = _ClientsState;

  const ClientsState._();

  List<Client> get visible {
    final q = query.trim().toLowerCase();
    return q.isEmpty ? clients : clients.where((c) => c.name.toLowerCase().contains(q) || c.focus.toLowerCase().contains(q)).toList();
  }

  String? get effectiveSelection => selectedId ?? (clients.isEmpty ? null : clients.first.id);
}

@injectable
class ClientsCubit extends Cubit<ClientsState> {
  ClientsCubit(this._get) : super(const ClientsState());
  final GetClients _get;

  Future<void> load() async {
    emit(state.copyWith(status: LoadStatus.loading));
    final r = await _get(const NoParams());
    r.fold(
      (_) => emit(state.copyWith(status: LoadStatus.failure)),
      (l) => emit(state.copyWith(status: LoadStatus.success, clients: l)),
    );
  }

  void search(String q) => emit(state.copyWith(query: q));
  void select(String id) => emit(state.copyWith(selectedId: id));
}

enum ClientDetailTab { notes, history, goals }

@freezed
abstract class ClientDetailState with _$ClientDetailState {
  const factory ClientDetailState({
    @Default(LoadStatus.initial) LoadStatus status,
    ClientDetail? detail,
    @Default(ClientDetailTab.notes) ClientDetailTab tab,
    @Default(false) bool savingNote,
  }) = _ClientDetailState;
}

@injectable
class ClientDetailCubit extends Cubit<ClientDetailState> {
  ClientDetailCubit(this._get, this._addNote, this._toggleGoal) : super(const ClientDetailState());

  final GetClientDetail _get;
  final AddClientNote _addNote;
  final ToggleClientGoal _toggleGoal;

  Future<void> load(String id) async {
    emit(const ClientDetailState(status: LoadStatus.loading));
    final r = await _get(id);
    r.fold(
      (_) => emit(state.copyWith(status: LoadStatus.failure)),
      (d) => emit(state.copyWith(status: LoadStatus.success, detail: d)),
    );
  }

  void setTab(ClientDetailTab t) => emit(state.copyWith(tab: t));

  Future<bool> addNote(String text) async {
    final d = state.detail;
    if (d == null) return false;
    emit(state.copyWith(savingNote: true));
    final r = await _addNote(AddNoteParams(d.client.id, text));
    return r.fold((_) {
      emit(state.copyWith(savingNote: false));
      return false;
    }, (n) {
      emit(state.copyWith(savingNote: false, detail: d.copyWith(notes: [n, ...d.notes])));
      return true;
    });
  }

  Future<void> toggleGoal(ClientGoal g) async {
    final d = state.detail;
    if (d == null) return;
    emit(state.copyWith(detail: d.copyWith(goals: [for (final x in d.goals) x.id == g.id ? x.copyWith(done: !x.done) : x])));
    await _toggleGoal(ToggleGoalParams(d.client.id, g.id));
  }
}
