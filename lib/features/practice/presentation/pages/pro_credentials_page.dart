import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../domain/entities/practice_entities.dart';
import '../bloc/verification_cubit.dart';

@RoutePage()
class ProCredentialsPage extends StatelessWidget {
  const ProCredentialsPage({super.key});

  MnIconData _icon(DocumentKind k) => switch (k) {
        DocumentKind.licence => MnIcons.doc,
        DocumentKind.photoId => MnIcons.user,
        DocumentKind.qualifications => MnIcons.award,
      };

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocProvider(
      create: (_) => getIt<VerificationCubit>()..load(),
      child: BlocConsumer<VerificationCubit, VerificationState>(
        listenWhen: (a, b) => a.submitted != b.submitted || a.error != b.error,
        listener: (context, s) {
          if (s.submitted) {
            context.read<AuthBloc>().add(const AuthEvent.credentialsSubmitted());
            context.router.replaceAll([const ProVerifyRoute()]);
          } else if (s.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s.error!)));
          }
        },
        builder: (context, s) {
          final cubit = context.read<VerificationCubit>();
          final total = s.documents.isEmpty ? 3 : s.documents.length;
          return MnPage(
            maxWidth: 560,
            header: const MnNavHeader(title: 'Verify credentials'),
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 30),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FadeUp(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconTile(size: 56, radius: 16, child: MnIcon(MnIcons.shield, size: 28, color: c.primary, stroke: 1.9)),
                      const SizedBox(height: 16),
                      Text('Let’s verify you', style: context.text.title2),
                      const SizedBox(height: 8),
                      Text(
                        'Upload your documents so clients can trust they’re in safe, qualified hands.',
                        style: context.text.body.copyWith(color: c.ink2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                MnProgressBar(value: s.uploadedCount / total),
                const SizedBox(height: 8),
                Text('${s.uploadedCount} of $total uploaded', style: context.text.foot.copyWith(color: c.ink3, fontWeight: FontWeight.w600)),
                const SizedBox(height: 20),
                Stagger(
                  spacing: 12,
                  children: [
                    for (final d in s.documents)
                      _DocTile(
                        doc: d,
                        icon: _icon(d.kind),
                        busy: s.uploading == d.kind,
                        onTap: () => cubit.toggle(d),
                      ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    MnIcon(MnIcons.lock, size: 15, color: c.ink3),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text('Encrypted & only seen by our verification team.', style: context.text.foot.copyWith(color: c.ink3)),
                    ),
                  ],
                ),
              ],
            ),
            bottom: MnButton(label: 'Submit for review', loading: s.submitting, onPressed: s.complete ? cubit.submit : null),
          );
        },
      ),
    );
  }
}

class _DocTile extends StatelessWidget {
  const _DocTile({required this.doc, required this.icon, required this.busy, required this.onTap});
  final VerificationDocument doc;
  final MnIconData icon;
  final bool busy;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final up = doc.uploaded;
    return Semantics(
      button: true,
      label: '${doc.title}. ${up ? 'Uploaded, tap to remove' : 'Not uploaded, tap to upload'}',
      excludeSemantics: true,
      child: Pressable(
        onTap: busy ? null : onTap,
        child: AnimatedContainer(
          duration: MnMotion.base,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: up ? c.primaryTint : c.surface,
            borderRadius: BorderRadius.circular(MnRadii.md),
            border: Border.all(color: up ? c.primary : c.hairline2, width: 1.5),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: MnMotion.base,
                width: 44,
                height: 44,
                decoration: BoxDecoration(color: up ? c.primary : c.fill, borderRadius: BorderRadius.circular(12)),
                alignment: Alignment.center,
                child: busy
                    ? AdaptiveLoader(size: 20, color: up ? c.onPrimary : c.primary)
                    : MnIcon(up ? MnIcons.check : icon, size: 22, color: up ? c.onPrimary : c.ink3, stroke: up ? 3 : 1.9),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doc.title, style: context.text.headline),
                    const SizedBox(height: 2),
                    Text(up ? 'Uploaded · tap to remove' : doc.description, style: context.text.foot.copyWith(color: c.ink2)),
                  ],
                ),
              ),
              if (!up && !busy) MnIcon(MnIcons.upload, size: 20, color: c.primary),
            ],
          ),
        ),
      ),
    );
  }
}
