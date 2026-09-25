import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../domain/entities/user_role.dart';
import '../bloc/auth_bloc.dart';
import '../cubit/form_status.dart';
import '../cubit/sign_up_cubit.dart';
import '../widgets/auth_widgets.dart';

@RoutePage()
class SignupPage extends StatelessWidget {
  const SignupPage({super.key, this.role = UserRole.client});

  final UserRole role;

  @override
  Widget build(BuildContext context) {
    final pro = role == UserRole.professional;
    final c = context.colors;
    return BlocProvider(
      create: (_) => getIt<SignUpCubit>(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listenWhen: (a, b) => a.status != b.status,
        listener: (context, s) {
          if (s.status == FormStatus.failure && s.error != null) {
            showError(context, s.error!);
          }
          if (s.status == FormStatus.success && s.user != null) {
            context.read<AuthBloc>().add(AuthEvent.userChanged(s.user!));
            context.router.push(OtpRoute(role: role));
          }
        },
        builder: (context, s) {
          final cubit = context.read<SignUpCubit>();
          return MnPage(
            maxWidth: 480,
            header: MnNavHeader(
              title: pro ? 'Professional sign up' : 'Create account',
            ),
            padding: const EdgeInsets.fromLTRB(24, 6, 24, 40),
            body: AutofillGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FadeUp(
                    child: Text(
                      pro
                          ? 'Set up your practitioner account. You’ll verify your credentials next.'
                          : 'A few details and you’re ready to begin.',
                      style: context.text.body.copyWith(color: c.ink2),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Stagger(
                    spacing: 14,
                    children: [
                      MnTextField(
                        icon: MnIcons.user,
                        hint: pro ? 'Full professional name' : 'Full name',
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.name],
                        onChanged: cubit.nameChanged,
                      ),
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
                        hint: 'Create password',
                        obscure: true,
                        autofillHints: const [AutofillHints.newPassword],
                        onChanged: cubit.passwordChanged,
                      ),
                      PasswordStrength(password: s.password, score: s.strength),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: MnCheckbox(
                          value: s.agreed,
                          onChanged: (_) => cubit.toggleAgreed(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'I agree to MindNest’s Terms of Service and Privacy Policy.',
                          style: context.text.callout.copyWith(color: c.ink2),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  MnButton(
                    label: 'Continue',
                    loading: s.status == FormStatus.submitting,
                    onPressed: s.valid ? () => cubit.submit(role) : null,
                  ),
                  const SizedBox(height: 22),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: context.text.callout.copyWith(color: c.ink2),
                      ),
                      MnLinkButton(
                        label: 'Sign in',
                        onPressed: () => context.router.maybePop(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
