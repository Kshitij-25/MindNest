import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/firebase/collections.dart';
import '../../../../core/firebase/inbox.dart';
import '../../../../core/firebase/session.dart';
import '../models/chat_models.dart';

/// Real-time chat API.
abstract interface class ChatDataSource {
  Future<List<ConversationModel>> conversations({required bool asProfessional});
  Future<ConversationModel> conversation(String id);
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

/// Conversations live at `conversations/{clientUid}_{proUid}` with
/// `participants`, per-member display info, unread counters and read
/// markers; messages are a subcollection.
@LazySingleton(as: ChatDataSource)
class FirestoreChatDataSource implements ChatDataSource {
  FirestoreChatDataSource(this._db, this._session);
  final FirebaseFirestore _db;
  final FirebaseSession _session;

  String get _me => _session.uid;

  String _other(Map<String, dynamic> d) =>
      readStrings(d['participants']).firstWhere((p) => p != _me, orElse: () => '');

  ConversationModel _conv(DocumentSnapshot<Map<String, dynamic>> s) {
    final d = s.data()!;
    final other = _other(d);
    final info = (d['members'] as Map?)?[other] as Map? ?? const {};
    final session = d['session'] as Map?;
    return ConversationModel(
      id: s.id,
      participant: ParticipantModel(
        id: other,
        name: info['name'] as String? ?? '',
        subtitle: info['subtitle'] as String? ?? '',
        verified: info['verified'] as bool? ?? false,
      ),
      last: d['last'] as String? ?? '',
      updatedAt: readDate(d['updatedAt']),
      unread: readInt((d['unread'] as Map?)?[_me]),
      typing: (d['typing'] as Map?)?[other] == true,
      sessionTitle: session?['title'] as String?,
      sessionAt: session == null ? null : readDate(session['at']),
      sessionStatus: session?['status'] as String?,
    );
  }

  ChatMessageModel _msg(DocumentSnapshot<Map<String, dynamic>> s, DateTime? otherRead) {
    final d = s.data()!;
    final sentAt = readDate(d['sentAt']);
    final mine = d['senderId'] == _me;
    return ChatMessageModel(
      id: s.id,
      fromMe: mine,
      text: d['text'] as String? ?? '',
      sentAt: sentAt,
      read: mine && otherRead != null && !sentAt.isAfter(otherRead),
    );
  }

  DateTime? _lastReadBy(Map<String, dynamic> d, String uid) {
    final v = (d['lastRead'] as Map?)?[uid];
    return v == null ? null : readDate(v);
  }

  @override
  Future<List<ConversationModel>> conversations({required bool asProfessional}) async {
    final snap = await _db.conversations
        .where('participants', arrayContains: _me)
        .orderBy('updatedAt', descending: true)
        .get();
    return snap.docs.map(_conv).toList();
  }

  @override
  Future<ConversationModel> conversation(String id) async {
    final snap = await _db.conversations.doc(id).get();
    if (!snap.exists) throw const NotFoundException();
    return _conv(snap);
  }

  @override
  Future<List<ChatMessageModel>> messages(String id) async {
    final conv = await _db.conversations.doc(id).get();
    if (!conv.exists) throw const NotFoundException();
    final otherRead = _lastReadBy(conv.data()!, _other(conv.data()!));
    final snap = await conv.reference.collection('messages').orderBy('sentAt').limitToLast(200).get();
    return snap.docs.map((m) => _msg(m, otherRead)).toList();
  }

