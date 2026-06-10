import 'package:injectable/injectable.dart';

import '../models/messaging_models.dart';

@lazySingleton
class MessagingLocalDataSource {
  Future<List<ConversationModel>> getConversations() async =>
      _conversations.map(ConversationModel.fromJson).toList();

  Future<List<MessageModel>> getMessages(String conversationId) async =>
      _messages.map(MessageModel.fromJson).toList();

  static const _conversations = <Map<String, dynamic>>[
    {
      'id': 'c1',
      'name': 'Dr. Amara Okafor',
      'last': 'That sounds like real progress — well done this week.',
      'time': '9:24',
      'unread': 2,
      'online': true,
    },
    {
      'id': 'c2',
      'name': 'Daniel Mercer',
      'last': 'See you Thursday. Take it gently until then.',
      'time': 'Yesterday',
      'unread': 0,
      'online': false,
    },
    {
      'id': 'c3',
      'name': 'Dr. Priya Nair',
      'last': 'I’ve shared a short breathing exercise for tonight.',
      'time': 'Mon',
      'unread': 0,
      'online': true,
    },
  ];

  static const _messages = <Map<String, dynamic>>[
    {
      'id': 'm1',
      'fromMe': false,
      'text': 'Hi — how have you been since our last session?',
      'time': '9:10',
    },
    {
      'id': 'm2',
      'fromMe': true,
      'text': 'A bit up and down, but I tried the grounding exercise twice.',
      'time': '9:18',
      'read': true,
    },
    {
      'id': 'm3',
      'fromMe': false,
      'text': 'That sounds like real progress — well done this week.',
      'time': '9:24',
    },
  ];
}
