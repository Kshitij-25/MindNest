import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mindnest_app/core/theme/text.dart';
import 'package:mindnest_app/core/theme/tokens.dart';
import 'package:mindnest_app/core/widgets/common.dart';
import 'package:mindnest_app/core/widgets/controls.dart';
import 'package:mindnest_app/core/widgets/icon.dart';
import 'package:mindnest_app/core/network/wellness_api.dart';
import 'package:mindnest_app/core/widgets/nav.dart';

class _Msg {
  _Msg(this.from, this.text, this.time);
  final String from, text, time;
  bool read = false;
}

/// Quick-reply chips (UI scaffolding, not user data).
const _suggestions = [
  'Try box breathing',
  'Reframe the deadline',
  'Plan a wind-down',
];

/// What the coach draws on — capability labels shown in the context sheet.
const _usedContext = [
  'Mood history',
  'Journals',
  'Insights',
  'Memory',
  'Recommendations',
];

/// AI Coach (`tabChats`) — grounded in the user's mood, journals & insights,
/// not a generic chatbot.
class AiCoachPage extends StatefulWidget {
  const AiCoachPage({super.key});
  @override
  State<AiCoachPage> createState() => _AiCoachPageState();
}

class _AiCoachPageState extends State<AiCoachPage> {
  final List<_Msg> _msgs = [];
  final _input = TextEditingController();
  final _scroll = ScrollController();
  bool _typing = false;
  int _replyIdx = 0;
  String? _conversationId;

  static const _replies = [
    'That makes sense. Given your week, going gently with yourself seems wise.',
    'I hear you. Want me to pull up the breathing exercise that helped you last deadline?',
    'Noticing that is real progress. Your journals show you’re getting kinder to yourself. 🌱',
  ];