  @override
  Future<ChatMessageModel> send(String id, String text) async {
    final convRef = _db.conversations.doc(id);
    final conv = await convRef.get();
    if (!conv.exists) throw const NotFoundException();
    final other = _other(conv.data()!);
    final myName = ((conv.data()!['members'] as Map?)?[_me] as Map?)?['name'] as String? ?? 'New message';
    final ref = convRef.collection('messages').doc();
    final now = DateTime.now();
    final batch = _db.batch()
      ..set(ref, {'senderId': _me, 'text': text, 'sentAt': FieldValue.serverTimestamp()})
      ..update(convRef, {
        'last': text,
        'updatedAt': FieldValue.serverTimestamp(),
        'unread.$other': FieldValue.increment(1),
      });
    // One rolling notification per conversation rather than one per message.
    Inbox.add(
      batch,
      _db,
      to: other,
      from: _me,
      type: 'message',
      title: 'New message',
      body: '$myName: “${text.length > 80 ? '${text.substring(0, 80)}…' : text}”',
      targetId: id,
      id: 'msg_$id',
    );
    await batch.commit();
    return ChatMessageModel(id: ref.id, fromMe: true, text: text, sentAt: now);
  }

  @override
  Future<void> markRead(String id) => _db.conversations.doc(id).update({
        'unread.$_me': 0,
        'lastRead.$_me': FieldValue.serverTimestamp(),
      });

  /// Finds or starts the thread between the current user and [participantId].
  @override
  Future<String> conversationWith(String participantId) async {
    final me = (await _db.user(_me).get()).data() ?? const {};
    final iAmPro = me['role'] == 'professional';
    final clientId = iAmPro ? participantId : _me;
    final proId = iAmPro ? _me : participantId;
    final ref = _db.conversations.doc('${clientId}_$proId');
    if ((await ref.get()).exists) return ref.id;

    final pro = (await _db.therapist(proId).get()).data();
    if (pro == null) throw const NotFoundException();
    Map<String, dynamic> clientInfo;
    if (iAmPro) {
      final c = (await _db.therapist(_me).collection('clients').doc(clientId).get()).data();
      if (c == null) throw const NotFoundException();
      clientInfo = {'name': c['name'] ?? 'Client', 'subtitle': c['focus'] ?? '', 'verified': false};
    } else {
      clientInfo = {'name': me['name'] ?? 'Client', 'subtitle': '', 'verified': false};
    }
    await ref.set({
      'participants': [clientId, proId],
      'clientId': clientId,
      'proId': proId,
      'members': {
        clientId: clientInfo,
        proId: {'name': pro['name'] ?? '', 'subtitle': pro['title'] ?? 'Therapist', 'verified': pro['verified'] ?? false},
      },
      'last': '',
      'updatedAt': FieldValue.serverTimestamp(),
      'unread': {clientId: 0, proId: 0},
    });
    return ref.id;
  }

  /// Incoming messages, typing and read receipts from the other participant
  /// while a thread is open. The sender's own messages are returned by [send].
  @override
  Stream<ChatEvent> events(String id) {
    final convRef = _db.conversations.doc(id);
    final openedAt = Timestamp.now();
    late final StreamController<ChatEvent> ctrl;
    final subs = <StreamSubscription<Object?>>[];
    DateTime? lastRead;
    bool? typing;

    ctrl = StreamController<ChatEvent>(
      onListen: () {
        subs
          ..add(convRef.snapshots().listen((s) {
            final d = s.data();
            if (d == null) return;
            final other = _other(d);
            final read = _lastReadBy(d, other);
            if (read != null && (lastRead == null || read.isAfter(lastRead!))) {
              if (lastRead != null) ctrl.add(ReadEvent());
              lastRead = read;
            }
            final t = (d['typing'] as Map?)?[other] == true;
            if (typing != null && t != typing) ctrl.add(TypingEvent(t));
            typing = t;
          }, onError: ctrl.addError))
          ..add(convRef
              .collection('messages')
              .where('sentAt', isGreaterThan: openedAt)
              .orderBy('sentAt')
              .snapshots()
              .listen((s) {
            for (final c in s.docChanges) {
              if (c.type != DocumentChangeType.added) continue;
              if (c.doc.data()?['senderId'] == _me) continue;
              ctrl.add(MessageEvent(_msg(c.doc, null)));
              markRead(id).ignore();
            }
          }, onError: ctrl.addError));
      },
      onCancel: () async {
        for (final s in subs) {
          await s.cancel();
        }
      },
    );
    return ctrl.stream;
  }
}
