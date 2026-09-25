import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/practice_entities.dart';
import 'practice_widgets.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({
    super.key,
    required this.request,
    required this.onRespond,
    this.onOpen,
    this.compact = false,
  });

  final SessionRequest request;
  final void Function(RequestStatus status) onRespond;
  final VoidCallback? onOpen;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final r = request;
    final pending = r.status == RequestStatus.pending;
    return MnCard(
      style: compact ? MnCardStyle.flat : MnCardStyle.raised,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Pressable(
            onTap: onOpen,
            semanticLabel: 'Request from ${r.clientName}',
            child: Row(
              children: [
                MnAvatar(name: r.clientName, size: compact ? 44 : 50, photo: true),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(r.clientName, style: compact ? context.text.sub.copyWith(fontWeight: FontWeight.w700) : context.text.headline),
                      const SizedBox(height: 2),
                      Text(r.reason, style: context.text.foot.copyWith(color: c.ink2)),
                    ],
                  ),
                ),
                if (!pending) MnBadge.status(r.status.label),
              ],
            ),
          ),
          const SizedBox(height: 14),
          MnCard(
            style: MnCardStyle.inset,
            radius: 14,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                MnIcon(MnIcons.calendar, size: 17, color: c.primary),
                const SizedBox(width: 8),
                Flexible(child: Text(whenLabel(r.requestedAt), style: context.text.foot.copyWith(fontWeight: FontWeight.w600))),
                Container(
                  width: 3,
                  height: 3,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(color: c.ink4, shape: BoxShape.circle),
                ),
                Text('${r.minutes} min', style: context.text.foot.copyWith(color: c.ink2)),
              ],
            ),
          ),
          const SizedBox(height: 14),
          AnimatedSwitcher(
            duration: MnMotion.base,
            child: pending
                ? Row(
                    key: const ValueKey('actions'),
                    children: [
                      Expanded(
                        flex: 10,
                        child: MnButton(
                          label: 'Decline',
                          variant: MnButtonVariant.danger,
                          size: MnButtonSize.small,
                          onPressed: () => onRespond(RequestStatus.declined),
                        ),
                      ),
                      if (!compact) ...[
                        const SizedBox(width: 10),
                        Expanded(flex: 10, child: MnButton.outline(label: 'Reschedule', size: MnButtonSize.small, onPressed: onOpen)),
                      ],
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 14,
                        child: MnButton(label: 'Accept', size: MnButtonSize.small, onPressed: () => onRespond(RequestStatus.accepted)),
                      ),
                    ],
                  )
                : Padding(
                    key: const ValueKey('done'),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      r.status == RequestStatus.accepted ? '✓ Session confirmed — added to your calendar' : 'Request declined',
                      textAlign: TextAlign.center,
                      style: context.text.foot.copyWith(color: r.status == RequestStatus.accepted ? c.green : c.ink3),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
