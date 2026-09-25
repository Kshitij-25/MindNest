import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../cubit/forgot_password_cubit.dart';
import '../cubit/form_status.dart';
import '../widgets/auth_widgets.dart';

@RoutePage()
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocProvider(
      create: (_) => getIt<ForgotPasswordCubit>(),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listenWhen: (a, b) => a.status != b.status,
        listener: (context, s) {
          if (s.status == FormStatus.failure && s.error != null) {
            showError(context, s.error!);
          }
        },
        builder: (context, s) {
          final cubit = context.read<ForgotPasswordCubit>();
          final sent = s.status == FormStatus.success;
          return MnPage(
            maxWidth: 480,
            header: const MnNavHeader(),
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
            body: AnimatedSwitcher(
              duration: MnMotion.slow,
              child: !sent
                  ? FadeUp(
                      key: const ValueKey('form'),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: AuthIconHeader(icon: MnIcons.lock),
                          ),
                          const SizedBox(height: 22),
                          Text('Forgot password?', style: context.text.title1),
                          const SizedBox(height: 8),
                          Text(
                            'Enter your email and we’ll send a secure link to reset it.',
                            style: context.text.body.copyWith(color: c.ink2),
                          ),
                          const SizedBox(height: 28),
                          MnTextField(
                            icon: MnIcons.mail,
                            hint: 'Email address',
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            onChanged: cubit.emailChanged,
                            initialValue: s.email,
                          ),
                          const SizedBox(height: 18),
                          MnButton(
                            label: 'Send reset link',
                            loading: s.status == FormStatus.submitting,
                            onPressed: s.email.contains('@')
                                ? cubit.submit
                                : null,
                          ),
                        ],
                      ),
                    )
                  : PopIn(
                      key: const ValueKey('sent'),
                      spring: false,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          children: [
                            PopIn(
                              child: Container(
                                width: 84,
                                height: 84,
                                decoration: BoxDecoration(
                                  color: c.primaryTint,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: MnIcon(
                                  MnIcons.mail,
                                  size: 40,
                                  color: c.primary,
                                  stroke: 1.7,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Check your inbox',
                              style: context.text.title2,
                            ),
                            const SizedBox(height: 10),
                            Text.rich(
                              TextSpan(
                                text: 'We’ve sent a reset link to ',
                                children: [
                                  TextSpan(
                                    text: s.email,
                                    style: TextStyle(
                                      color: c.ink,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '. It expires in 30 minutes.',
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                              style: context.text.body.copyWith(color: c.ink2),
                            ),
                            const SizedBox(height: 30),
                            MnButton(
                              label: 'Back to sign in',
                              onPressed: () => context.router.maybePop(),
                            ),
                            const SizedBox(height: 18),
                            MnLinkButton(
                              label: 'Use a different email',
                              onPressed: cubit.reset,
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
