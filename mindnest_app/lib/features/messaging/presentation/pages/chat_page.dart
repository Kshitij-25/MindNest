import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';

import '../cubit/chat_cubit.dart';
import '../widgets/chat_widgets.dart';

/// Arguments for the chat page passed via GoRouter `extra`.
class ChatArgs {
  const ChatArgs({this.asProfessional = false, this.name});
  final bool asProfessional;
  final String? name;
}

class ChatPage extends StatelessWidget {
  const ChatPage({
    super.key,
    required this.conversationId,
    this.asProfessional = false,
    this.conversationName,
  });
  final String conversationId;
  final bool asProfessional;
  final String? conversationName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ChatCubit>()
        ..load(
          conversationId: conversationId,
          asPro: asProfessional,
          fallbackName: conversationName ?? 'Dr. Amara Okafor',
        ),
      child: _ChatView(asProfessional: asProfessional),
    );
  }
}

class _ChatView extends StatefulWidget {
  const _ChatView({required this.asProfessional});
  final bool asProfessional;
  @override
  State<_ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<_ChatView> {
  final _input = TextEditingController();
  final _scroll = ScrollController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _input.addListener(() {
      final has = _input.text.trim().isNotEmpty;
      if (has != _hasText) setState(() => _hasText = has);
    });
  }

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _scrollDown() => WidgetsBinding.instance.addPostFrameCallback((_) {
    if (_scroll.hasClients) _scroll.jumpTo(_scroll.position.maxScrollExtent);
  });

  void _send() {
    final text = _input.text;
    if (text.trim().isEmpty) return;
    context.read<ChatCubit>().send(text, TimeOfDay.now().format(context));
    _input.clear();
    _scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return MnScaffold(
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (_, _) => _scrollDown(),
        builder: (context, state) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(12, safeTop(context) + 6, 12, 10),
                decoration: BoxDecoration(
                  color: c.bg.withValues(alpha: 0.95),
                  border: Border(
                    bottom: BorderSide(color: c.hairline, width: 0.5),
                  ),
                ),
                child: Row(
                  children: [
                    NavBtn(icon: 'back', onTap: () => context.pop()),
                    const SizedBox(width: 10),
                    Avatar(state.name, size: 40, photo: true),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.name,
                            style: MnText.headline.copyWith(color: c.ink),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            state.typing ? 'typing…' : 'Online',
                            style: MnText.cap.copyWith(
                              color: state.typing ? c.primary : c.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const NavBtn(icon: 'phone', iconSize: 19, stroke: 1.9),
                    const SizedBox(width: 6),
                    const NavBtn(icon: 'video', iconSize: 20, stroke: 1.9),
                  ],
                ),
              ),
              Expanded(
                child: NoGlow(
                  child: ListView(
                    controller: _scroll,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: c.fill,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            'Today',
                            style: MnText.cap.copyWith(color: c.ink3),
                          ),
                        ),
                      ),
                      if (!widget.asProfessional)
                        MnCard(
                          kind: MnCardKind.flat,
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: c.primaryTint,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: MnIcon(
                                  'calendar',
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
                                      'Session confirmed',
                                      style: MnText.foot.copyWith(
                                        color: c.ink,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'Thu, 5 June · 4:00 PM',
                                      style: MnText.cap.copyWith(color: c.ink3),
                                    ),
                                  ],
                                ),
                              ),
                              const Badge2('Accepted', kind: BadgeKind.accept),
                            ],
                          ),
                        ),
                      if (!widget.asProfessional) const SizedBox(height: 12),
                      for (var i = 0; i < state.messages.length; i++)
                        MessageBubble(
                          message: state.messages[i],
                          last: i == state.messages.length - 1,
                        ),
                      if (state.typing)
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
                              boxShadow: c.shSm,
                            ),
                            child: const TypingDots(),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                  14,
                  10,
                  14,
                  safeBottom(context) + 12,
                ),
                decoration: BoxDecoration(
                  color: c.bg,
                  border: Border(
                    top: BorderSide(color: c.hairline, width: 0.5),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const NavBtn(icon: 'plus', stroke: 2),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: c.surface,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: c.hairline, width: 1.5),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: TextField(
                          controller: _input,
                          minLines: 1,
                          maxLines: 4,
                          cursorColor: c.primary,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => _send(),
                          style: MnText.body.copyWith(color: c.ink),
                          decoration: InputDecoration(
                            isCollapsed: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            border: InputBorder.none,
                            hintText: 'Message…',
                            hintStyle: MnText.body.copyWith(color: c.ink4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: _send,
                      child: AnimatedScale(
                        scale: _hasText ? 1 : 0.9,
                        duration: const Duration(milliseconds: 180),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: _hasText ? c.primary : c.fill2,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: MnIcon(
                            'send',
                            size: 20,
                            color: _hasText ? c.onPrimary : c.ink4,
                            stroke: 2,
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
      ),
    );
  }
}
