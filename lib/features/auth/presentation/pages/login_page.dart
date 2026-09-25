import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../domain/entities/user_role.dart';
import '../bloc/auth_bloc.dart';
import '../cubit/form_status.dart';
import '../cubit/sign_in_cubit.dart';
import '../widgets/auth_widgets.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key, this.role = UserRole.client});

  final UserRole role;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SignInCubit>(),
      child: BlocListener<SignInCubit, SignInState>(
        listenWhen: (a, b) => a.status != b.status,
        listener: (context, s) {
          if (s.status == FormStatus.failure && s.error != null) {
            showError(context, s.error!);
          }
          if (s.status == FormStatus.success && s.user != null) {
            context.read<AuthBloc>().add(AuthEvent.userChanged(s.user!));
            context.router.replaceAll([homeRouteFor(s.user!)]);
          }
        },
        child: _LoginView(role: role),
      ),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView({required this.role});
  final UserRole role;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final cubit = context.read<SignInCubit>();
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, s) {
        final busy = s.status == FormStatus.submitting;
        return MnPage(
          maxWidth: 480,
          header: const MnNavHeader(),
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
          body: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FadeUp(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MnLogo(size: 46),
                      const SizedBox(height: 20),
                      Text('Welcome back', style: context.text.title1),
                      const SizedBox(height: 6),
                      Text(
                        'Sign in to continue your journey.',
                        style: context.text.body.copyWith(color: c.ink2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Stagger(
                  spacing: 14,
                  children: [
                    MnTextField(
                      icon: MnIcons.mail,
                      hint: 'Email address',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                      onChanged: cubit.emailChanged,
                    ),
                    MnTextField(
                      icon: MnIcons.lock,
                      hint: 'Password',
                      obscure: s.obscure,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.password],
                      onChanged: cubit.passwordChanged,
                      onSubmitted: (_) => cubit.submit(role),
                      trailing: MnIconButton(
                        icon: s.obscure ? MnIcons.eye : MnIcons.eyeOff,
                        tooltip: s.obscure ? 'Show password' : 'Hide password',
                        background: Colors.transparent,
                        color: c.ink3,
                        iconSize: 20,
                        onPressed: cubit.toggleObscure,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: MnLinkButton(
                        label: 'Forgot password?',
                        onPressed: () =>
                            context.router.push(const ForgotPasswordRoute()),
                      ),
                    ),
                    MnButton(
                      label: 'Sign in',
                      loading: busy,
                      onPressed: () => cubit.submit(role),
                    ),
                  ],
                ),
                const OrDivider(),
                MnButton.outline(
                  label: 'Continue with Apple',
                  leading: const AppleGlyph(),
                  onPressed: busy ? null : () => cubit.social('apple', role),
                ),
                const SizedBox(height: 12),
                MnButton.outline(
                  label: 'Continue with Google',
                  leading: const GoogleGlyph(),
                  onPressed: busy ? null : () => cubit.social('google', role),
                ),
                const SizedBox(height: 26),
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      'New to MindNest? ',
                      style: context.text.callout.copyWith(color: c.ink2),
                    ),
                    MnLinkButton(
                      label: 'Create account',
                      onPressed: () =>
                          context.router.push(SignupRoute(role: role)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
