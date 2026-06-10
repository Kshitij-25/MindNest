import 'package:injectable/injectable.dart';

import '../models/notification_model.dart';

@lazySingleton
class NotificationsLocalDataSource {
  Future<List<NotificationModel>> getNotifications() async =>
      _items.map(NotificationModel.fromJson).toList();

  static const _items = <Map<String, dynamic>>[
    {
      'id': 'n1',
      'type': 'booking',
      'title': 'Booking confirmed',
      'body':
          'Dr. Amara Okafor accepted your session for Thu, 5 June at 4:00 PM.',
      'time': '5m',
      'unread': true,
    },
    {
      'id': 'n2',
      'type': 'message',
      'title': 'New message',
      'body':
          'Dr. Okafor: “That sounds like real progress — well done this week.”',
      'time': '1h',
      'unread': true,
    },
    {
      'id': 'n3',
      'type': 'mood',
      'title': 'Time for a check-in',
      'body':
          'How are you feeling this evening? A quick note keeps your streak going.',
      'time': '3h',
      'unread': false,
    },
    {
      'id': 'n4',
      'type': 'content',
      'title': 'New from Dr. Nair',
      'body': '“Why trying harder to sleep backfires” — a 2-minute read.',
      'time': '5h',
      'unread': false,
    },
    {
      'id': 'n5',
      'type': 'booking',
      'title': 'Session reminder',
      'body': 'Your session with Daniel Mercer is tomorrow at 1:00 PM.',
      'time': '1d',
      'unread': false,
    },
  ];
}
