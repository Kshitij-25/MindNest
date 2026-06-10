import 'package:equatable/equatable.dart';

enum NotificationType { booking, message, mood, content }

class AppNotification extends Equatable {
  const AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.time,
    required this.unread,
  });
  final String id, title, body, time;
  final NotificationType type;
  final bool unread;

  bool get isEarlier => time.contains('d');

  AppNotification copyWith({bool? unread}) => AppNotification(
    id: id,
    type: type,
    title: title,
    body: body,
    time: time,
    unread: unread ?? this.unread,
  );

  @override
  List<Object?> get props => [id, unread];
}
