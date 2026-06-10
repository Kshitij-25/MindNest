import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';
import 'package:mindnest_app/shared/models/user_role.dart';

import '../cubit/auth_cubit.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key, required this.role});
  final UserRole role;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<AuthCubit>(),
    child: _SignupView(role: role),
  );
}

class _SignupView extends StatefulWidget {
  const _SignupView({required this.role});
  final UserRole role;

  @override
  State<_SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<_SignupView> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _agree = true;

  static const _labels = ['Too short', 'Weak', 'Good', 'Strong'];

  int get _score {
    final p = _password.text;
    final hasDigit = p.contains(RegExp(r'\d'));
    return (p.length ~/ 3 + (hasDigit ? 1 : 0)).clamp(0, 3);
  }

  bool get _valid =>
      _name.text.trim().isNotEmpty &&
      _email.text.contains('@') &&
      _password.text.length >= 6 &&
      _agree;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    final cubit = context.read<AuthCubit>();
    final ok = await cubit.signUp(
      widget.role,
      name: _name.text,
      email: _email.text,
      password: _password.text,
    );
    if (ok && mounted) context.pushNamed(RouteNames.otp, extra: widget.role);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final submitting = context.watch<AuthCubit>().state.submitting;
    final colors = [c.ink4, c.amber, c.moss500, c.green];
    final score = _score;
    return MnScaffold(
      child: Column(
        children: [
          SizedBox(height: safeTop(context)),
          NavHeader(
            title: widget.role.isPro
                ? 'Professional sign up'
                : 'Create account',
            onBack: () => context.pop(),
          ),
          Expanded(
            child: NoGlow(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 6, 24, 30),
                children: [
                  Text(
                    widget.role.isPro
                        ? 'Set up your professional account. We’ll verify your credentials next.'
                        : 'A few details and you’re in. It only takes a moment.',
                    style: MnText.body.copyWith(color: c.ink2),
                  ),
                  const SizedBox(height: 24),
                  MnField(
                    icon: 'user',
                    hint: 'Full name',
                    controller: _name,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 12),
                  MnField(
                    icon: 'mail',
                    hint: 'Email',
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 12),
                  MnField(
                    icon: 'lock',
                    hint: 'Password',
                    controller: _password,
                    obscure: true,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      for (var i = 0; i < 4; i++)
                        Expanded(
                          child: Container(
                            height: 5,
                            margin: EdgeInsets.only(left: i == 0 ? 0 : 6),
                            decoration: BoxDecoration(
                              color: i <= score && _password.text.isNotEmpty
                                  ? colors[score]
                                  : c.fill2,
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _password.text.isEmpty
                        ? 'Use 6+ characters'
                        : _labels[score],
                    style: MnText.foot.copyWith(
                      color: _password.text.isEmpty ? c.ink3 : colors[score],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Pressable(
                    onTap: () => setState(() => _agree = !_agree),
                    scale: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          margin: const EdgeInsets.only(top: 1),
                          decoration: BoxDecoration(
                            color: _agree ? c.primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                              color: _agree ? c.primary : c.hairline2,
                              width: 1.5,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: _agree
                              ? MnIcon(
                                  'check',
                                  size: 15,
                                  color: c.onPrimary,
                                  stroke: 2.6,
                                )
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'I agree to the Terms of Service and Privacy Policy.',
                            style: MnText.callout.copyWith(color: c.ink2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(24, 12, 24, safeBottom(context) + 16),
            decoration: BoxDecoration(
              color: c.bg,
              border: Border(top: BorderSide(color: c.hairline, width: 0.5)),
            ),
            child: Column(
              children: [
                MnButton(
                  label: 'Continue',
                  onPressed: (_valid && !submitting) ? _continue : null,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: MnText.callout.copyWith(color: c.ink2),
                    ),
                    LinkBtn('Sign in', onTap: () => context.pop()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
