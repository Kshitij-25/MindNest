import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../domain/entities/journal_entry.dart';
import '../bloc/journal_bloc.dart';
import '../bloc/journal_editor_cubit.dart';
import '../widgets/journal_editor.dart';
import '../widgets/journal_widgets.dart';

@RoutePage()
class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<JournalBloc>()..add(const JournalEvent.load()),
      child: ResponsiveLayout(phone: (_) => const _PhoneJournal(), tablet: (_) => const _SplitJournal()),
    );
  }
}

void _openEntry(BuildContext context, JournalEntry e) => e.draft
    ? context.router.push(JournalWriteRoute(entryId: e.id))
    : context.router.push(JournalEntryRoute(entryId: e.id));

class _PhoneJournal extends StatelessWidget {
  const _PhoneJournal();

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocBuilder<JournalBloc, JournalState>(
      builder: (context, s) {
        final bloc = context.read<JournalBloc>();
        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, _) => [
              SliverAppBar(
                pinned: true,
                backgroundColor: c.bg,
                surfaceTintColor: Colors.transparent,
                automaticallyImplyLeading: false,
                toolbarHeight: s.entries.isEmpty ? 64 : 120,
                titleSpacing: 20,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Semantics(header: true, child: Text('Journal', style: context.text.title1))),
                        MnIconButton(
                          icon: MnIcons.pen,
                          tooltip: 'New entry',
                          iconSize: 19,
                          stroke: 2,
                          background: c.primary,
                          color: c.onPrimary,
                          onPressed: () => context.router.push(JournalWriteRoute()),
                        ),
                      ],
                    ),
                    if (s.entries.isNotEmpty) ...[
                      const SizedBox(height: 14),
                      MnSegmented<JournalView>(
                        options: JournalView.values,
                        value: s.view,
                        labelOf: (v) => v == JournalView.list ? 'List' : 'Calendar',
                        onChanged: (v) => bloc.add(JournalEvent.viewChanged(v)),
                      ),
                    ],
                  ],
                ),
              ),
            ],
            body: s.status.isLoading && s.entries.isEmpty
                ? const LoadingView()
                : s.entries.isEmpty
                    ? EmptyState(
                        icon: MnIcons.feather,
                        title: 'Your private space',
                        message: 'Journaling is just for you — a quiet place to notice how you feel. Nothing here is ever shared.',
                        actionLabel: 'Write your first entry',
                        onAction: () => context.router.push(JournalWriteRoute()),
                      )
                    : AnimatedSwitcher(
                        duration: MnMotion.base,
                        child: s.view == JournalView.list
                            ? ListView.separated(
                                key: const ValueKey('list'),
                                physics: Adaptive.scrollPhysics(context),
                                padding: EdgeInsets.fromLTRB(20, 12, 20, 24 + MediaQuery.paddingOf(context).bottom),
                                itemCount: s.entries.length,
                                separatorBuilder: (_, _) => const SizedBox(height: 12),
                                itemBuilder: (context, i) => FadeUp(
                                  delay: Duration(milliseconds: 40 + 60 * i.clamp(0, 6)),
                                  child: JournalRow(entry: s.entries[i], onTap: () => _openEntry(context, s.entries[i])),
                                ),
                              )
                            : SingleChildScrollView(
                                key: const ValueKey('cal'),
                                padding: EdgeInsets.fromLTRB(20, 14, 20, 24 + MediaQuery.paddingOf(context).bottom),
                                child: JournalCalendar(
                                  month: s.month,
                                  byDay: s.byDay,
                                  onPick: (e) => _openEntry(context, e),
                                  onMonthChanged: (d) => bloc.add(JournalEvent.monthChanged(d)),
                                ),
                              ),
                      ),
          ),
        );
      },
    );
  }
}

