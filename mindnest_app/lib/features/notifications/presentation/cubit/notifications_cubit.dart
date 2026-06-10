import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/failures.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';
import 'package:mindnest_app/shared/models/view_status.dart';

import '../../domain/entities/app_notification.dart';
import '../../domain/usecases/get_notifications.dart';

class NotificationsState extends Equatable {
  const NotificationsState({
    this.status = ViewStatus.initial,
    this.items = const [],
    this.failure,
  });
  final ViewStatus status;
  final List<AppNotification> items;
  final Failure? failure;

  bool get hasUnread => items.any((n) => n.unread);
  List<AppNotification> get today => items.where((n) => !n.isEarlier).toList();
  List<AppNotification> get earlier => items.where((n) => n.isEarlier).toList();

  NotificationsState copyWith({
    ViewStatus? status,
    List<AppNotification>? items,
    Failure? failure,
  }) => NotificationsState(
    status: status ?? this.status,
    items: items ?? this.items,
    failure: failure ?? this.failure,
  );

  @override
  List<Object?> get props => [status, items, failure];
}

@injectable
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._getNotifications)
    : super(const NotificationsState());
  final GetNotifications _getNotifications;

  Future<void> load() async {
    emit(state.copyWith(status: ViewStatus.loading));
    final result = await _getNotifications(const NoParams());
    result.fold(
      (failure) =>
          emit(state.copyWith(status: ViewStatus.error, failure: failure)),
      (items) => emit(state.copyWith(status: ViewStatus.loaded, items: items)),
    );
  }

  void markAll() => emit(
    state.copyWith(
      items: state.items.map((n) => n.copyWith(unread: false)).toList(),
    ),
  );

  void markRead(String id) => emit(
    state.copyWith(
      items: state.items
          .map((n) => n.id == id ? n.copyWith(unread: false) : n)
          .toList(),
    ),
  );
}
