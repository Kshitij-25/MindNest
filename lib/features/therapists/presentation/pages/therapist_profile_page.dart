import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../domain/entities/therapist.dart';
import '../bloc/therapist_profile_cubit.dart';
import '../widgets/therapist_widgets.dart';

@RoutePage()
class TherapistProfilePage extends StatelessWidget {
  const TherapistProfilePage({super.key, @PathParam('id') required this.therapistId});

  final String therapistId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TherapistProfileCubit>()..load(therapistId),
      child: BlocBuilder<TherapistProfileCubit, TherapistProfileState>(
        builder: (context, s) {
          final t = s.therapist;
          if (t == null) {
            return Scaffold(
              body: Column(
                children: [
                  const MnNavHeader(),
                  Expanded(
                    child: s.status.isFailure
                        ? ErrorView(message: s.error ?? '', onRetry: () => context.read<TherapistProfileCubit>().load(therapistId))
                        : const LoadingView(),
                  ),
                ],
              ),
            );
          }
          return ResponsiveLayout(
            phone: (_) => _PhoneProfile(s: s, t: t),
            tablet: (_) => _TabletProfile(s: s, t: t),
          );
        },
      ),
    );
  }
}

void _book(BuildContext context, Therapist t) => context.router.push(BookingRoute(therapistId: t.id));

class _PhoneProfile extends StatelessWidget {
  const _PhoneProfile({required this.s, required this.t});
  final TherapistProfileState s;
  final Therapist t;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final top = MediaQuery.paddingOf(context).top;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: Adaptive.scrollPhysics(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 260 + top,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        PortraitPlaceholder(name: t.name),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [const Color(0x4014180F), Colors.transparent, Colors.transparent, c.bg],
                              stops: const [0, .3, .55, 1],
                            ),
                          ),
                        ),
                        Positioned(
                          top: top + 8,
                          left: 12,
                          right: 12,
                          child: _HeroActions(t: t),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 0, 22, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FadeUp(child: _Identity(t: t)),
                        const SizedBox(height: 20),
                        FadeUp(delay: const Duration(milliseconds: 60), child: _StatStrip(t: t)),
                        ..._sections(context, s, t),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _BookBar(t: t),
        ],
      ),
    );
  }
}

class _TabletProfile extends StatelessWidget {
  const _TabletProfile({required this.s, required this.t});
  final TherapistProfileState s;
  final Therapist t;

  @override
  Widget build(BuildContext context) {
    return MnPage(
      header: MnNavHeader(
        title: t.name,
        trailing: _SaveButton(t: t),
      ),
      maxWidth: 1080,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 340,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MnCard(
                  padding: EdgeInsets.zero,
                  clip: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 220, child: PortraitPlaceholder(name: t.name)),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _Identity(t: t),
                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('£${t.price}', style: context.text.title2),
                                Text('  per session', style: context.text.foot.copyWith(color: context.colors.ink3)),
                              ],
                            ),
                            const SizedBox(height: 14),
                            MnButton(label: 'Book appointment', onPressed: () => _book(context, t)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _StatStrip(t: t),
              ],
            ),
          ),
          const SizedBox(width: 28),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [..._sections(context, s, t)],
            ),
          ),
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.t, this.overlay = false});
  final Therapist t;
  final bool overlay;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return MnIconButton(
      icon: MnIcons.bookmark,
      tooltip: t.saved ? 'Remove from saved' : 'Save therapist',
      stroke: 1.9,
      iconSize: 20,
      background: overlay ? Colors.white.withValues(alpha: .85) : (t.saved ? c.primaryTint : c.fill),
      color: t.saved ? c.primary : (overlay ? const Color(0xFF1F2519) : c.ink),
      onPressed: () {
        Adaptive.tap(context);
        context.read<TherapistProfileCubit>().toggleSaved();
      },
    );
  }
}

class _HeroActions extends StatelessWidget {
  const _HeroActions({required this.t});
  final Therapist t;

  @override
  Widget build(BuildContext context) {
    Widget glass(Widget child) => ClipOval(
          child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8), child: child),
        );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        glass(MnIconButton(
          icon: MnIcons.back,
          tooltip: 'Back',
          background: Colors.white.withValues(alpha: .85),
          color: const Color(0xFF1F2519),
          onPressed: () => context.router.maybePop(),
        )),
        glass(_SaveButton(t: t, overlay: true)),
      ],
    );
  }
}

