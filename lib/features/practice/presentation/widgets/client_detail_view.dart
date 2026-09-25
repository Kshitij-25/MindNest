import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';
import '../../domain/entities/practice_entities.dart';
import '../bloc/clients_cubit.dart';
import 'practice_widgets.dart';

/// Client profile with notes / history / goals tabs.
class ClientDetailView extends StatefulWidget {
  const ClientDetailView({super.key, required this.onMessage, this.padding = const EdgeInsets.fromLTRB(32, 28, 32, 40)});
  final ValueChanged<Client> onMessage;
  final EdgeInsets padding;

  @override
  State<ClientDetailView> createState() => _ClientDetailViewState();
}

class _ClientDetailViewState extends State<ClientDetailView> {
  final _note = TextEditingController();

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocBuilder<ClientDetailCubit, ClientDetailState>(
      builder: (context, s) {
        final d = s.detail;
        if (d == null) return const LoadingView();
        final cubit = context.read<ClientDetailCubit>();
        final cl = d.client;
        final statusCol = clientStatusColor(c, cl.status);
        final stats = [('Sessions', '${cl.sessions}'), ('Client since', cl.since), ('Next', cl.next), ('Status', cl.status.label)];
        final wide = context.isTablet;
        return SingleChildScrollView(
          padding: widget.padding.add(EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  MnAvatar(name: cl.name, size: wide ? 64 : 56, photo: true, ring: true),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cl.name, style: wide ? context.text.title1 : context.text.title2),
                        const SizedBox(height: 2),
                        Text(cl.focus, style: context.text.sub.copyWith(color: c.ink2)),
                      ],
                    ),
                  ),
                  if (wide) ...[
                    MnButton.secondary(label: 'Message', icon: MnIcons.message, size: MnButtonSize.small, expand: false, onPressed: () => widget.onMessage(cl)),
                    const SizedBox(width: 8),
                    MnButton(label: 'Start session', icon: MnIcons.video, size: MnButtonSize.small, expand: false, onPressed: () => widget.onMessage(cl)),
                  ],
                ],
              ),
              if (!wide) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: MnButton.secondary(label: 'Message', icon: MnIcons.message, size: MnButtonSize.small, onPressed: () => widget.onMessage(cl))),
                    const SizedBox(width: 8),
                    Expanded(child: MnButton(label: 'Start session', icon: MnIcons.video, size: MnButtonSize.small, onPressed: () => widget.onMessage(cl))),
                  ],
                ),
              ],
              const SizedBox(height: 22),
              ResponsiveGrid(
                columns: wide ? 4 : 2,
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final st in stats)
                    MnCard(
                      style: MnCardStyle.inset,
                      radius: 18,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(st.$1, style: context.text.cap.copyWith(color: c.ink3)),
                          const SizedBox(height: 3),
                          Text(st.$2, style: context.text.headline.copyWith(color: st.$1 == 'Status' ? statusCol : c.ink)),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 18),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 300,
                  child: MnSegmented<ClientDetailTab>(
                    options: ClientDetailTab.values,
                    value: s.tab,
                    labelOf: (t) => switch (t) {
                      ClientDetailTab.notes => 'Notes',
                      ClientDetailTab.history => 'History',
                      ClientDetailTab.goals => 'Goals',
                    },
                    onChanged: cubit.setTab,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              AnimatedSwitcher(
                duration: MnMotion.base,
                child: switch (s.tab) {
                  ClientDetailTab.notes => Column(
                      key: const ValueKey('notes'),
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        MnCard(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextField(
                                controller: _note,
                                minLines: 2,
                                maxLines: 6,
                                style: context.text.callout,
                                cursorColor: c.primary,
                                decoration: InputDecoration(
                                  isCollapsed: true,
                                  border: InputBorder.none,
                                  hintText: 'Add a private session note…',
                                  hintStyle: context.text.callout.copyWith(color: c.ink4),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  MnIcon(MnIcons.lock, size: 13, color: c.ink3),
                                  const SizedBox(width: 5),
                                  Expanded(child: Text('Private & encrypted', style: context.text.cap.copyWith(color: c.ink3))),
                                  MnButton(
                                    label: 'Save note',
                                    size: MnButtonSize.small,
                                    expand: false,
                                    loading: s.savingNote,
                                    onPressed: () async {
                                      if (await cubit.addNote(_note.text)) _note.clear();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        for (final n in d.notes)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: FadeUp(
                              child: MnCard(
                                style: MnCardStyle.flat,
                                padding: const EdgeInsets.all(18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        MnBadge(label: n.tag),
                                        const SizedBox(width: 10),
                                        Text(DateFormat('d MMM').format(n.date), style: context.text.cap.copyWith(color: c.ink3)),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(n.text, style: context.text.body.copyWith(color: c.ink2, height: 1.6)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ClientDetailTab.history => Column(
                      key: const ValueKey('history'),
                      children: [
                        for (final (i, h) in d.history.indexed)
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Column(
                                  children: [
                                    Container(width: 12, height: 12, decoration: BoxDecoration(color: c.primary, shape: BoxShape.circle)),
                                    if (i < d.history.length - 1)
                                      Expanded(child: Container(width: 2, margin: const EdgeInsets.only(top: 4), color: c.hairline)),
                                  ],
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 18),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(h.clientName, style: context.text.headline),
                                        Text('${DateFormat('d MMM').format(h.startsAt)} · Completed', style: context.text.cap.copyWith(color: c.ink3)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ClientDetailTab.goals => Column(
                      key: const ValueKey('goals'),
                      children: [
                        for (final g in d.goals)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: MnCard(
                              style: MnCardStyle.flat,
                              onTap: () => cubit.toggleGoal(g),
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  IgnorePointer(child: MnCheckbox(value: g.done, round: true, size: 26, onChanged: (_) {})),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Text(
                                      g.text,
                                      style: context.text.body.copyWith(
                                        color: g.done ? c.ink3 : c.ink,
                                        decoration: g.done ? TextDecoration.lineThrough : null,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
