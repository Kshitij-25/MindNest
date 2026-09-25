import 'dart:async';
import 'dart:math';

import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/mock_latency.dart';
import '../models/chat_models.dart';

/// Real-time chat API. The mock simulates the other side typing and replying.
abstract interface class ChatDataSource {
  Future<List<ConversationModel>> conversations({required bool asProfessional});
  Future<List<ChatMessageModel>> messages(String conversationId);
  Future<ChatMessageModel> send(String conversationId, String text);
  Future<void> markRead(String conversationId);
  Future<String> conversationWith(String participantId);
  Stream<ChatEvent> events(String conversationId);
}

sealed class ChatEvent {}

class TypingEvent extends ChatEvent {
  TypingEvent(this.typing);
  final bool typing;
}

class MessageEvent extends ChatEvent {
  MessageEvent(this.message);
  final ChatMessageModel message;
}

class ReadEvent extends ChatEvent {}

@LazySingleton(as: ChatDataSource)
class ChatMockDataSource implements ChatDataSource {
  ChatMockDataSource() {
    final now = DateTime.now();
    DateTime ago({int d = 0, int h = 0, int m = 0}) =>
        now.subtract(Duration(days: d, hours: h, minutes: m));
    _client.addAll([
      ConversationModel(
        id: 'c1',
        participant: const ParticipantModel(
          id: 't1',
          name: 'Dr. Amara Okafor',
          subtitle: 'Clinical Psychologist',
          verified: true,
          online: true,
        ),
        last: 'That sounds like real progress — well done this week.',
        updatedAt: ago(m: 35),
        unread: 2,
        sessionTitle: 'Session confirmed',
        sessionAt: DateTime(now.year, now.month, now.day + 5, 16),
      ),
      ConversationModel(
        id: 'c2',
        participant: const ParticipantModel(
          id: 't2',
          name: 'Daniel Mercer',
          subtitle: 'Psychotherapist',
          verified: true,
        ),
        last: 'See you Thursday. Take it gently until then.',
        updatedAt: ago(d: 1, h: 2),
      ),
      ConversationModel(
        id: 'c3',
        participant: const ParticipantModel(
          id: 't3',
          name: 'Dr. Priya Nair',
          subtitle: 'Counselling Psychologist',
          verified: true,
          online: true,
        ),
        last: 'I’ve shared a short breathing exercise for tonight.',
        updatedAt: ago(d: 4),
      ),
    ]);
    _pro.addAll([
      ConversationModel(
        id: 'pc1',
        participant: const ParticipantModel(
          id: 'cl1',
          name: 'Jordan Mills',
          subtitle: 'Anxiety & work stress',
          online: true,
        ),
        last: 'A bit up and down, but I tried the grounding exercise twice.',
        updatedAt: ago(m: 20),
        unread: 1,
      ),
      ConversationModel(
        id: 'pc2',
        participant: const ParticipantModel(
          id: 'cl2',
          name: 'Leah Karim',
          subtitle: 'Weekly · Video',
        ),
        last: 'Thank you — see you at 1pm.',
        updatedAt: ago(h: 3),
      ),
      ConversationModel(
        id: 'pc3',
        participant: const ParticipantModel(
          id: 'cl3',
          name: 'Sam Rivera',
          subtitle: 'Weekly · Chat',
          online: true,
        ),
        last: 'Could we move to 4pm next week?',
        updatedAt: ago(d: 1),
      ),
      ConversationModel(
        id: 'pc4',
        participant: const ParticipantModel(
          id: 'cl4',
          name: 'Noah Bennett',
          subtitle: 'Intro session',
        ),
        last: 'Looking forward to our first session.',
        updatedAt: ago(d: 2),
      ),
    ]);
    DateTime t(int m) => ago(m: m);
    _messages['c1'] = [
      ChatMessageModel(
        id: 'm1',
        fromMe: false,
        text: 'Hi — how have you been since our last session?',
        sentAt: t(49),
      ),
      ChatMessageModel(
        id: 'm2',
        fromMe: true,
        text: 'A bit up and down, but I tried the grounding exercise twice.',
        sentAt: t(41),
        read: true,
      ),
      ChatMessageModel(
        id: 'm3',
        fromMe: false,
        text: 'That sounds like real progress — well done this week.',
        sentAt: t(35),
      ),
    ];
    _messages['pc1'] = [
      ChatMessageModel(
        id: 'n1',
        fromMe: true,
        text: 'Hi — how have you been since our last session?',
        sentAt: t(49),
        read: true,
      ),
      ChatMessageModel(
        id: 'n2',
        fromMe: false,
        text: 'A bit up and down, but I tried the grounding exercise twice.',
        sentAt: t(20),
      ),
    ];
  }

