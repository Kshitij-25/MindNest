import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';
import '../../domain/entities/conversation.dart';
import '../bloc/chat_thread_bloc.dart';

String conversationTime(DateTime t) {
  final now = DateTime.now();
  final diff = DateTime(
    now.year,
    now.month,
    now.day,
  ).difference(DateTime(t.year, t.month, t.day)).inDays;
  if (diff == 0) return DateFormat.jm().format(t);
  if (diff == 1) return 'Yesterday';
  if (diff < 7) return DateFormat.E().format(t);
  return DateFormat('d MMM').format(t);
}

class ConversationTile extends StatelessWidget {
  const ConversationTile({
    super.key,
    required this.conversation,
    required this.onTap,
    this.selected = false,
    this.dense = false,
  });
  final Conversation conversation;
  final VoidCallback onTap;
  final bool selected;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final cv = conversation;
    final unread = cv.unread > 0;
    return Semantics(
      button: true,
      selected: selected,
      label:
          '${cv.participant.name}. ${unread ? '${cv.unread} unread. ' : ''}${cv.lastMessage}',
      excludeSemantics: true,
      child: Pressable(
        onTap: onTap,
        scale: .98,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.all(dense ? 12 : 12),
          decoration: BoxDecoration(
            color: selected ? c.primaryTint : Colors.transparent,
            borderRadius: BorderRadius.circular(dense ? 14 : 18),
          ),
          child: Row(
            children: [
              MnAvatar(
                name: cv.participant.name,
                size: dense ? 48 : 54,
                photo: true,
                online: cv.participant.online,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Expanded(
                          child: Text(
                            cv.participant.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: dense
                                ? context.text.sub.copyWith(
                                    fontWeight: FontWeight.w700,
                                  )
                                : context.text.headline,
                          ),
                        ),
                        Text(
                          conversationTime(cv.updatedAt),
                          style: context.text.cap.copyWith(
                            color: unread ? c.primary : c.ink3,
                            fontWeight: unread
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Expanded(
                          child: cv.typing
                              ? Text(
                                  'typing…',
                                  style: context.text.callout.copyWith(
                                    color: c.primary,
                                  ),
                                )
                              : Text(
                                  cv.lastMessage,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      (dense
                                              ? context.text.cap
                                              : context.text.callout)
                                          .copyWith(
                                            color: unread ? c.ink : c.ink3,
                                            fontWeight: unread
                                                ? FontWeight.w600
                                                : FontWeight.w400,
                                          ),
                                ),
                        ),
                        if (unread) ...[
                          const SizedBox(width: 8),
                          Container(
                            constraints: const BoxConstraints(minWidth: 20),
                            height: 20,
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: c.primary,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              '${cv.unread}',
                              style: TextStyle(
                                color: c.onPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.showStatus,
    this.maxWidthFactor = .78,
  });
  final ChatMessage message;
  final bool showStatus;
  final double maxWidthFactor;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final me = message.fromMe;
    return FadeUp(
      duration: const Duration(milliseconds: 350),
      offset: 8,
      child: Align(
        alignment: me ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: me
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, box) => ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: box.maxWidth * maxWidthFactor,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    color: me ? c.primary : c.surface,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: Radius.circular(me ? 20 : 6),
                      bottomRight: Radius.circular(me ? 6 : 20),
                    ),
                    boxShadow: me
                        ? [
                            BoxShadow(
                              color: c.primaryRing,
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : MnShadows.sm(c),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 15.5,
                      height: 1.4,
                      color: me ? c.onPrimary : c.ink,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 4, 6, 6),
              child: Text.rich(
                TextSpan(
                  text: DateFormat.jm().format(message.sentAt),
                  children: [
                    if (me && showStatus)
                      TextSpan(
                        text: ' · ${message.read ? 'Read' : 'Sent'}',
                        style: TextStyle(
                          color: message.read ? c.primary : c.ink4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
                style: context.text.cap.copyWith(color: c.ink3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Full thread UI: header, pinned session context, messages and composer.
class ChatThreadView extends StatefulWidget {
  const ChatThreadView({
    super.key,
    this.showBack = true,
    this.embedded = false,
  });
  final bool showBack;
  final bool embedded;

  @override
  State<ChatThreadView> createState() => _ChatThreadViewState();
}

class _ChatThreadViewState extends State<ChatThreadView> {
  final _ctrl = TextEditingController();
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _send() {
    final t = _ctrl.text.trim();
    if (t.isEmpty) return;
    Adaptive.tap(context);
    context.read<ChatThreadBloc>().add(ChatThreadEvent.sent(t));
    _ctrl.clear();
  }

  void _toBottom() => WidgetsBinding.instance.addPostFrameCallback((_) {
    if (_scroll.hasClients) {
      _scroll.animateTo(0, duration: MnMotion.slow, curve: MnMotion.easeOut);
    }
  });

  void _comingSoon(String what) => ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text('$what calls will be available soon')));

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocConsumer<ChatThreadBloc, ChatThreadState>(
      listenWhen: (a, b) =>
          a.messages.length != b.messages.length ||
          a.otherTyping != b.otherTyping,
      listener: (_, _) => _toBottom(),
      builder: (context, s) {
        final conv = s.conversation;
        if (conv == null) {
          return s.status.isFailure
              ? ErrorView(
                  message: s.error ?? 'Could not open this conversation.',
                )
              : const LoadingView();
        }
        final p = conv.participant;
        final items = <Widget>[
          Center(
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 4, 0, 14),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: c.fill,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                'Today',
                style: context.text.cap.copyWith(color: c.ink3),
              ),
            ),
          ),
          if (conv.session != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: MnCard(
                style: MnCardStyle.flat,
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    IconTile(
                      size: 36,
                      radius: 10,
                      child: MnIcon(
                        MnIcons.calendar,
                        size: 18,
                        color: c.primary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            conv.session!.title,
                            style: context.text.foot.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            DateFormat('EEE, d MMMM · h:mm a')
                                .format(conv.session!.startsAt),
                            style: context.text.cap.copyWith(color: c.ink3),
                          ),
                        ],
                      ),
                    ),
                    MnBadge.status(conv.session!.status),
                  ],
                ),
              ),
            ),
          for (final (i, m) in s.messages.indexed)
            MessageBubble(
              message: m,
              showStatus: i == s.messages.length - 1,
              maxWidthFactor: widget.embedded ? .64 : .78,
            ),
          if (s.otherTyping)
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: c.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(6),
                  ),
                  boxShadow: MnShadows.sm(c),
                ),
                child: TypingDots(color: c.ink4),
              ),
            ),
        ];

        return Column(
          children: [
            // Header
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    widget.embedded ? 24 : 12,
                    (widget.embedded
                        ? 16
                        : MediaQuery.paddingOf(context).top + 6),
                    widget.embedded ? 24 : 12,
                    widget.embedded ? 16 : 10,
                  ),
                  decoration: BoxDecoration(
                    color: c.bg.withValues(alpha: .88),
                    border: Border(
                      bottom: BorderSide(color: c.hairline, width: .5),
                    ),
                  ),
                  child: Row(
                    children: [
                      if (widget.showBack) ...[
                        MnIconButton(
                          icon: MnIcons.back,
                          tooltip: 'Back',
                          onPressed: () => Navigator.of(context).maybePop(),
                        ),
                        const SizedBox(width: 4),
                      ],
                      MnAvatar(
                        name: p.name,
                        size: widget.embedded ? 44 : 40,
                        photo: true,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    p.name,
                                    style: context.text.headline,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (p.verified) ...[
                                  const SizedBox(width: 5),
                                  const VerifiedBadge(size: 14),
                                ],
                              ],
                            ),
                            AnimatedSwitcher(
                              duration: MnMotion.base,
                              child: Text(
                                s.otherTyping
                                    ? 'typing…'
                                    : (p.online
                                          ? 'Online now'
                                          : 'Last seen recently'),
                                key: ValueKey(s.otherTyping),
                                style: context.text.cap.copyWith(
                                  color: s.otherTyping
                                      ? c.primary
                                      : (p.online ? c.green : c.ink3),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      MnIconButton(
                        icon: MnIcons.phone,
                        tooltip: 'Voice call',
                        iconSize: 19,
                        stroke: 1.9,
                        onPressed: () => _comingSoon('Voice'),
                      ),
                      MnIconButton(
                        icon: MnIcons.video,
                        tooltip: 'Video call',
                        iconSize: 20,
                        stroke: 1.9,
                        background: widget.embedded ? c.primary : null,
                        color: widget.embedded ? c.onPrimary : null,
                        onPressed: () => _comingSoon('Video'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Messages (reversed so the list sticks to the bottom).
            Expanded(
              child: ListView(
                controller: _scroll,
                reverse: true,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.symmetric(
                  horizontal: widget.embedded ? 32 : 16,
                  vertical: 16,
                ),
                children: items.reversed.toList(),
              ),
            ),
            // Composer
            Container(
              padding: EdgeInsets.fromLTRB(
                14,
                10,
                14,
                widget.embedded
                    ? 14
                    : MediaQuery.paddingOf(context).bottom + 12,
              ),
              decoration: BoxDecoration(
                color: c.bg,
                border: Border(top: BorderSide(color: c.hairline, width: .5)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MnIconButton(
                    icon: MnIcons.plus,
                    tooltip: 'Attach',
                    stroke: 2,
                    onPressed: () => Adaptive.actionSheet<String>(
                      context,
                      actions: const [
                        AdaptiveAction(
                          label: 'Photo',
                          value: 'photo',
                          icon: Icons.image_outlined,
                        ),
                        AdaptiveAction(
                          label: 'Document',
                          value: 'doc',
                          icon: Icons.description_outlined,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Container(
                      constraints: const BoxConstraints(
                        minHeight: 44,
                        maxHeight: 120,
                      ),
                      decoration: BoxDecoration(
                        color: c.surface,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: c.hairline, width: 1.5),
                      ),
                      child: TextField(
                        controller: _ctrl,
                        maxLines: null,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _send(),
                        style: context.text.body,
                        cursorColor: c.primary,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          hintText: 'Message…',
                          hintStyle: context.text.body.copyWith(color: c.ink4),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 11,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Semantics(
                    button: true,
                    label: 'Send',
                    child: GestureDetector(
                      onTap: _send,
                      child: AnimatedScale(
                        scale: _ctrl.text.trim().isEmpty ? .9 : 1,
                        duration: MnMotion.base,
                        child: AnimatedContainer(
                          duration: MnMotion.base,
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: _ctrl.text.trim().isEmpty
                                ? c.fill2
                                : c.primary,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: MnIcon(
                            MnIcons.send,
                            size: 20,
                            color: _ctrl.text.trim().isEmpty
                                ? c.ink4
                                : c.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
