import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../domain/entities/user_role.dart';
import '../bloc/auth_bloc.dart';
import '../cubit/form_status.dart';
import '../cubit/otp_cubit.dart';
import '../widgets/auth_widgets.dart';

@RoutePage()
class OtpPage extends StatelessWidget {
  const OtpPage({super.key, this.role = UserRole.client});

  final UserRole role;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OtpCubit>(),
      child: BlocListener<OtpCubit, OtpState>(
        listenWhen: (a, b) => a.status != b.status,
        listener: (context, s) {
          if (s.status == FormStatus.failure && s.error != null) {
            showError(context, s.error!);
          }
          if (s.status == FormStatus.success) {
            Adaptive.success(context);
            context.router.replaceAll([
              role == UserRole.professional
                  ? const ProCredentialsRoute()
                  : const QuestionnaireRoute(),
            ]);
          }
        },
        child: const _OtpView(),
      ),
    );
  }
}

class _OtpView extends StatelessWidget {
  const _OtpView();

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final email = context.select((AuthBloc b) => b.state.user?.email ?? 'your inbox');
    return BlocBuilder<OtpCubit, OtpState>(
      builder: (context, s) {
        final cubit = context.read<OtpCubit>();
        return MnPage(
          maxWidth: 480,
          header: const MnNavHeader(),
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FadeUp(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AuthIconHeader(icon: MnIcons.message),
                    const SizedBox(height: 22),
                    Text('Verify your email', style: context.text.title1),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        text: 'We sent a confirmation link to ',
                        children: [
                          TextSpan(
                            text: email,
                            style: TextStyle(color: c.ink, fontWeight: FontWeight.w700),
                          ),
                          const TextSpan(text: '. Tap it, then come back here to continue.'),
                        ],
                      ),
                      style: context.text.body.copyWith(color: c.ink2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              MnButton(
                label: 'I’ve verified my email',
                loading: s.status == FormStatus.submitting,
                onPressed: cubit.verify,
              ),
              const SizedBox(height: 26),
              Center(
                child: s.secondsLeft > 0
                    ? Text(
                        'Resend email in 0:${s.secondsLeft.toString().padLeft(2, '0')}',
                        style: context.text.callout.copyWith(color: c.ink3),
                      )
                    : MnLinkButton(label: 'Resend email', onPressed: cubit.resend),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  'Can’t find it? Check your spam folder.',
                  style: context.text.foot.copyWith(color: c.ink3),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
