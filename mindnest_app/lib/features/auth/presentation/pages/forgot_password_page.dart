import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';

import '../cubit/auth_cubit.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<AuthCubit>(),
    child: const _ForgotView(),
  );
}

class _ForgotView extends StatefulWidget {
  const _ForgotView();

  @override
  State<_ForgotView> createState() => _ForgotViewState();
}

class _ForgotViewState extends State<_ForgotView> {
  final _email = TextEditingController();
  bool _sent = false;

  bool get _valid => _email.text.contains('@');

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final ok = await context.read<AuthCubit>().sendReset(_email.text);
    if (ok && mounted) setState(() => _sent = true);
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
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 30),
                children: _sent ? _sentView(c) : _formView(c, submitting),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _formView(MnColors c, bool submitting) => [
    const SizedBox(height: 8),
    Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: c.primaryTint,
        borderRadius: BorderRadius.circular(MnRadius.md),
      ),
      alignment: Alignment.center,
      child: MnIcon('lock', size: 30, color: c.primary, stroke: 1.9),
    ),
    const SizedBox(height: 22),
    Text('Forgot password?', style: MnText.title1.copyWith(color: c.ink)),
    const SizedBox(height: 8),
    Text(
      'Enter the email tied to your account and we’ll send a link to reset it.',
      style: MnText.body.copyWith(color: c.ink2),
    ),
    const SizedBox(height: 26),
    MnField(
      icon: 'mail',
      hint: 'Email',
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      onChanged: (_) => setState(() {}),
    ),
    const SizedBox(height: 22),
    MnButton(
      label: 'Send reset link',
      onPressed: (_valid && !submitting) ? _send : null,
    ),
  ];

  List<Widget> _sentView(MnColors c) => [
    const SizedBox(height: 8),
    Center(
      child: Container(
        width: 88,
        height: 88,
        decoration: BoxDecoration(color: c.primaryTint, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: MnIcon('mail', size: 38, color: c.primary, stroke: 1.8),
      ),
    ),
    const SizedBox(height: 24),
    Text(
      'Check your inbox',
      textAlign: TextAlign.center,
      style: MnText.title2.copyWith(color: c.ink),
    ),
    const SizedBox(height: 10),
    Text.rich(
      TextSpan(
        style: MnText.body.copyWith(color: c.ink2),
        children: [
          const TextSpan(text: 'We’ve sent a reset link to '),
          TextSpan(
            text: _email.text.isEmpty ? 'your email' : _email.text,
            style: MnText.body.copyWith(
              color: c.ink,
              fontWeight: FontWeight.w700,
            ),
          ),
          const TextSpan(text: '. Follow it to set a new password.'),
        ],
      ),
      textAlign: TextAlign.center,
    ),
    const SizedBox(height: 28),
    MnButton(label: 'Back to sign in', onPressed: () => context.pop()),
    const SizedBox(height: 14),
    Center(
      child: LinkBtn(
        'Use a different email',
        onTap: () => setState(() => _sent = false),
      ),
    ),
  ];
}
