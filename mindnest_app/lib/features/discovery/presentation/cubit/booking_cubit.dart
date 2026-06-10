import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/appointment.dart';
import '../../domain/usecases/discovery_usecases.dart';

class BookingState extends Equatable {
  const BookingState({
    this.dateIndex = 4,
    this.slot,
    this.type = 'Video',
    this.submitting = false,
    this.submitted = false,
  });

  final int dateIndex;
  final String? slot;
  final String type;
  final bool submitting;
  final bool submitted;

  BookingState copyWith({
    int? dateIndex,
    String? slot,
    String? type,
    bool? submitting,
    bool? submitted,
  }) => BookingState(
    dateIndex: dateIndex ?? this.dateIndex,
    slot: slot ?? this.slot,
    type: type ?? this.type,
    submitting: submitting ?? this.submitting,
    submitted: submitted ?? this.submitted,
  );

  @override
  List<Object?> get props => [dateIndex, slot, type, submitting, submitted];
}

@injectable
class BookingCubit extends Cubit<BookingState> {
  BookingCubit(this._submitBooking) : super(const BookingState());
  final SubmitBooking _submitBooking;

  void selectDate(int index) => emit(state.copyWith(dateIndex: index));
  void selectSlot(String slot) => emit(state.copyWith(slot: slot));
  void selectType(String type) => emit(state.copyWith(type: type));

  Future<bool> submit(BookingDraft draft) async {
    emit(state.copyWith(submitting: true));
    final result = await _submitBooking(draft);
    return result.fold(
      (_) {
        emit(state.copyWith(submitting: false));
        return false;
      },
      (_) {
        emit(state.copyWith(submitting: false, submitted: true));
        return true;
      },
    );
  }
}
