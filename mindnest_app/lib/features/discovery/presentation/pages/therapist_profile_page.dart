import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';
import 'package:mindnest_app/shared/models/view_status.dart';
import 'package:mindnest_app/shared/widgets/app_error_view.dart';
import 'package:mindnest_app/shared/widgets/app_loader.dart';

import '../../domain/entities/therapist.dart';
import '../cubit/therapist_profile_cubit.dart';

class TherapistProfilePage extends StatelessWidget {
  const TherapistProfilePage({super.key, required this.therapistId});
  final String therapistId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TherapistProfileCubit>()..load(therapistId),
      child: BlocBuilder<TherapistProfileCubit, TherapistProfileState>(
        builder: (context, state) {
          if (state.status == ViewStatus.error) {
            return MnScaffold(
              child: Column(
                children: [
                  SizedBox(height: safeTop(context)),
                  NavHeader(onBack: () => context.pop()),
                  Expanded(
                    child: AppErrorView(
                      failure: state.failure!,
                      onRetry: () => context.read<TherapistProfileCubit>().load(
                        therapistId,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state.therapist == null) {
            return const MnScaffold(child: AppLoader());
          }
          return _ProfileView(
            therapist: state.therapist!,
            reviews: state.reviews,
          );
        },
      ),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView({required this.therapist, required this.reviews});
  final Therapist therapist;
  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final t = therapist;
    return MnScaffold(
      child: Column(
        children: [
          Expanded(
            child: NoGlow(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: 260,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        PhotoPlaceholder(t.name, label: 'therapist portrait'),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color(0x4014180F),
                                Colors.transparent,
                                Colors.transparent,
                                c.bg,
                              ],
                              stops: const [0, 0.3, 0.55, 1],
                            ),
                          ),
                        ),
                        Positioned(
                          top: safeTop(context),
                          left: 16,
                          right: 16,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NavBtn(
                                icon: 'back',
                                background: const Color(0xD9FFFFFF),
                                color: const Color(0xFF1F2519),
                                onTap: () => context.pop(),
                              ),
                              const NavBtn(
                                icon: 'bookmark',
                                iconSize: 20,
                                stroke: 1.9,
                                background: Color(0xD9FFFFFF),
                                color: Color(0xFF1F2519),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -8),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(22, 0, 22, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  t.name,
                                  style: MnText.title1.copyWith(color: c.ink),
                                ),
                              ),
                              if (t.verified) ...[
                                const SizedBox(width: 8),
                                const Verified(size: 20),
                              ],
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            t.title,
                            style: MnText.body.copyWith(color: c.ink2),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              MnIcon('location', size: 15, color: c.ink3),
                              const SizedBox(width: 8),
                              Text(
                                t.location,
                                style: MnText.callout.copyWith(color: c.ink2),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          MnCard(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              children: [
                                _stat(
                                  c,
                                  t.rating.toStringAsFixed(1),
                                  'Rating',
                                  false,
                                ),
                                _stat(c, '${t.reviews}+', 'Reviews', true),
                                _stat(c, '${t.years} yrs', 'Experience', true),
                              ],
                            ),
                          ),
                          _section(
                            c,
                            'About',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t.about,
                                  style: MnText.body.copyWith(
                                    color: c.ink2,
                                    height: 1.55,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    for (final tag in t.tags)
                                      Chip2(tag, outline: true),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          _section(
                            c,
                            'Qualifications',
                            child: Column(
                              children: [
                                for (final q in t.quals)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 36,
                                          height: 36,
                                          decoration: BoxDecoration(
                                            color: c.primaryTint,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: MnIcon(
                                            'award',
                                            size: 18,
                                            color: c.primary,
                                            stroke: 1.9,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            q,
                                            style: MnText.callout.copyWith(
                                              color: c.ink2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          _section(
                            c,
                            'Languages',
                            child: Wrap(
                              spacing: 8,
                              children: [
                                for (final l in t.langs)
                                  Chip2(
                                    l,
                                    outline: true,
                                    leading: MnIcon(
                                      'globe',
                                      size: 15,
                                      color: c.ink3,
                                      stroke: 1.9,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          _section(
                            c,
                            'Availability',
                            child: Row(
                              children: [
                                for (var i = 0; i < 5; i++) ...[
                                  if (i > 0) const SizedBox(width: 8),
                                  Expanded(
                                    child: _avail(
                                      c,
                                      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'][i],
                                      i,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          _section(
                            c,
                            'Reviews',
                            action: '${t.reviews} total',
                            child: Column(
                              children: [
                                for (final r in reviews)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 14),
                                    child: _review(c, r),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(22, 12, 22, safeBottom(context) + 16),
            decoration: BoxDecoration(
              color: c.bg.withValues(alpha: 0.92),
              border: Border(top: BorderSide(color: c.hairline, width: 0.5)),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '£${t.price}',
                      style: MnText.title3.copyWith(color: c.ink, height: 1),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'per session',
                      style: MnText.cap.copyWith(color: c.ink3),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MnButton(
                    label: 'Book appointment',
                    onPressed: () => context.pushNamed(
                      RouteNames.booking,
                      pathParameters: {'id': t.id},
                      extra: t,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(MnColors c, String v, String k, bool border) => Expanded(
    child: Container(
      decoration: border
          ? BoxDecoration(
              border: Border(left: BorderSide(color: c.hairline)),
            )
          : null,
      child: Column(
        children: [
          Text(v, style: MnText.title3.copyWith(color: c.ink)),
          const SizedBox(height: 2),
          Text(k, style: MnText.foot.copyWith(color: c.ink3)),
        ],
      ),
    ),
  );

  Widget _avail(MnColors c, String d, int i) {
    final open = i % 3 != 0;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: open ? c.primaryTint : c.fill,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(d, style: MnText.cap.copyWith(color: c.ink3)),
          const SizedBox(height: 4),
          Text(
            open ? '${2 + i} slots' : '—',
            style: MnText.foot.copyWith(
              color: open ? c.primary : c.ink4,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _review(MnColors c, Review r) => MnCard(
    kind: MnCardKind.flat,
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Avatar(r.name, size: 36),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    r.name,
                    style: MnText.foot.copyWith(
                      color: c.ink,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(r.time, style: MnText.cap.copyWith(color: c.ink3)),
                ],
              ),
            ),
            Row(
              children: [
                for (var i = 0; i < 5; i++)
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: MnIcon(
                      'star',
                      size: 12,
                      color: i < r.rating ? c.moss500 : c.fill2,
                      fill: i < r.rating ? c.moss500 : c.fill2,
                      stroke: 0,
                    ),
                  ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          r.text,
          style: MnText.callout.copyWith(color: c.ink2, height: 1.5),
        ),
      ],
    ),
  );

  Widget _section(
    MnColors c,
    String title, {
    String? action,
    required Widget child,
  }) => Padding(
    padding: const EdgeInsets.only(top: 26),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                child: Text(title, style: MnText.title3.copyWith(color: c.ink)),
              ),
              if (action != null)
                Text(action, style: MnText.foot.copyWith(color: c.ink3)),
            ],
          ),
        ),
        child,
      ],
    ),
  );
}
