import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../bloc/journal_bloc.dart';
import '../widgets/journal_widgets.dart';

@RoutePage()
class JournalEntryPage extends StatelessWidget {
  const JournalEntryPage({super.key, @PathParam('id') required this.entryId});

  final String entryId;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocProvider.value(
      value: getIt<JournalBloc>(),
      child: BlocBuilder<JournalBloc, JournalState>(
        builder: (context, s) {
          final e = s.entries.where((x) => x.id == entryId).firstOrNull;
          return MnPage(
            background: c.paper,
            maxWidth: 680,
            header: MnNavHeader(
              transparent: true,
              trailing: e == null
                  ? null
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MnIconButton(
                          icon: MnIcons.more,
                          tooltip: 'More options',
                          onPressed: () async {
                            final action = await Adaptive.actionSheet<String>(
                              context,
                              actions: [
                                AdaptiveAction(
                                  label: e.favourite ? 'Remove from favourites' : 'Add to favourites',
                                  value: 'fav',
                                  icon: Icons.star_border_rounded,
                                ),
                                const AdaptiveAction(label: 'Delete entry', value: 'delete', icon: Icons.delete_outline, destructive: true),
                              ],
                            );
                            if (!context.mounted) return;
                            final bloc = context.read<JournalBloc>();
                            if (action == 'fav') bloc.add(JournalEvent.favouriteToggled(e.id));
                            if (action == 'delete') {
                              final ok = await Adaptive.confirm(
                                context,
                                title: 'Delete this entry?',
                                message: 'This can’t be undone.',
                                confirmLabel: 'Delete',
                                destructive: true,
                              );
                              if (ok && context.mounted) {
                                bloc.add(JournalEvent.deleted(e.id));
                                context.router.maybePop();
                              }
                            }
                          },
                        ),
                        MnIconButton(
                          icon: MnIcons.pen,
                          tooltip: 'Edit entry',
                          iconSize: 18,
                          stroke: 1.9,
                          onPressed: () => context.router.push(JournalWriteRoute(entryId: e.id)),
                        ),
                      ],
                    ),
            ),
            padding: const EdgeInsets.fromLTRB(26, 8, 26, 40),
            body: e == null ? const LoadingView() : JournalEntryContent(entry: e),
          );
        },
      ),
    );
  }
}
