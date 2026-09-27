import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/firebase/avatars.dart';
import '../../../../core/media/media_picker.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../cubit/edit_profile_cubit.dart';

@RoutePage()
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  /// Photos are stored as a 512px JPEG in `avatars/{uid}` (see [AvatarStore]).
  static Future<void> _changePhoto(BuildContext context) async {
    final uid = context.read<AuthBloc>().state.user?.id;
    if (uid == null) return;
    final store = getIt<AvatarStore>();
    final messenger = ScaffoldMessenger.of(context);
    final hasPhoto = await store.load(uid) != null;
    if (!context.mounted) return;
    try {
      final jpeg = await pickPhoto(
        context,
        title: 'Profile photo',
        maxSide: 512,
        quality: 80,
        onRemove: hasPhoto
            ? () => store.remove(uid).then((_) => messenger.showSnackBar(const SnackBar(content: Text('Photo removed'))))
            : null,
      );
      if (jpeg == null) return;
      await store.set(uid, jpeg);
      messenger.showSnackBar(const SnackBar(content: Text('Photo updated')));
    } catch (_) {
      messenger.showSnackBar(const SnackBar(content: Text('Couldn’t update your photo. Please try again.')));
    }
  }

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
                            MnAvatar(userId: context.read<AuthBloc>().state.user?.id, name: s.name.isEmpty ? '?' : s.name, size: 96),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Pressable(
                                semanticLabel: 'Change photo',
                                onTap: () => _changePhoto(context),
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
