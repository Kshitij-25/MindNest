import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/usecases/sessions_usecases.dart';

/// Rate a completed session. Resolves to true when the review was posted.
Future<bool> showReviewSheet(BuildContext context, Appointment a) async =>
    await showMnSheet<bool>(context, builder: (_) => _ReviewSheet(appointment: a)) ?? false;

class _ReviewSheet extends StatefulWidget {
  const _ReviewSheet({required this.appointment});
  final Appointment appointment;

  @override
  State<_ReviewSheet> createState() => _ReviewSheetState();
}

class _ReviewSheetState extends State<_ReviewSheet> {
  int _rating = 0;
  final _text = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _sending = true);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final r = await getIt<ReviewSession>()(ReviewParams(widget.appointment.id, rating: _rating, text: _text.text));
    if (!mounted) return;
    setState(() => _sending = false);
    r.fold(
      (f) => messenger.showSnackBar(SnackBar(content: Text(f.message))),
      (_) {
        navigator.pop(true);
        messenger.showSnackBar(const SnackBar(content: Text('Thanks for your review')));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = widget.appointment.therapist;
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(22, 8, 22, 18 + MediaQuery.viewInsetsOf(context).bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('How was your session with ${t.firstName}?', style: context.text.title3),
            const SizedBox(height: 4),
            Text('Your review is public and shows your first name only.', style: context.text.foot.copyWith(color: c.ink3)),
            const SizedBox(height: 18),
            Center(
              child: Semantics(
                label: 'Rating, $_rating of 5 stars',
                child: MnStars(value: _rating, size: 36, onChanged: (v) => setState(() => _rating = v)),
              ),
            ),
            const SizedBox(height: 18),
            MnTextField(controller: _text, hint: 'What helped? (optional)', maxLines: 4, minLines: 3),
            const SizedBox(height: 16),
            MnButton(label: 'Post review', loading: _sending, onPressed: _rating == 0 || _sending ? null : _submit),
          ],
        ),
      ),
    );
  }
}
