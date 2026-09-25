import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/load_status.dart';
import '../../domain/entities/app_notification.dart';
import '../../domain/usecases/notifications_usecases.dart';

part 'notifications_bloc.freezed.dart';

@freezed
sealed class NotificationsEvent with _$NotificationsEvent {
  const factory NotificationsEvent.load() = NotificationsLoad;
  const factory NotificationsEvent.opened(String id) = NotificationsOpened;
  const factory NotificationsEvent.allRead() = NotificationsAllRead;
}

@freezed
abstract class NotificationsState with _$NotificationsState {
  const factory NotificationsState({
    @Default(LoadStatus.initial) LoadStatus status,
    @Default(<AppNotification>[]) List<AppNotification> items,
    String? error,
  }) = _NotificationsState;

  const NotificationsState._();

  bool get hasUnread => items.any((n) => n.unread);
  int get unreadCount => items.where((n) => n.unread).length;
  List<AppNotification> get recent => items.where((n) => DateTime.now().difference(n.createdAt).inHours < 24).toList();
  List<AppNotification> get earlier => items.where((n) => DateTime.now().difference(n.createdAt).inHours >= 24).toList();
}

/// App-wide so bell badges stay in sync.
@lazySingleton
class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc(this._get, this._watch, this._read, this._readAll) : super(const NotificationsState()) {
    on<NotificationsLoad>((e, emit) async {
      if (state.items.isEmpty) emit(state.copyWith(status: LoadStatus.loading));
      final res = await _get(const NoParams());
      final ok = res.fold(
        (f) {
          emit(state.copyWith(status: LoadStatus.failure, error: f.message));
          return false;
        },
        (list) {
          emit(state.copyWith(status: LoadStatus.success, items: list));
          return true;
        },
      );
      if (!ok) return;
      // Stay live so badges update as notifications arrive.
      await emit.forEach<List<AppNotification>>(
        _watch(),
        onData: (list) => state.copyWith(status: LoadStatus.success, items: list),
        onError: (_, _) => state,
      );
    }, transformer: restartable());
    on<NotificationsOpened>((e, emit) async {
      emit(state.copyWith(items: [for (final n in state.items) n.id == e.id ? n.copyWith(unread: false) : n]));
      await _read(e.id);
    });
    on<NotificationsAllRead>((e, emit) async {
      emit(state.copyWith(items: [for (final n in state.items) n.copyWith(unread: false)]));
      await _readAll(const NoParams());
    });
  }

  final GetNotifications _get;
  final WatchNotifications _watch;
  final MarkNotificationRead _read;
  final MarkAllNotificationsRead _readAll;
}
