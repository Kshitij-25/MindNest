import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';
import 'package:mindnest_app/shared/models/user_role.dart';

import '../cubit/auth_cubit.dart';
import '../widgets/brand_glyph.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.role});
  final UserRole role;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<AuthCubit>(),
    child: _LoginView(role: role),
  );
}

class _LoginView extends StatefulWidget {
  const _LoginView({required this.role});
  final UserRole role;

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    final cubit = context.read<AuthCubit>();
    final ok = await cubit.signIn(
      widget.role,
      email: _email.text,
      password: _password.text,
    );
    if (ok && mounted) {
      context.goNamed(
        widget.role.isPro ? RouteNames.proShell : RouteNames.userShell,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final submitting = context.watch<AuthCubit>().state.submitting;
    return MnScaffold(
      child: Column(
        children: [
          SizedBox(height: safeTop(context)),
          NavHeader(onBack: () => context.pop()),
          Expanded(
            child: NoGlow(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 6, 24, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    const Logo(size: 46, breathe: false),
                    const SizedBox(height: 22),
                    Text(
                      'Welcome back',
                      style: MnText.title1.copyWith(color: c.ink),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign in to pick up where you left off.',
                      style: MnText.body.copyWith(color: c.ink2),
                    ),
                    const SizedBox(height: 26),
                    MnField(
                      icon: 'mail',
                      hint: 'Email',
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    MnField(
                      icon: 'lock',
                      hint: 'Password',
                      controller: _password,
                      obscure: _obscure,
                      trailing: NavBtn(
                        icon: _obscure ? 'eye' : 'eyeOff',
                        background: Colors.transparent,
                        color: c.ink3,
                        iconSize: 20,
                        stroke: 1.9,
                        onTap: () => setState(() => _obscure = !_obscure),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: LinkBtn(
                        'Forgot password?',
                        onTap: () => context.pushNamed(RouteNames.forgot),
                      ),
                    ),
                    const SizedBox(height: 20),
                    MnButton(
                      label: 'Sign in',
                      onPressed: submitting ? null : _signIn,
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        const Expanded(child: Hairline()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'or',
                            style: MnText.foot.copyWith(color: c.ink3),
                          ),
                        ),
                        const Expanded(child: Hairline()),
                      ],
                    ),
                    const SizedBox(height: 22),
                    MnButton(
                      variant: MnVariant.outline,
                      leading: BrandGlyph('google', color: c.ink),
                      label: 'Continue with Google',
                      onPressed: submitting ? null : _signIn,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24, 8, 24, safeBottom(context) + 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'New to MindNest? ',
                  style: MnText.callout.copyWith(color: c.ink2),
                ),
                LinkBtn(
                  'Create account',
                  onTap: () =>
                      context.pushNamed(RouteNames.signup, extra: widget.role),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
