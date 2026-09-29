import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/usecases/chat_usecases.dart';

/// A photo or PDF inside a chat bubble. Bytes load on demand.
class AttachmentView extends StatefulWidget {
  const AttachmentView({super.key, required this.conversationId, required this.attachment, required this.fromMe});
  final String conversationId;
  final ChatAttachment attachment;
  final bool fromMe;

  @override
  State<AttachmentView> createState() => _AttachmentViewState();
}

class _AttachmentViewState extends State<AttachmentView> {
  late final Future<Uint8List?> _bytes = getIt<LoadAttachment>()(widget.conversationId, widget.attachment.id)
      .then((r) => r.fold((_) => null, (b) => b));

  Future<void> _openPdf(Uint8List bytes) => SharePlus.instance.share(
        ShareParams(files: [XFile.fromData(bytes, name: widget.attachment.name, mimeType: 'application/pdf')], fileNameOverrides: [widget.attachment.name]),
      );

  void _openImage(Uint8List bytes) => Navigator.of(context).push(
        MaterialPageRoute<void>(
          fullscreenDialog: true,
          builder: (_) => Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(backgroundColor: Colors.black, foregroundColor: Colors.white),
            body: Center(child: InteractiveViewer(maxScale: 5, child: Image.memory(bytes))),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final a = widget.attachment;
    final fg = widget.fromMe ? c.onPrimary : c.ink;
    return FutureBuilder<Uint8List?>(
      future: _bytes,
      builder: (context, snap) {
        final bytes = snap.data;
        final loading = snap.connectionState != ConnectionState.done;
        if (a.kind == AttachmentKind.image) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: 220,
              height: 220,
              child: bytes != null
                  ? Pressable(
                      onTap: () => _openImage(bytes),
                      semanticLabel: 'Photo. Tap to view full screen',
                      child: Image.memory(bytes, fit: BoxFit.cover),
                    )
                  : ColoredBox(
                      color: c.fill,
                      child: Center(
                        child: loading
                            ? const AdaptiveLoader(size: 20)
                            : Text('Photo unavailable', style: context.text.cap.copyWith(color: c.ink3)),
                      ),
                    ),
            ),
          );
        }
        return Pressable(
          onTap: bytes == null ? null : () => _openPdf(bytes),
          semanticLabel: 'PDF ${a.name}. Tap to open',
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 14, 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                loading ? const SizedBox(width: 28, height: 28, child: AdaptiveLoader(size: 18)) : MnIcon(MnIcons.doc, size: 28, color: fg),
                const SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(a.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: fg, fontWeight: FontWeight.w600, fontSize: 15)),
                      Text('PDF · ${(a.size / 1024).ceil()} KB',
                          style: TextStyle(color: fg.withValues(alpha: .75), fontSize: 12.5)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
