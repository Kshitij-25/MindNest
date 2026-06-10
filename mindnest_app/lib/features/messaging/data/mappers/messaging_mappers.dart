import '../../domain/entities/conversation.dart';
import '../models/messaging_models.dart';

extension ConversationModelX on ConversationModel {
  Conversation toEntity() => Conversation(
    id: id,
    name: name,
    last: last,
    time: time,
    unread: unread,
    online: online,
    typing: typing,
  );
}

extension MessageModelX on MessageModel {
  Message toEntity() =>
      Message(id: id, fromMe: fromMe, text: text, time: time, read: read);
}
