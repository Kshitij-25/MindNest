import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';
import '../../domain/entities/practice_entities.dart';

final _money = NumberFormat.currency(locale: 'en_GB', symbol: '£', decimalDigits: 0);
String money(num v) => _money.format(v);

String whenLabel(DateTime d) {
  final now = DateTime.now();
  final diff = DateTime(d.year, d.month, d.day).difference(DateTime(now.year, now.month, now.day)).inDays;
  final day = switch (diff) { 0 => 'Today', 1 => 'Tomorrow', _ => DateFormat('EEE d MMM').format(d) };
  return '$day · ${DateFormat.jm().format(d)}';
}

Color clientStatusColor(MnColors c, ClientStatus s) => switch (s) {
      ClientStatus.stable => c.primary,
      ClientStatus.improving => c.green,
      ClientStatus.monitor => c.amber,
      ClientStatus.newClient => c.topics[0],
    };

Color sessionTypeColor(MnColors c, String type) => switch (type) {
      'Chat' => c.topics[0],
      'Intro' => c.clay,
      _ => c.primary,
    };

/// Time · divider · avatar · name row used on the dashboard.
class ScheduleRow extends StatelessWidget {
  const ScheduleRow({super.key, required this.session, this.onTap, this.trailing});
  final ScheduledSession session;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final s = session;
    final now = DateTime.now();
    final today = s.startsAt.day == now.day && s.startsAt.month == now.month;
    return MnCard(
      style: MnCardStyle.flat,
      onTap: onTap,
      padding: const EdgeInsets.all(14),
      child: IntrinsicHeight(
        child: Row(
          children: [
            SizedBox(
              width: 56,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(DateFormat('h:mm').format(s.startsAt), style: context.text.headline.copyWith(color: c.primary)),
                  Text(today ? DateFormat('a').format(s.startsAt) : DateFormat.E().format(s.startsAt),
                      style: context.text.cap.copyWith(color: c.ink3)),
                ],
              ),
            ),
            Container(width: 1, margin: const EdgeInsets.symmetric(horizontal: 12), color: c.hairline),
            MnAvatar(name: s.clientName, size: 42, photo: true),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.clientName, style: context.text.headline, maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text('${s.type} · ${s.minutes} min', style: context.text.foot.copyWith(color: c.ink2)),
                ],
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    );
  }
}

/// Coloured banner "N booking requests".
class RequestsBanner extends StatelessWidget {
  const RequestsBanner({super.key, required this.count, required this.onTap, this.subtitle = 'Review and respond'});
  final int count;
  final VoidCallback onTap;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return MnCard(
      color: c.primary,
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconTile(size: 42, radius: 12, color: Colors.white.withValues(alpha: .2), child: const MnIcon(MnIcons.bell, size: 20, color: Colors.white)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  count == 0 ? 'No pending requests' : '$count booking request${count == 1 ? '' : 's'}',
                  style: context.text.headline.copyWith(color: c.onPrimary),
                ),
                Text(subtitle, style: context.text.foot.copyWith(color: c.onPrimary.withValues(alpha: .85))),
              ],
            ),
          ),
          MnIcon(MnIcons.chevR, size: 20, color: c.onPrimary),
        ],
      ),
    );
  }
}

/// Labelled progress row (session metrics / by type).
class MetricBar extends StatelessWidget {
  const MetricBar({super.key, required this.label, required this.percent, required this.color});
  final String label;
  final int percent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: Text(label, style: context.text.sub.copyWith(color: c.ink2, fontWeight: FontWeight.w600))),
              Text('$percent%', style: context.text.sub.copyWith(fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 6),
          MnProgressBar(value: percent / 100, height: 7, color: color),
        ],
      ),
    );
  }
}
