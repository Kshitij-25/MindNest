import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/account_repository.dart';

part 'delete_account_cubit.freezed.dart';

@freezed
abstract class DeleteAccountState with _$DeleteAccountState {
  const factory DeleteAccountState({@Default(false) bool deleting, @Default(false) bool deleted, String? error}) =
      _DeleteAccountState;
}

@injectable
class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit(this._repo) : super(const DeleteAccountState());
  final AccountRepository _repo;

  bool get usesPassword => _repo.usesPassword;

  Future<void> delete({String? password}) async {
    if (state.deleting) return;
    emit(const DeleteAccountState(deleting: true));
    final r = await _repo.deleteAccount(password: password);
    emit(r.fold((f) => DeleteAccountState(error: f.message), (_) => const DeleteAccountState(deleted: true)));
  }
}
