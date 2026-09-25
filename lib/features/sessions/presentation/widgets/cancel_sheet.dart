import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/appointment.dart';

enum CancelChoice { cancel, reschedule }

/// Cancellation handling with reschedule suggestion and fee policy.
Future<CancelChoice?> showCancelSheet(BuildContext context, Appointment a) =>
    showMnSheet<CancelChoice>(context, builder: (_) => _CancelSheet(appointment: a));

class _CancelSheet extends StatelessWidget {
  const _CancelSheet({required this.appointment});
  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final free = appointment.freeCancellation;
    return Padding(
      padding: const EdgeInsets.fromLTRB(26, 8, 26, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(color: c.red.withValues(alpha: .14), shape: BoxShape.circle),
              alignment: Alignment.center,
              child: MnIcon(MnIcons.info, size: 30, color: c.red),
            ),
          ),
          const SizedBox(height: 18),
          Text('Cancel this session?', style: context.text.title2),
          const SizedBox(height: 8),
          Text.rich(
            TextSpan(
              children: free
                  ? [
                      const TextSpan(text: 'You’re cancelling more than 24 hours ahead, so there’s '),
                      TextSpan(text: 'no charge', style: TextStyle(color: c.ink, fontWeight: FontWeight.w700)),
                      const TextSpan(text: '. Would you like to reschedule instead?'),
                    ]
                  : [
                      const TextSpan(text: 'This session is within 24 hours, so '),
                      TextSpan(text: '50% of the fee', style: TextStyle(color: c.ink, fontWeight: FontWeight.w700)),
                      const TextSpan(text: ' applies. Rescheduling may be possible instead.'),
                    ],
            ),
            style: context.text.body.copyWith(color: c.ink2),
          ),
          const SizedBox(height: 18),
          MnCard(
            style: MnCardStyle.inset,
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                MnIcon(MnIcons.info, size: 17, color: c.ink3),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Cancellations within 24 hours are charged 50% of the session fee.',
                    style: context.text.cap.copyWith(color: c.ink2, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          MnButton(
            label: 'Reschedule instead',
            size: MnButtonSize.small,
            onPressed: () => Navigator.pop(context, CancelChoice.reschedule),
          ),
          const SizedBox(height: 10),
          MnButton(
            label: 'Cancel session',
            variant: MnButtonVariant.danger,
            size: MnButtonSize.small,
            onPressed: () => Navigator.pop(context, CancelChoice.cancel),
          ),
          const SizedBox(height: 10),
          MnButton.ghost(label: 'Keep it', size: MnButtonSize.small, onPressed: () => Navigator.pop(context)),
        ],
      ),
    );
  }
}
