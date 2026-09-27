import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../../../../core/core.dart';
import '../../domain/entities/practice_entities.dart';

enum _Source { pdf, photo }

/// Lets the professional pick a PDF or a photo. Photos are downscaled and
/// re-encoded as JPEG so a phone picture fits comfortably in the upload.
Future<DocumentFile?> pickDocumentFile(BuildContext context) async {
  final source = await Adaptive.actionSheet<_Source>(
    context,
    title: 'Add document',
    actions: const [
      AdaptiveAction(label: 'Choose a PDF', value: _Source.pdf, icon: Icons.picture_as_pdf_outlined),
      AdaptiveAction(label: 'Choose a photo', value: _Source.photo, icon: Icons.photo_library_outlined),
    ],
  );
  if (source == null) return null;
  final file = await FilePicker.pickFile(
    type: source == _Source.pdf ? FileType.custom : FileType.image,
    allowedExtensions: source == _Source.pdf ? const ['pdf'] : null,
  );
  if (file == null) return null;
  final bytes = await file.readAsBytes();
  if (source == _Source.pdf) return DocumentFile(name: file.name, bytes: bytes, isPdf: true);
  final jpeg = await FlutterImageCompress.compressWithList(bytes, minWidth: 1800, minHeight: 1800, quality: 80);
  final base = file.name.contains('.') ? file.name.substring(0, file.name.lastIndexOf('.')) : file.name;
  return DocumentFile(name: '$base.jpg', bytes: jpeg, isPdf: false);
}