  final _client = <ConversationModel>[];
  final _pro = <ConversationModel>[];
  final _messages = <String, List<ChatMessageModel>>{};
  final _controllers = <String, StreamController<ChatEvent>>{};
  final _rand = Random();

  static const _replies = [
    'That makes a lot of sense. Thank you for sharing that with me.',
    'I hear you. Let’s gently unpack that together.',
    'You’re doing the work, and it shows. 🌱',
  ];

  ConversationModel _find(String id) => [..._client, ..._pro].firstWhere(
    (c) => c.id == id,
    orElse: () => throw const NotFoundException(),
  );

  @override
  Future<List<ConversationModel>> conversations({
    required bool asProfessional,
  }) async {
    await mockLatency();
    return List.of(asProfessional ? _pro : _client)
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  @override
  Future<List<ChatMessageModel>> messages(String id) async {
    await mockLatency(250);
    final c = _find(id);
    return _messages.putIfAbsent(
      id,
      () => [
        ChatMessageModel(
          id: '${id}_0',
          fromMe: false,
          text: c.last,
          sentAt: c.updatedAt,
        ),
      ],
    );
  }

  @override
  Future<ChatMessageModel> send(String id, String text) async {
    await mockLatency(150);
    final m = ChatMessageModel(
      id: 'x${DateTime.now().microsecondsSinceEpoch}',
      fromMe: true,
      text: text,
      sentAt: DateTime.now(),
    );
    _messages.putIfAbsent(id, () => []).add(m);
    final c = _find(id)
      ..last = text
      ..updatedAt = m.sentAt;
    _simulateReply(c);
    return m;
  }

  void _simulateReply(ConversationModel c) {
    final ctrl = _controllers[c.id];
    Future.delayed(
      const Duration(milliseconds: 600),
      () => ctrl?.add(TypingEvent(true)),
    );
    Future.delayed(const Duration(milliseconds: 2200), () {
      for (final m in _messages[c.id]!) {
        if (m.fromMe) m.read = true;
      }
      final r = ChatMessageModel(
        id: 'r${DateTime.now().microsecondsSinceEpoch}',
        fromMe: false,
        text: _replies[_rand.nextInt(_replies.length)],
        sentAt: DateTime.now(),
      );
      _messages[c.id]!.add(r);
      c
        ..last = r.text
        ..updatedAt = r.sentAt;
      ctrl
        ?..add(TypingEvent(false))
        ..add(ReadEvent())
        ..add(MessageEvent(r));
    });
  }

  @override
  Future<void> markRead(String id) async => _find(id).unread = 0;

  @override
  Future<String> conversationWith(String participantId) async {
    await mockLatency(150);
    final all = [..._client, ..._pro];
    final existing = all
        .where((c) => c.participant.id == participantId)
        .firstOrNull;
    if (existing != null) return existing.id;
    throw const NotFoundException();
  }

  @override
  Stream<ChatEvent> events(String id) =>
      (_controllers[id] ??= StreamController<ChatEvent>.broadcast()).stream;
}
