import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../core/di/injection.dart';
import '../../settings/presentation/widgets/settings_widgets.dart';
import '../domain/safety.dart';

SafetyRepository get _repo => getIt<SafetyRepository>();

enum _SafetyChoice { report, block }

/// "More" menu for someone else's content: Report, and Block the author.
/// Resolves to true when the author was blocked, so callers can hide them.
Future<bool> showSafetyMenu(BuildContext context, ReportSubject subject, {String? reportLabel}) async {
  final choice = await Adaptive.actionSheet<_SafetyChoice>(
    context,
    actions: [
      AdaptiveAction(label: reportLabel ?? 'Report', value: _SafetyChoice.report, icon: Icons.flag_outlined),
      AdaptiveAction(label: 'Block ${subject.ownerName}', value: _SafetyChoice.block, icon: Icons.block, destructive: true),
    ],
  );
  if (!context.mounted || choice == null) return false;
  if (choice == _SafetyChoice.block) return blockUser(context, subject.ownerId, subject.ownerName);
  await reportContent(context, subject);
  return false;
}

/// Confirms, then blocks [userId]. Returns true when blocked.
Future<bool> blockUser(BuildContext context, String userId, String name) async {
  final ok = await Adaptive.confirm(
    context,
    title: 'Block $name?',
    message: 'You won’t see their posts or comments, and they can’t message you or book sessions with you. '
        'They aren’t told. You can unblock them in Settings.',
    confirmLabel: 'Block',
    destructive: true,
  );
  if (!ok || !context.mounted) return false;
  final messenger = ScaffoldMessenger.of(context);
  final r = await _repo.block(userId, name);
  return r.fold(
    (f) {
      messenger.showSnackBar(SnackBar(content: Text(f.message)));
      return false;
    },
    (_) {
      messenger.showSnackBar(SnackBar(content: Text('$name blocked')));
      return true;
    },
  );
}

/// Opens the report form for [subject].
Future<void> reportContent(BuildContext context, ReportSubject subject) => showMnSheet<void>(
      context,
      builder: (_) => _ReportSheet(subject: subject),
    );

class _ReportSheet extends StatefulWidget {
  const _ReportSheet({required this.subject});
  final ReportSubject subject;

  @override
  State<_ReportSheet> createState() => _ReportSheetState();
}

class _ReportSheetState extends State<_ReportSheet> {
  ReportReason? _reason;
  final _details = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _details.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _sending = true);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final r = await _repo.report(widget.subject, _reason!, _details.text);
    if (!mounted) return;
    setState(() => _sending = false);
    r.fold(
      (f) => messenger.showSnackBar(SnackBar(content: Text(f.message))),
      (_) {
        navigator.pop();
        messenger.showSnackBar(const SnackBar(content: Text('Thanks. Our team will review this within 24 hours.')));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final what = switch (widget.subject.type) {
      ReportTarget.post => 'article',
      ReportTarget.comment => 'comment',
      ReportTarget.message => 'message',
      ReportTarget.user => 'profile',
    };
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(22, 8, 22, 18 + MediaQuery.viewInsetsOf(context).bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Report $what', style: context.text.title3),
            const SizedBox(height: 4),
            Text('Reports are confidential. ${widget.subject.ownerName} won’t know it was you.',
                style: context.text.foot.copyWith(color: c.ink3)),
            const SizedBox(height: 12),
            for (final r in ReportReason.values)
              Pressable(
                onTap: () => setState(() => _reason = r),
                semanticLabel: r.label,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  child: Row(
                    children: [
                      IgnorePointer(child: MnCheckbox(value: _reason == r, round: true, size: 22, onChanged: (_) {})),
                      const SizedBox(width: 12),
                      Expanded(child: Text(r.label, style: context.text.callout)),
                    ],
                  ),
                ),
              ),
            if (_reason == ReportReason.selfHarm) ...[
              const SizedBox(height: 6),
              MnCard(
                color: c.clayTint,
                padding: const EdgeInsets.all(12),
                onTap: () => showCrisisSheet(context),
                child: Text('If someone is in immediate danger, call 112. Tap for 24/7 helplines.',
                    style: context.text.cap.copyWith(color: c.ink, fontWeight: FontWeight.w600)),
              ),
            ],
            const SizedBox(height: 10),
            MnTextField(controller: _details, hint: 'Add details (optional)', maxLines: 3, minLines: 2),
            const SizedBox(height: 16),
            MnButton(label: 'Send report', loading: _sending, onPressed: _reason == null || _sending ? null : _submit),
          ],
        ),
      ),
    );
  }
}