/// Tablet: list pane on the left, entry / composer on the right.
class _SplitJournal extends StatelessWidget {
  const _SplitJournal();

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocBuilder<JournalBloc, JournalState>(
      builder: (context, s) {
        final bloc = context.read<JournalBloc>();
        final sel = s.selected;
        return Scaffold(
          body: SafeArea(
            bottom: false,
            child: Row(
              children: [
                SizedBox(
                  width: context.isWide ? 400 : 340,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text('Journal', style: context.text.title2)),
                                MnIconButton(
                                  icon: MnIcons.plus,
                                  tooltip: 'New entry',
                                  square: true,
                                  stroke: 2.4,
                                  iconSize: 20,
                                  background: c.primary,
                                  color: c.onPrimary,
                                  onPressed: () => bloc.add(const JournalEvent.composeToggled(true)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                for (final f in JournalFilter.values) ...[
                                  MnChip(
                                    label: switch (f) {
                                      JournalFilter.all => 'All',
                                      JournalFilter.favourites => 'Favourites',
                                      JournalFilter.drafts => 'Drafts',
                                    },
                                    selected: s.filter == f,
                                    onTap: () => bloc.add(JournalEvent.filterChanged(f)),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Hairline(),
                      Expanded(
                        child: s.visible.isEmpty
                            ? Center(
                                child: Text('Nothing here yet', style: context.text.callout.copyWith(color: c.ink3)),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.all(10),
                                itemCount: s.visible.length,
                                itemBuilder: (context, i) {
                                  final e = s.visible[i];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: JournalRow(
                                      entry: e,
                                      compact: true,
                                      selected: !s.composing && sel?.id == e.id,
                                      onTap: () => bloc.add(JournalEvent.selected(e.id)),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
                const Hairline(vertical: true),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: MnMotion.base,
                    child: s.composing || (sel != null && sel.draft)
                        ? _InlineComposer(key: ValueKey('compose-${sel?.draft == true ? sel!.id : 'new'}'), draft: s.composing ? null : sel)
                        : sel == null
                            ? EmptyState(
                                icon: MnIcons.feather,
                                title: 'Your private space',
                                message: 'Select an entry or start a new one.',
                                actionLabel: 'New entry',
                                onAction: () => bloc.add(const JournalEvent.composeToggled(true)),
                              )
                            : _EntryPane(key: ValueKey(sel.id), entry: sel),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _EntryPane extends StatelessWidget {
  const _EntryPane({super.key, required this.entry});
  final JournalEntry entry;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<JournalBloc>();
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(40, 32, 40, 40),
          child: JournalEntryContent(entry: entry, large: true),
        ),
        Positioned(
          top: 24,
          right: 28,
          child: Row(
            children: [
              MnIconButton(
                icon: MnIcons.star,
                tooltip: entry.favourite ? 'Remove from favourites' : 'Add to favourites',
                square: true,
                iconSize: 18,
                color: entry.favourite ? context.colors.streak : null,
                onPressed: () => bloc.add(JournalEvent.favouriteToggled(entry.id)),
              ),
              const SizedBox(width: 8),
              MnIconButton(
                icon: MnIcons.edit,
                tooltip: 'Edit entry',
                square: true,
                iconSize: 18,
                onPressed: () => context.router.push(JournalWriteRoute(entryId: entry.id)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InlineComposer extends StatelessWidget {
  const _InlineComposer({super.key, this.draft});
  final JournalEntry? draft;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocProvider(
      create: (_) => getIt<JournalEditorCubit>()..start(draft),
      child: BlocBuilder<JournalEditorCubit, JournalEditorState>(
        builder: (context, s) {
          final cubit = context.read<JournalEditorCubit>();
          return ColoredBox(
            color: c.paper,
            child: Column(
              children: [
                const Expanded(child: JournalEditor(inline: true, prompt: 'What is one small thing that felt good today?')),
                Container(
                  color: c.paper,
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 20),
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 340,
                    child: Row(
                      children: [
                        Expanded(
                          child: MnButton.secondary(
                            label: 'Cancel',
                            size: MnButtonSize.small,
                            onPressed: () => context.read<JournalBloc>().add(const JournalEvent.composeToggled(false)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 3,
                          child: MnButton(
                            label: 'Save entry',
                            size: MnButtonSize.small,
                            loading: s.saving,
                            onPressed: s.entry.body.trim().isEmpty ? null : cubit.save,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