  String get _fallbackReply => _replies[_replyIdx++ % _replies.length];

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(_scroll.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  Future<void> _send([String? preset]) async {
    final value = (preset ?? _input.text).trim();
    if (value.isEmpty) return;
    setState(() {
      _msgs.add(_Msg('me', value, 'now'));
      _input.clear();
      _typing = true;
    });
    _scrollDown();

    // Ask the backend coach (grounded in mood/journals/insights). Fall back to
    // a gentle canned reply if the API is unreachable.
    String reply;
    try {
      final r = await wellnessApi.coachChat(
        value,
        conversationId: _conversationId,
      );
      if (r.conversationId.isNotEmpty) _conversationId = r.conversationId;
      reply = r.reply.trim().isEmpty ? _fallbackReply : r.reply.trim();
    } catch (_) {
      reply = _fallbackReply;
    }
    if (!mounted) return;
    setState(() {
      _typing = false;
      for (final m in _msgs) {
        if (m.from == 'me') m.read = true;
      }
      _msgs.add(_Msg('them', reply, 'now'));
    });
    _scrollDown();
  }

  void _showContext() {
    showMnSheet(context, (ctx) {
      final c = ctx.c;
      Widget tile(String icon, Color col, String text) => MnCard(
        kind: MnCardKind.inset,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        child: Row(
          children: [
            MnIcon(icon, size: 17, color: col, stroke: 1.9),
            const SizedBox(width: 10),
            Expanded(child: Text(text, style: MnText.callout.copyWith(color: c.ink2))),
          ],
        ),
      );
      Widget label(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 9),
        child: Text(t.toUpperCase(),
            style: MnText.cap.copyWith(color: c.ink3, fontWeight: FontWeight.w700, letterSpacing: 0.4)),
      );
      return SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SheetGrab(),
            const Text('What your coach knows', style: MnText.title3),
            const SizedBox(height: 6),
            Text(
              'Your coach draws on your private data to give grounded, personal replies. Nothing is shared.',
              style: MnText.callout.copyWith(color: c.ink2),
            ),
            const SizedBox(height: 18),
            label('What it draws on'),
            for (final u in _usedContext) ...[
              tile('checkCircle', c.primary, u),
              const SizedBox(height: 8),
            ],
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Column(
      children: [
        // header
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              padding: EdgeInsets.fromLTRB(16, safeTop(context) + 8, 16, 12),
              decoration: BoxDecoration(
                color: c.bg.withValues(alpha: 0.9),
                border: Border(bottom: BorderSide(color: c.hairline, width: 0.5)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: const Alignment(-0.6, -1),
                        end: const Alignment(0.6, 1),
                        colors: [c.moss500, c.primary],
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const MnIcon('sparkle', size: 22, color: Colors.white, stroke: 2),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('MindNest Coach', style: MnText.headline),
                        Text('Aware of your mood, journals & insights',
                            style: MnText.cap.copyWith(color: c.green, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  NavBtn(icon: 'info', iconSize: 20, onTap: _showContext),
                ],
              ),
            ),
          ),
        ),
        // messages
        Expanded(
          child: NoGlow(
            child: ListView(
              controller: _scroll,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              children: [
                MnCard(
                  kind: MnCardKind.flat,
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CONTEXT THE COACH IS USING',
                          style: MnText.cap.copyWith(
                              color: c.ink3, fontWeight: FontWeight.w700, letterSpacing: 0.4)),
                      const SizedBox(height: 9),
                      Wrap(
                        spacing: 7,
                        runSpacing: 7,
                        children: [
                          for (final u in _usedContext)
                            Container(
                              height: 28,
                              padding: const EdgeInsets.symmetric(horizontal: 11),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(color: c.hairline2, width: 1.5),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(color: c.primary, shape: BoxShape.circle),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(u, style: MnText.cap.copyWith(color: c.ink2)),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                if (_msgs.isEmpty && !_typing)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 32, 8, 8),
                    child: Column(
                      children: [
                        MnIcon('message', size: 36, color: c.ink4, stroke: 1.7),
                        const SizedBox(height: 14),
                        Text('Say hello to your coach',
                            style: MnText.title3.copyWith(color: c.ink)),
                        const SizedBox(height: 6),
                        Text(
                          'Share how you’re doing for grounded, personal support — drawn from your mood, journals and insights.',
                          textAlign: TextAlign.center,
                          style: MnText.callout.copyWith(color: c.ink2, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                for (var i = 0; i < _msgs.length; i++)
                  _Bubble(m: _msgs[i], last: i == _msgs.length - 1),
                if (_typing) const _TypingBubble(),
              ],
            ),
          ),
        ),
        // composer
        Container(
          decoration: BoxDecoration(
            color: c.bg,
            border: Border(top: BorderSide(color: c.hairline, width: 0.5)),
          ),
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Column(
            children: [
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  itemCount: _suggestions.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (_, i) => GestureDetector(
                    onTap: () => _send(_suggestions[i]),
                    child: Container(
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: c.hairline2, width: 1.5),
                      ),
                      child: Row(
                        children: [
                          MnIcon('sparkle', size: 14, color: c.primary),
                          const SizedBox(width: 6),
                          Text(_suggestions[i],
                              style: MnText.sub.copyWith(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.fromLTRB(14, 0, 14, safeBottom(context)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        constraints: const BoxConstraints(maxHeight: 100),
                        decoration: BoxDecoration(
                          color: c.surface,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: c.hairline, width: 1.5),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: TextField(
                          controller: _input,
                          minLines: 1,
                          maxLines: 4,
                          cursorColor: c.primary,
                          onChanged: (_) => setState(() {}),
                          style: MnText.body,
                          decoration: InputDecoration(
                            isCollapsed: true,
                            border: InputBorder.none,
                            hintText: 'Tell your coach how you’re doing…',
                            hintStyle: MnText.body.copyWith(color: c.ink4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: _send,
                      child: AnimatedScale(
                        scale: _input.text.trim().isEmpty ? 0.9 : 1,
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: _input.text.trim().isEmpty ? c.fill2 : c.primary,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: MnIcon('send',
                              size: 20,
                              color: _input.text.trim().isEmpty ? c.ink4 : c.onPrimary,
                              stroke: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.m, required this.last});
  final _Msg m;
  final bool last;
  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final me = m.from == 'me';
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        crossAxisAlignment: me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          FractionallySizedBox(
            alignment: me ? Alignment.centerRight : Alignment.centerLeft,
            widthFactor: 1,
            child: Align(
              alignment: me ? Alignment.centerRight : Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.72),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                  decoration: BoxDecoration(
                    color: me ? c.primary : c.surface,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: Radius.circular(me ? 20 : 6),
                      bottomRight: Radius.circular(me ? 6 : 20),
                    ),
                    boxShadow: me ? null : c.shSm,
                  ),
                  child: Text(m.text,
                      style: TextStyle(
                          fontSize: 15.5,
                          height: 1.4,
                          color: me ? c.onPrimary : c.ink)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(6, 4, 6, 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(m.time, style: MnText.cap.copyWith(color: c.ink3)),
                if (me && last)
                  Text(' · ${m.read ? 'Read' : 'Sent'}',
                      style: MnText.cap.copyWith(
                          color: m.read ? c.primary : c.ink4, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TypingBubble extends StatefulWidget {
  const _TypingBubble();
  @override
  State<_TypingBubble> createState() => _TypingBubbleState();
}

class _TypingBubbleState extends State<_TypingBubble> with SingleTickerProviderStateMixin {
  late final AnimationController _ctl =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..repeat();
  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 2),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(6),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: c.shSm,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < 3; i++)
              AnimatedBuilder(
                animation: _ctl,
                builder: (_, _) {
                  final t = ((_ctl.value - i * 0.15) % 1).clamp(0.0, 1.0);
                  final lift = t < 0.3 ? (t / 0.3) : (t < 0.6 ? (1 - (t - 0.3) / 0.3) : 0.0);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.5),
                    child: Transform.translate(
                      offset: Offset(0, -4 * lift),
                      child: Opacity(
                        opacity: 0.4 + 0.6 * lift,
                        child: Container(
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(color: c.ink4, shape: BoxShape.circle),
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
