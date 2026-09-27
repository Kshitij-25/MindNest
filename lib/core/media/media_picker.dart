import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

import '../adaptive/adaptive.dart';

/// Picks a photo from the camera or library and returns it as a compressed
/// JPEG no larger than [maxSide] px on its longest side. Null if cancelled.
///
/// Pass [onRemove] to offer a "Remove photo" option; it's called instead.
Future<Uint8List?> pickPhoto(
  BuildContext context, {
  String? title,
  int maxSide = 1280,
  int quality = 75,
  VoidCallback? onRemove,
}) async {
  final choice = await Adaptive.actionSheet<String>(
    context,
    title: title,
    actions: [
      const AdaptiveAction(label: 'Take photo', value: 'camera', icon: Icons.photo_camera_outlined),
      const AdaptiveAction(label: 'Choose from library', value: 'library', icon: Icons.photo_library_outlined),
      if (onRemove != null) const AdaptiveAction(label: 'Remove photo', value: 'remove', icon: Icons.delete_outline, destructive: true),
    ],
  );
  if (choice == null) return null;
  if (choice == 'remove') {
    onRemove?.call();
    return null;
  }
  final file = await ImagePicker().pickImage(source: choice == 'camera' ? ImageSource.camera : ImageSource.gallery);
  if (file == null) return null;
  return FlutterImageCompress.compressWithList(await file.readAsBytes(), minWidth: maxSide, minHeight: maxSide, quality: quality);
}

/// Picks a PDF. Returns its name and bytes, or null if cancelled.
Future<({String name, Uint8List bytes})?> pickPdf() async {
  final file = await FilePicker.pickFile(type: FileType.custom, allowedExtensions: const ['pdf']);
  if (file == null) return null;
  return (name: file.name, bytes: await file.readAsBytes());
}
