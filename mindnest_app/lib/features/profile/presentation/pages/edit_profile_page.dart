import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';

import '../cubit/profile_cubit.dart';

/// Edit profile — pushed page with a local form.
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<ProfileCubit>()..load(),
    child: const _EditProfileView(),
  );
}

class _EditProfileView extends StatefulWidget {
  const _EditProfileView();

  @override
  State<_EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<_EditProfileView> {
  final _name = TextEditingController(text: 'Maya Levine');
  final _email = TextEditingController(text: 'maya.levine@email.com');
  final _phone = TextEditingController(text: '+44 7700 900892');
  final _about = TextEditingController(
    text: 'Learning to slow down and be kinder to myself.',
  );
  bool _seeded = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _about.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        final p = state.profile;
        if (p != null && !_seeded) {
          _name.text = p.name;
          _email.text = p.email;
          _seeded = true;
        }
      },
      child: MnScaffold(
        child: Column(
          children: [
            SizedBox(height: safeTop(context)),
            NavHeader(
              title: 'Edit profile',
              onBack: () => context.pop(),
              right: LinkBtn('Save', onTap: () => context.pop()),
            ),
            Expanded(
              child: NoGlow(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
                  children: [
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Avatar(_name.text, size: 96, ring: true),
                          Positioned(
                            right: -2,
                            bottom: -2,
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: c.primary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: c.surface,
                                  width: 2.5,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: MnIcon(
                                'camera',
                                size: 17,
                                color: c.onPrimary,
                                stroke: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    const _Label('Full name'),
                    MnField(icon: 'user', hint: 'Full name', controller: _name),
                    const SizedBox(height: 18),
                    const _Label('Email'),
                    MnField(
                      icon: 'mail',
                      hint: 'Email',
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 18),
                    const _Label('Phone'),
                    MnField(
                      icon: 'phone',
                      hint: 'Phone',
                      controller: _phone,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 26),
                    Text(
                      'About you',
                      style: MnText.title3.copyWith(color: c.ink),
                    ),
                    const SizedBox(height: 12),
                    MnField(
                      hint: 'Tell us a little about yourself',
                      controller: _about,
                      minLines: 3,
                      maxLines: 6,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(2, 0, 0, 8),
    child: Text(
      text,
      style: MnText.foot.copyWith(
        color: context.c.ink2,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
