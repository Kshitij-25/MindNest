import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';
import 'package:mindnest_app/shared/models/user_role.dart';

import '../cubit/auth_cubit.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key, required this.role});
  final UserRole role;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<AuthCubit>(),
    child: _OtpView(role: role),
  );
}

class _OtpView extends StatefulWidget {
  const _OtpView({required this.role});
  final UserRole role;

  @override
  State<_OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<_OtpView> {
  static const _code = '482913';
  final List<String> _digits = List.filled(6, '');
  final List<Timer> _fillTimers = [];
  Timer? _ticker;
  int _remaining = 28;

  @override
  void initState() {
    super.initState();
    _autoFill();
    _startCountdown();
  }

  void _autoFill() {
    for (var i = 0; i < _code.length; i++) {
      _fillTimers.add(
        Timer(Duration(milliseconds: 90 * (i + 1)), () {
          if (!mounted) return;
          setState(() => _digits[i] = _code[i]);
        }),
      );
    }
  }

  void _startCountdown() {
    _ticker = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (_remaining <= 0) {
        t.cancel();
        return;
      }
      setState(() => _remaining--);
    });
  }

  void _resend() {
    setState(() {
      for (var i = 0; i < _digits.length; i++) {
        _digits[i] = '';
      }
      _remaining = 28;
    });
    _autoFill();
    _startCountdown();
  }

  @override
  void dispose() {
    for (final t in _fillTimers) {
      t.cancel();
    }
    _ticker?.cancel();
    super.dispose();
  }

  bool get _filled => _digits.every((d) => d.isNotEmpty);

  Future<void> _verify() async {
    final cubit = context.read<AuthCubit>();
    final ok = await cubit.verify(widget.role, code: _digits.join());
    if (ok && mounted) {
      context.goNamed(
        widget.role.isPro
            ? RouteNames.proCredentials
            : RouteNames.questionnaire,
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
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 30),
                children: [
                  const SizedBox(height: 8),
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: c.primaryTint,
                      borderRadius: BorderRadius.circular(MnRadius.md),
                    ),
                    alignment: Alignment.center,
                    child: MnIcon(
                      'message',
                      size: 30,
                      color: c.primary,
                      stroke: 1.9,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    'Verify your number',
                    style: MnText.title1.copyWith(color: c.ink),
                  ),
                  const SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      style: MnText.body.copyWith(color: c.ink2),
                      children: [
                        const TextSpan(text: 'We sent a 6-digit code to '),
                        TextSpan(
                          text: '+44 ••• ••892',
                          style: MnText.body.copyWith(
                            color: c.ink,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const TextSpan(text: '.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      for (var i = 0; i < 6; i++)
                        Expanded(
                          child: Container(
                            height: 60,
                            margin: EdgeInsets.only(left: i == 0 ? 0 : 8),
                            decoration: BoxDecoration(
                              color: c.surface,
                              borderRadius: BorderRadius.circular(MnRadius.sm),
                              border: Border.all(
                                color: _digits[i].isNotEmpty
                                    ? c.primary
                                    : c.hairline,
                                width: 1.5,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              _digits[i],
                              style: MnText.title2.copyWith(color: c.ink),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: _remaining > 0
                        ? Text(
                            'Resend code in ${_remaining}s',
                            style: MnText.foot.copyWith(color: c.ink3),
                          )
                        : LinkBtn('Resend code', onTap: _resend),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24, 8, 24, safeBottom(context) + 16),
            child: MnButton(
              label: 'Verify',
              onPressed: (_filled && !submitting) ? _verify : null,
            ),
          ),
        ],
      ),
    );
  }
}
