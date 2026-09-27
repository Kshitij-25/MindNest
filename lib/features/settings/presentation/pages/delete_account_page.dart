import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/cubit/delete_account_cubit.dart';

@RoutePage()
class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final _password = TextEditingController();

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit(BuildContext context, DeleteAccountCubit cubit) async {
    final ok = await Adaptive.confirm(
      context,
      title: 'Delete your account?',
      message: 'This can’t be undone.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (!ok) return;
    await cubit.delete(password: cubit.usesPassword ? _password.text : null);
  }

  @override
  Widget build(BuildContext context) {
    final isPro = context.read<AuthBloc>().state.isPro;
    return BlocProvider(
      create: (_) => getIt<DeleteAccountCubit>(),
      child: BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
        listenWhen: (a, b) => a != b && (b.deleted || b.error != null),
        listener: (context, s) {
          if (s.deleted) {
            context.read<AuthBloc>().add(const AuthEvent.signedOut());
            context.router.replaceAll([const SplashRoute()]);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Your account has been deleted.')));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s.error!)));
          }
        },
        builder: (context, s) {
          final c = context.colors;
          final cubit = context.read<DeleteAccountCubit>();
          final erased = [
            'Your profile, photo, settings and notification history',
            if (!isPro) 'Your mood check-ins, journal entries and saved items',
            if (isPro) 'Your directory listing, client notes and goals, and published articles',
            'Your comments on articles',
            'Upcoming sessions are cancelled and the other person is notified',
          ];
          return MnPage(
            maxWidth: 560,
            header: const MnNavHeader(title: 'Delete account'),
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 30),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('This permanently deletes your MindNest account.', style: context.text.title3),
                const SizedBox(height: 14),
                Text('What gets erased', style: context.text.headline),
                const SizedBox(height: 8),
                for (final line in erased)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: const EdgeInsets.only(top: 2), child: MnIcon(MnIcons.check, size: 16, color: c.red, stroke: 2.2)),
                        const SizedBox(width: 10),
                        Expanded(child: Text(line, style: context.text.callout.copyWith(color: c.ink2))),
                      ],
                    ),
                  ),
                const SizedBox(height: 14),
                MnCard(
                  style: MnCardStyle.inset,
                  padding: const EdgeInsets.all(14),
                  child: Text(
                    'Past session records, messages you sent and reviews you wrote stay visible to the other person, '
                    'because they’re part of their history too.',
                    style: context.text.cap.copyWith(color: c.ink2),
                  ),
                ),
                const SizedBox(height: 22),
                if (cubit.usesPassword) ...[
                  MnTextField(
                    controller: _password,
                    label: 'Confirm your password',
                    icon: MnIcons.lock,
                    obscure: true,
                    autofillHints: const [AutofillHints.password],
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 18),
                ] else ...[
                  Text('You’ll be asked to sign in with Google again to confirm.', style: context.text.foot.copyWith(color: c.ink3)),
                  const SizedBox(height: 18),
                ],
                MnButton(
                  label: 'Delete my account',
                  variant: MnButtonVariant.danger,
                  loading: s.deleting,
                  onPressed: s.deleting || (cubit.usesPassword && _password.text.isEmpty) ? null : () => _submit(context, cubit),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
