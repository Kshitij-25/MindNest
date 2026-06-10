import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mindnest_app/core/theme/theme.dart';

import '../../domain/entities/conversation.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message, required this.last});
  final Message message;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final me = message.fromMe;
    return Column(
      crossAxisAlignment: me
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.72,
          ),
          margin: const EdgeInsets.only(top: 2),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
          decoration: BoxDecoration(
            color: me ? c.primary : c.surface,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft: Radius.circular(me ? 20 : 6),
              bottomRight: Radius.circular(me ? 6 : 20),
            ),
            boxShadow: me ? c.primaryGlow() : c.shSm,
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
        Padding(
          padding: const EdgeInsets.fromLTRB(6, 4, 6, 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message.time, style: MnText.cap.copyWith(color: c.ink3)),
              if (me && last)
                Text(
                  ' · ${message.read ? 'Read' : 'Sent'}',
                  style: MnText.cap.copyWith(
                    color: message.read ? c.primary : c.ink4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class TypingDots extends StatefulWidget {
  const TypingDots({super.key});
  @override
  State<TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<TypingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat();

  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < 3; i++)
          AnimatedBuilder(
            animation: _ctl,
            builder: (_, _) {
              final phase = (_ctl.value - i * 0.15) % 1.0;
              final lift = phase < 0.3 ? sin(phase / 0.3 * pi) : 0.0;
              return Container(
                margin: EdgeInsets.only(right: i < 2 ? 5 : 0),
                transform: Matrix4.translationValues(0, -5 * lift, 0),
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: c.ink4.withValues(alpha: 0.4 + 0.6 * lift),
                  shape: BoxShape.circle,
                ),
              );
            },
          ),
      ],
    );
  }
}
