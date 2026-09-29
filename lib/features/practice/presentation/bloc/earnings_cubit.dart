import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/practice_entities.dart';
import '../../domain/usecases/practice_usecases.dart';

part 'earnings_cubit.freezed.dart';

enum EarningsPeriod { week, month, year }

@freezed
abstract class EarningsState with _$EarningsState {
  const factory EarningsState({Earnings? data, @Default(EarningsPeriod.month) EarningsPeriod period, String? error}) = _EarningsState;
}

@injectable
class EarningsCubit extends Cubit<EarningsState> {
  EarningsCubit(this._get, this._setPaid) : super(const EarningsState());
  final GetEarnings _get;
  final SetSessionPaid _setPaid;

  Future<void> load() async {
    final r = await _get(const NoParams());
    r.fold((_) {}, (d) => emit(state.copyWith(data: d)));
  }

  /// Optimistically flips the row, then reloads so the totals follow.
  Future<void> setPaid(String appointmentId, bool paid) async {
    final d = state.data;
    if (d == null) return;
    emit(state.copyWith(
      error: null,
      data: d.copyWith(transactions: [for (final t in d.transactions) t.id == appointmentId ? t.copyWith(paid: paid) : t]),
    ));
    final r = await _setPaid(SetSessionPaidParams(appointmentId, paid));
    await r.fold(
      (f) async => emit(state.copyWith(data: d, error: f.message)),
      (_) => load(),
    );
  }

  void setPeriod(EarningsPeriod p) => emit(state.copyWith(period: p));
}
