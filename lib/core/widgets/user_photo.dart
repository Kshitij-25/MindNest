import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../di/injection.dart';
import '../firebase/avatars.dart';

/// Shows [userId]'s profile photo (cover-fit) if they've set one, otherwise
/// [fallback]. Refreshes when any photo changes.
class UserPhoto extends StatelessWidget {
  const UserPhoto({super.key, required this.userId, required this.fallback});
  final String? userId;
  final Widget fallback;

  @override
  Widget build(BuildContext context) {
    final id = userId;
    if (id == null || id.isEmpty || !getIt.isRegistered<AvatarStore>()) return fallback;
    final store = getIt<AvatarStore>();
    return ValueListenableBuilder<int>(
      valueListenable: store.changes,
      builder: (_, _, _) => FutureBuilder<Uint8List?>(
        future: store.load(id),
        builder: (_, snap) {
          final bytes = snap.data;
          if (bytes == null) return fallback;
          return Image.memory(bytes, fit: BoxFit.cover, gaplessPlayback: true, width: double.infinity, height: double.infinity);
        },
      ),
    );
  }
}
