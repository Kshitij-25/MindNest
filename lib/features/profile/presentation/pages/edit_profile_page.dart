import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../cubit/edit_profile_cubit.dart';

@RoutePage()
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EditProfileCubit>()..load(),
      child: BlocConsumer<EditProfileCubit, EditProfileState>(
        listenWhen: (a, b) => !a.saved && b.saved,
        listener: (context, _) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated')));
          context.router.maybePop();
        },
        builder: (context, s) {
          final c = context.colors;
          final cubit = context.read<EditProfileCubit>();
          return MnPage(
            maxWidth: 560,
            header: MnNavHeader(
              title: 'Edit profile',
              trailing: Padding(
                padding: const EdgeInsets.only(right: 6),
                child: s.saving
                    ? const Padding(padding: EdgeInsets.all(10), child: AdaptiveLoader(size: 20))
                    : MnLinkButton(label: 'Save', onPressed: s.valid ? cubit.save : null),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 30),
            body: !s.loaded
                ? const LoadingView()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            MnAvatar(name: s.name.isEmpty ? '?' : s.name, size: 96),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Pressable(
                                semanticLabel: 'Change photo',
                                onTap: () => Adaptive.actionSheet<String>(
                                  context,
                                  title: 'Profile photo',
                                  actions: const [
                                    AdaptiveAction(label: 'Take photo', value: 'camera', icon: Icons.photo_camera_outlined),
                                    AdaptiveAction(label: 'Choose from library', value: 'library', icon: Icons.photo_library_outlined),
                                  ],
                                ),
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(color: c.primary, shape: BoxShape.circle, border: Border.all(color: c.bg, width: 3)),
                                  alignment: Alignment.center,
                                  child: MnIcon(MnIcons.camera, size: 16, color: c.onPrimary),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 26),
                      MnTextField(
                        label: 'Full name',
                        icon: MnIcons.user,
                        initialValue: s.name,
                        onChanged: cubit.nameChanged,
                        textCapitalization: TextCapitalization.words,
                        autofillHints: const [AutofillHints.name],
                        errorText: s.name.trim().isEmpty ? 'Name is required' : null,
                      ),
                      const SizedBox(height: 18),
                      MnTextField(
                        label: 'Email',
                        icon: MnIcons.mail,
                        initialValue: s.email,
                        onChanged: cubit.emailChanged,
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        errorText: s.email.contains('@') ? null : 'Enter a valid email',
                      ),
                      const SizedBox(height: 18),
                      MnTextField(
                        label: 'Phone',
                        icon: MnIcons.phone,
                        initialValue: s.phone,
                        onChanged: cubit.phoneChanged,
                        keyboardType: TextInputType.phone,
                        autofillHints: const [AutofillHints.telephoneNumber],
                      ),
                      const SizedBox(height: 18),
                      MnTextField(label: 'About you', initialValue: s.bio, onChanged: cubit.bioChanged, maxLines: 4, minLines: 3),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
