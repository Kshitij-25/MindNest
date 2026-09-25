import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../shell/presentation/shell_tabs.dart';
import '../bloc/earnings_cubit.dart';
import '../widgets/practice_widgets.dart';

@RoutePage()
class ProEarningsPage extends StatelessWidget {
  const ProEarningsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EarningsCubit>()..load(),
      child: BlocBuilder<EarningsCubit, EarningsState>(
        builder: (context, s) {
          final c = context.colors;
          final e = s.data;
          final tablet = context.isTablet;
          if (e == null) return const Scaffold(body: LoadingView());
          const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

          final balance = MnCard(
            radius: 22,
            padding: const EdgeInsets.all(26),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [MnColors.moss700, c.isDark ? MnColors.moss600 : c.primary],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AVAILABLE TO WITHDRAW',
                    style: TextStyle(color: Colors.white.withValues(alpha: .8), fontWeight: FontWeight.w700, fontSize: 13, letterSpacing: .5)),
                const SizedBox(height: 6),
                Text(money(e.available), style: const TextStyle(color: Colors.white, fontSize: 46, fontWeight: FontWeight.w800, height: 1)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    MnIcon(MnIcons.info, size: 15, color: Colors.white.withValues(alpha: .85)),
                    const SizedBox(width: 8),
                    Text('Next automatic payout in ${e.nextPayoutDays} days',
                        style: TextStyle(color: Colors.white.withValues(alpha: .85), fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 18),
                Pressable(
                  onTap: () async {
                    final ok = await Adaptive.confirm(
                      context,
                      title: 'Withdraw ${money(e.available)}?',
                      message: 'Funds usually arrive in 1–2 business days.',
                      confirmLabel: 'Withdraw',
                    );
                    if (ok && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Withdrawal requested')));
                    }
                  },
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(MnRadii.xs)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const MnIcon(MnIcons.arrowR, size: 17, color: MnColors.moss700, stroke: 2.2),
                        const SizedBox(width: 8),
                        const Text('Withdraw funds', style: TextStyle(color: MnColors.moss700, fontWeight: FontWeight.w600, fontSize: 15)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );

          final summary = MnCard(
            radius: 22,
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconTile(size: 42, radius: 11, child: MnIcon(MnIcons.trend, size: 20, color: c.primary)),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(money(e.yearTotal), style: context.text.title2),
                        Text('Total earned in ${DateTime.now().year}', style: context.text.cap.copyWith(color: c.ink3)),
                      ],
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Hairline()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (final (v, k) in [('${e.sessions}', 'Sessions'), (money(e.averageRate), 'Avg. rate'), (money(e.thisWeek), 'This week')])
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(v, style: context.text.title3), Text(k, style: context.text.cap.copyWith(color: c.ink3))],
                      ),
                  ],
                ),
              ],
            ),
          );

          final trend = MnCard(
            radius: 22,
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(child: Text('Income trend', style: context.text.title3)),
                    SizedBox(
                      width: tablet ? 220 : 180,
                      child: MnSegmented<EarningsPeriod>(
                        options: EarningsPeriod.values,
                        value: s.period,
                        labelOf: (p) => switch (p) {
                          EarningsPeriod.week => 'Week',
                          EarningsPeriod.month => 'Month',
                          EarningsPeriod.year => 'Year',
                        },
                        onChanged: context.read<EarningsCubit>().setPeriod,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                AnimatedSwitcher(
                  duration: MnMotion.base,
                  child: s.period == EarningsPeriod.week
                      ? MnBarChart(
                          key: const ValueKey('w'),
                          height: 190,
                          color: c.green,
                          valueLabel: money,
                          data: [for (final (i, v) in e.week.indexed) ChartBar(days[i], v.toDouble(), highlight: i == DateTime.now().weekday - 1)],
                        )
                      : MnLineChart(
                          key: ValueKey(s.period),
                          values: s.period == EarningsPeriod.month
                              ? e.months.map((m) => m.toDouble()).toList()
                              : const [14200, 15800, 16900, 18420],
                          height: 190,
                          color: c.green,
                          labels: s.period == EarningsPeriod.month
                              ? e.monthLabels
                              : [for (var y = 3; y >= 0; y--) '${DateTime.now().year - y}'],
                        ),
                ),
              ],
            ),
          );

          final tx = MnCard(
            radius: 22,
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Recent transactions', style: context.text.title3),
                const SizedBox(height: 8),
                for (final (i, t) in e.transactions.indexed) ...[
                  if (i > 0) const Hairline(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        MnAvatar(name: t.clientName, size: 40, photo: true),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(t.clientName, style: context.text.sub.copyWith(fontWeight: FontWeight.w700)),
                              Text('${t.description} · ${DateFormat('d MMM').format(t.date)}', style: context.text.cap.copyWith(color: c.ink3)),
                            ],
                          ),
                        ),
                        Text('+${money(t.amount)}', style: context.text.headline.copyWith(color: c.green)),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );

          final types = MnCard(
            radius: 22,
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('By session type', style: context.text.title3),
                const SizedBox(height: 16),
                for (final (i, entry) in e.byType.entries.indexed)
                  MetricBar(label: entry.key, percent: entry.value, color: [c.primary, c.topics[0], c.clay][i % 3]),
                const SizedBox(height: 8),
                MnCard(
                  style: MnCardStyle.inset,
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      MnIcon(MnIcons.info, size: 17, color: c.ink3),
                      const SizedBox(width: 10),
                      Expanded(child: Text('Payouts processed every Friday via Stripe.', style: context.text.cap.copyWith(color: c.ink2))),
                    ],
                  ),
                ),
              ],
            ),
          );

          return MnPage(
            header: isPushedPage(context) ? const MnNavHeader(title: 'Earnings') : null,
            maxWidth: 1180,
            padding: EdgeInsets.fromLTRB(context.gutter, tablet ? 28 : 8, context.gutter, 40),
            body: tablet
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      LargeTitle(title: 'Earnings & payouts'),
                      const SizedBox(height: 20),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [Expanded(flex: 7, child: balance), const SizedBox(width: 20), Expanded(flex: 5, child: summary)],
                        ),
                      ),
                      const SizedBox(height: 22),
                      trend,
                      const SizedBox(height: 22),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Expanded(flex: 7, child: tx), const SizedBox(width: 20), Expanded(flex: 5, child: types)],
                      ),
                    ],
                  )
                : Stagger(
                    spacing: 18,
                    children: [balance, summary, trend, tx, types],
                  ),
          );
        },
      ),
    );
  }
}
