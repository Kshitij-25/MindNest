import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';

class _Doc {
  const _Doc(this.id, this.icon, this.title, this.subtitle);
  final String id, icon, title, subtitle;
}

class ProCredentialsPage extends StatefulWidget {
  const ProCredentialsPage({super.key});

  @override
  State<ProCredentialsPage> createState() => _ProCredentialsPageState();
}

class _ProCredentialsPageState extends State<ProCredentialsPage> {
  static const _docs = [
    _Doc(
      'license',
      'doc',
      'Practising licence',
      'PDF or photo of your current licence',
    ),
    _Doc('id', 'user', 'Photo ID', 'Passport or driver’s licence'),
    _Doc(
      'certs',
      'award',
      'Qualifications',
      'Degree certificates & accreditations',
    ),
  ];

  final _uploaded = <String>{'license'};

  void _toggle(String id) => setState(
    () => _uploaded.contains(id) ? _uploaded.remove(id) : _uploaded.add(id),
  );

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final count = _uploaded.length;
    final done = count >= _docs.length;
    return MnScaffold(
      child: Column(
        children: [
          SizedBox(height: safeTop(context)),
          NavHeader(title: 'Verify credentials', onBack: () => context.pop()),
          Expanded(
            child: NoGlow(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),
                children: [
                  Center(
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: c.primaryTint,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: MnIcon(
                        'shield',
                        size: 30,
                        color: c.primary,
                        stroke: 1.9,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Let’s verify you',
                    textAlign: TextAlign.center,
                    style: MnText.title2.copyWith(color: c.ink),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Upload three documents so we can confirm you’re a registered professional. This keeps the MindNest community safe.',
                    textAlign: TextAlign.center,
                    style: MnText.body.copyWith(color: c.ink2),
                  ),
                  const SizedBox(height: 22),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: count / _docs.length,
                      minHeight: 8,
                      backgroundColor: c.fill2,
                      valueColor: AlwaysStoppedAnimation(c.primary),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$count of ${_docs.length} uploaded',
                    style: MnText.foot.copyWith(color: c.ink3),
                  ),
                  const SizedBox(height: 18),
                  for (final d in _docs) ...[
                    _DocTile(
                      doc: d,
                      uploaded: _uploaded.contains(d.id),
                      onTap: () => _toggle(d.id),
                    ),
                    const SizedBox(height: 12),
                  ],
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      MnIcon('lock', size: 15, color: c.ink3, stroke: 1.9),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Your documents are encrypted and only seen by our verification team.',
                          style: MnText.cap.copyWith(
                            color: c.ink3,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, safeBottom(context) + 12),
            decoration: BoxDecoration(
              color: c.bg.withValues(alpha: 0.95),
              border: Border(top: BorderSide(color: c.hairline, width: 0.5)),
            ),
            child: MnButton(
              label: 'Submit for review',
              onPressed: done
                  ? () => context.goNamed(RouteNames.proVerify)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _DocTile extends StatelessWidget {
  const _DocTile({
    required this.doc,
    required this.uploaded,
    required this.onTap,
  });
  final _Doc doc;
  final bool uploaded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return MnCard(
      onTap: onTap,
      color: uploaded ? c.primaryTint : c.surface,
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: uploaded ? c.primary : c.fill,
              borderRadius: BorderRadius.circular(13),
            ),
            alignment: Alignment.center,
            child: MnIcon(
              uploaded ? 'check' : doc.icon,
              size: 21,
              color: uploaded ? c.onPrimary : c.ink3,
              stroke: uploaded ? 2.4 : 1.9,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doc.title,
                  style: MnText.headline.copyWith(color: c.ink, fontSize: 15),
                ),
                const SizedBox(height: 2),
                Text(
                  uploaded ? 'Uploaded · tap to remove' : doc.subtitle,
                  style: MnText.foot.copyWith(
                    color: uploaded ? c.primary : c.ink3,
                  ),
                ),
              ],
            ),
          ),
          if (!uploaded) MnIcon('upload', size: 20, color: c.ink3, stroke: 1.9),
        ],
      ),
    );
  }
}
