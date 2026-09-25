import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../bloc/journal_bloc.dart';
import '../bloc/journal_editor_cubit.dart';
import '../widgets/journal_editor.dart';

@RoutePage(name: 'JournalWriteRoute')
class JournalWritePage extends StatelessWidget {
  const JournalWritePage({super.key, this.entryId, this.prompt});

  final String? entryId;
  final String? prompt;

  @override
  Widget build(BuildContext context) {
    final existing = entryId == null ? null : getIt<JournalBloc>().state.entries.where((e) => e.id == entryId).firstOrNull;
    return BlocProvider(
      create: (_) => getIt<JournalEditorCubit>()..start(existing),
      child: _WriteView(prompt: prompt),
    );
  }
}

class _WriteView extends StatelessWidget {
  const _WriteView({this.prompt});
  final String? prompt;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final cubit = context.read<JournalEditorCubit>();
    return BlocConsumer<JournalEditorCubit, JournalEditorState>(
      listenWhen: (a, b) => a.error != b.error && b.error != null,
      listener: (context, s) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s.error!))),
      builder: (context, s) {
        if (s.saved) {
          return Scaffold(
            backgroundColor: c.bg,
            body: JournalSavedView(entry: s.entry, onDone: () => context.router.maybePop()),
          );
        }
        return PopScope(
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) cubit.saveDraft();
          },
          child: Scaffold(
            backgroundColor: c.paper,
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(12, MediaQuery.paddingOf(context).top + 6, 16, 6),
                  child: Row(
                    children: [
                      MnIconButton(
                        icon: MnIcons.chevDown,
                        tooltip: 'Close',
                        onPressed: () => context.router.maybePop(),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(width: 6, height: 6, decoration: BoxDecoration(color: c.green, shape: BoxShape.circle)),
                            const SizedBox(width: 5),
                            Text('Draft autosaved', style: context.text.cap.copyWith(color: c.ink3)),
                          ],
                        ),
                      ),
                      MnButton(
                        label: 'Save',
                        size: MnButtonSize.small,
                        expand: false,
                        loading: s.saving,
                        onPressed: s.entry.body.trim().isEmpty ? null : cubit.save,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 720),
                      child: JournalEditor(prompt: prompt),
                    ),
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