class _Identity extends StatelessWidget {
  const _Identity({required this.t});
  final Therapist t;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(child: Text(t.name, style: context.text.title1)),
            if (t.verified) ...[const SizedBox(width: 8), const VerifiedBadge(size: 20)],
          ],
        ),
        const SizedBox(height: 4),
        Text(t.title, style: context.text.body.copyWith(color: c.ink2)),
        const SizedBox(height: 8),
        Row(
          children: [
            MnIcon(MnIcons.location, size: 15, color: c.ink3),
            const SizedBox(width: 8),
            Text(t.location, style: context.text.callout.copyWith(color: c.ink2)),
          ],
        ),
      ],
    );
  }
}

class _StatStrip extends StatelessWidget {
  const _StatStrip({required this.t});
  final Therapist t;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final stats = [(t.rating.toStringAsFixed(1), 'Rating'), ('${t.reviewCount}+', 'Reviews'), ('${t.years} yrs', 'Experience')];
    return MnCard(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: IntrinsicHeight(
        child: Row(
          children: [
            for (final (i, st) in stats.indexed) ...[
              if (i > 0) Container(width: 1, color: c.hairline),
              Expanded(
                child: Column(
                  children: [
                    Text(st.$1, style: context.text.title3),
                    const SizedBox(height: 2),
                    Text(st.$2, style: context.text.foot.copyWith(color: c.ink3)),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

List<Widget> _sections(BuildContext context, TherapistProfileState s, Therapist t) {
  final c = context.colors;
  Widget section(String title, Widget child, {String? action}) => FadeUp(
        child: Padding(
          padding: const EdgeInsets.only(top: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(child: Semantics(header: true, child: Text(title, style: context.text.title3))),
                  if (action != null) Text(action, style: context.text.foot.copyWith(color: c.ink3)),
                ],
              ),
              const SizedBox(height: 14),
              child,
            ],
          ),
        ),
      );

  return [
    section(
      'About',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.about, style: context.text.body.copyWith(color: c.ink2, height: 1.55)),
          const SizedBox(height: 14),
          Wrap(spacing: 8, runSpacing: 8, children: [for (final tag in t.tags) OutlineTag(label: tag, height: 36)]),
        ],
      ),
    ),
    section(
      'Qualifications',
      Column(
        children: [
          for (final q in t.qualifications)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  IconTile(size: 36, radius: 10, child: MnIcon(MnIcons.award, size: 18, color: c.primary, stroke: 1.9)),
                  const SizedBox(width: 12),
                  Expanded(child: Text(q, style: context.text.callout.copyWith(color: c.ink2))),
                ],
              ),
            ),
        ],
      ),
    ),
    section(
      'Languages',
      Wrap(spacing: 8, runSpacing: 8, children: [for (final l in t.languages) OutlineTag(label: l, icon: MnIcons.globe, height: 36)]),
    ),
    section(
      'Availability',
      Row(
        children: [
          for (final (i, d) in s.availability.indexed) ...[
            if (i > 0) const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: d.slots > 0 ? c.primaryTint : c.fill,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(d.day, style: context.text.cap.copyWith(color: c.ink3)),
                    const SizedBox(height: 4),
                    Text(
                      d.slots > 0 ? '${d.slots} slots' : '—',
                      style: context.text.foot.copyWith(fontWeight: FontWeight.w700, color: d.slots > 0 ? c.primary : c.ink4),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    ),
    section(
      'Reviews',
      Column(
        children: [
          for (final r in s.reviews)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: MnCard(
                style: MnCardStyle.flat,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        MnAvatar(name: r.author, size: 36),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(r.author, style: context.text.foot.copyWith(fontWeight: FontWeight.w700)),
                              Text(r.timeAgo, style: context.text.cap.copyWith(color: c.ink3)),
                            ],
                          ),
                        ),
                        MnStars(value: r.rating, size: 12),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(r.text, style: context.text.callout.copyWith(color: c.ink2, height: 1.5)),
                  ],
                ),
              ),
            ),
        ],
      ),
      action: '${t.reviewCount} total',
    ),
  ];
}

class _BookBar extends StatelessWidget {
  const _BookBar({required this.t});
  final Therapist t;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: EdgeInsets.fromLTRB(22, 12, 22, MediaQuery.paddingOf(context).bottom + 16),
          decoration: BoxDecoration(
            color: c.bg.withValues(alpha: .85),
            border: Border(top: BorderSide(color: c.hairline, width: .5)),
          ),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('£${t.price}', style: context.text.title3.copyWith(height: 1)),
                  const SizedBox(height: 2),
                  Text('per session', style: context.text.cap.copyWith(color: c.ink3)),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(child: MnButton(label: 'Book appointment', onPressed: () => _book(context, t))),
            ],
          ),
        ),
      ),
    );
  }
}
