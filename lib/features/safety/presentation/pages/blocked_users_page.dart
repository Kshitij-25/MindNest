import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../domain/safety.dart';

@RoutePage()
class BlockedUsersPage extends StatefulWidget {
  const BlockedUsersPage({super.key});

  @override
  State<BlockedUsersPage> createState() => _BlockedUsersPageState();
}

class _BlockedUsersPageState extends State<BlockedUsersPage> {
  final _repo = getIt<SafetyRepository>();
  List<BlockedUser>? _users;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final r = await _repo.blockedUsers();
    if (!mounted) return;
    setState(() => r.fold((f) => _error = f.message, (u) => _users = u));
  }

  Future<void> _unblock(BlockedUser u) async {
    final ok = await Adaptive.confirm(context, title: 'Unblock ${u.name}?', confirmLabel: 'Unblock');
    if (!ok) return;
    final r = await _repo.unblock(u.id);
    if (!mounted) return;
    r.fold(
      (f) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(f.message))),
      (_) => setState(() => _users = [..._users!]..remove(u)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final users = _users;
    return MnPage(
      maxWidth: 640,
      header: const MnNavHeader(title: 'Blocked users'),
      body: _error != null
          ? ErrorView(message: _error!)
          : users == null
              ? const LoadingView()
              : users.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text('You haven’t blocked anyone.', textAlign: TextAlign.center, style: context.text.callout.copyWith(color: c.ink3)),
                    )
                  : MnGroup(
                      children: [
                        for (final u in users)
                          MnListRow(
                            title: u.name,
                            leading: MnAvatar(name: u.name, size: 36),
                            showChevron: false,
                            trailing: MnLinkButton(label: 'Unblock', onPressed: () => _unblock(u)),
                          ),
                      ],
                    ),
    );
  }
}
