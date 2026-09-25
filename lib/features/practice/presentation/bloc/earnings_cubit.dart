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
  const factory EarningsState({Earnings? data, @Default(EarningsPeriod.month) EarningsPeriod period}) = _EarningsState;
}

@injectable
class EarningsCubit extends Cubit<EarningsState> {
  EarningsCubit(this._get) : super(const EarningsState());
  final GetEarnings _get;

  Future<void> load() async {
    final r = await _get(const NoParams());
    r.fold((_) {}, (d) => emit(state.copyWith(data: d)));
  }

  void setPeriod(EarningsPeriod p) => emit(state.copyWith(period: p));
}
