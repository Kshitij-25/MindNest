import 'package:equatable/equatable.dart';

class Conversation extends Equatable {
  const Conversation({
    required this.id,
    required this.name,
    required this.last,
    required this.time,
    required this.unread,
    required this.online,
    this.typing = false,
  });
  final String id, name, last, time;
  final int unread;
  final bool online, typing;

  @override
  List<Object?> get props => [id, unread, online, typing];
}

class Message extends Equatable {
  const Message({
    required this.id,
    required this.fromMe,
    required this.text,
    required this.time,
    this.read = false,
  });
  final String id, text, time;
  final bool fromMe, read;

  Message copyWith({bool? read}) => Message(
    id: id,
    fromMe: fromMe,
    text: text,
    time: time,
    read: read ?? this.read,
  );

  @override
  List<Object?> get props => [id, fromMe, text, time, read];
}
