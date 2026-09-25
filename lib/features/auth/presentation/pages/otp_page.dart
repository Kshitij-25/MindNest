import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class _OtpView extends StatefulWidget {
  const _OtpView();

  @override
  State<_OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<_OtpView> {
  final _ctrl = TextEditingController();
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focus.requestFocus());
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final phone = context.select(
      (AuthBloc b) => b.state.user?.maskedPhone ?? '+44 ••• ••892',
    );
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
                    Text('Verify your number', style: context.text.title1),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        text: 'Enter the 6-digit code we sent to ',
                        children: [
                          TextSpan(
                            text: phone,
                            style: TextStyle(
                              color: c.ink,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                      style: context.text.body.copyWith(color: c.ink2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // One hidden field drives six visual boxes (supports paste & SMS autofill).
              Stack(
                children: [
                  Opacity(
                    opacity: 0,
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: _ctrl,
                        focusNode: _focus,
                        keyboardType: TextInputType.number,
                        autofillHints: const [AutofillHints.oneTimeCode],
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                        ],
                        onChanged: cubit.codeChanged,
                        showCursor: false,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _focus.requestFocus(),
                    child: Semantics(
                      label:
                          'Verification code, ${s.code.length} of 6 digits entered',
                      child: Row(
                        children: [
                          for (var i = 0; i < 6; i++) ...[
                            if (i > 0) const SizedBox(width: 9),
                            Expanded(
                              child: _Box(
                                digit: i < s.code.length ? s.code[i] : null,
                                active: i == s.code.length,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 26),
              Center(
                child: s.secondsLeft > 0
                    ? Text(
                        'Resend code in 0:${s.secondsLeft.toString().padLeft(2, '0')}',
                        style: context.text.callout.copyWith(color: c.ink3),
                      )
                    : MnLinkButton(
                        label: 'Resend code',
                        onPressed: cubit.resend,
                      ),
              ),
              const SizedBox(height: 28),
              MnButton(
                label: 'Verify',
                loading: s.status == FormStatus.submitting,
                onPressed: s.complete ? cubit.verify : null,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Box extends StatelessWidget {
  const _Box({required this.digit, required this.active});
  final String? digit;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final filled = digit != null;
    return AspectRatio(
      aspectRatio: 1,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 56),
        child: AnimatedContainer(
          duration: MnMotion.base,
          curve: MnMotion.ease,
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: filled || active ? c.primary : c.hairline,
              width: 1.5,
            ),
            boxShadow: filled ? MnShadows.ring(c) : const [],
          ),
          alignment: Alignment.center,
          child: filled
              ? PopIn(
                  key: ValueKey(digit),
                  child: Text(
                    digit!,
                    style: context.text.title2.copyWith(fontSize: 24),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
