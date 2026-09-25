import 'package:injectable/injectable.dart';

import '../../../../core/network/mock_latency.dart';
import '../../domain/entities/app_notification.dart';
import '../models/notification_model.dart';

abstract interface class NotificationsDataSource {
  Future<List<NotificationModel>> list();
  Future<void> markRead(String id);
  Future<void> markAllRead();
}

@LazySingleton(as: NotificationsDataSource)
class NotificationsMockDataSource implements NotificationsDataSource {
  NotificationsMockDataSource() {
    final now = DateTime.now();
    _items.addAll([
      NotificationModel(
        id: 'n1',
        type: NotificationType.booking,
        title: 'Booking confirmed',
        body: 'Dr. Amara Okafor accepted your upcoming session.',
        createdAt: now.subtract(const Duration(minutes: 5)),
        unread: true,
      ),
      NotificationModel(
        id: 'n2',
        type: NotificationType.message,
        title: 'New message',
        body: 'Dr. Okafor: “That sounds like real progress — well done this week.”',
        createdAt: now.subtract(const Duration(hours: 1)),
        unread: true,
        targetId: 'c1',
      ),
      NotificationModel(
        id: 'n3',
        type: NotificationType.mood,
        title: 'Time for a check-in',
        body: 'How are you feeling this evening? A quick note keeps your streak going.',
        createdAt: now.subtract(const Duration(hours: 3)),
      ),
      NotificationModel(
        id: 'n4',
        type: NotificationType.content,
        title: 'New from Dr. Nair',
        body: '“Why trying harder to sleep backfires” — a 2-minute read.',
        createdAt: now.subtract(const Duration(hours: 5)),
        targetId: 'p2',
      ),
      NotificationModel(
        id: 'n5',
        type: NotificationType.booking,
        title: 'Session reminder',
        body: 'Your session with Daniel Mercer is tomorrow at 1:00 PM.',
        createdAt: now.subtract(const Duration(days: 1, hours: 2)),
      ),
    ]);
  }

  final _items = <NotificationModel>[];

  @override
  Future<List<NotificationModel>> list() async {
    await mockLatency();
    return _items;
  }

  @override
  Future<void> markRead(String id) async => _items.firstWhere((n) => n.id == id).unread = false;

  @override
  Future<void> markAllRead() async {
    for (final n in _items) {
      n.unread = false;
    }
  }
}
