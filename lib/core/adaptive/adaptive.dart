import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_tokens.dart';
import '../utils/context_x.dart';

/// Platform touches: the MindNest look stays shared, but system-level
/// interactions follow iOS / Android conventions.
abstract final class Adaptive {
  /// Light haptic tick (iOS selection click, Android light impact).
  static void tap(BuildContext context) {
    context.isIOS
        ? HapticFeedback.selectionClick()
        : HapticFeedback.lightImpact();
  }

  static void success(BuildContext context) => HapticFeedback.mediumImpact();

  static ScrollPhysics scrollPhysics(BuildContext context) => context.isIOS
      ? const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics())
      : const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics());

  /// A confirm dialog: CupertinoAlertDialog on iOS, Material AlertDialog elsewhere.
  static Future<bool> confirm(
    BuildContext context, {
    required String title,
    String? message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool destructive = false,
  }) async {
    final c = context.colors;
    final result = await showAdaptiveDialog<bool>(
      context: context,
      builder: (ctx) {
        if (context.isIOS) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: message == null ? null : Text(message),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(cancelLabel),
              ),
              CupertinoDialogAction(
                isDestructiveAction: destructive,
                isDefaultAction: !destructive,
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(confirmLabel),
              ),
            ],
          );
        }
        return AlertDialog(
          title: Text(title, style: ctx.text.title3),
          content: message == null
              ? null
              : Text(message, style: ctx.text.callout.copyWith(color: c.ink2)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(cancelLabel, style: TextStyle(color: c.ink2)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(
                confirmLabel,
                style: TextStyle(
                  color: destructive ? c.red : c.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  /// Action sheet: CupertinoActionSheet on iOS, a styled bottom sheet list on Android.
  static Future<T?> actionSheet<T>(
    BuildContext context, {
    String? title,
    required List<AdaptiveAction<T>> actions,
  }) {
    if (context.isIOS) {
      return showCupertinoModalPopup<T>(
        context: context,
        builder: (ctx) => CupertinoActionSheet(
          title: title == null ? null : Text(title),
          actions: [
            for (final a in actions)
              CupertinoActionSheetAction(
                isDestructiveAction: a.destructive,
                onPressed: () => Navigator.pop(ctx, a.value),
                child: Text(a.label),
              ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
        ),
      );
    }
    final c = context.colors;
    return showModalBottomSheet<T>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                child: Text(
                  title,
                  style: ctx.text.foot.copyWith(color: c.ink3),
                ),
              ),
            for (final a in actions)
              ListTile(
                leading: a.icon == null
                    ? null
                    : Icon(a.icon, color: a.destructive ? c.red : c.ink2),
                title: Text(
                  a.label,
                  style: ctx.text.headline.copyWith(
                    color: a.destructive ? c.red : c.ink,
                  ),
                ),
                onTap: () => Navigator.pop(ctx, a.value),
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  /// Date picker: Cupertino wheel in a sheet on iOS, Material calendar on Android.
  static Future<DateTime?> pickDate(
    BuildContext context, {
    required DateTime initial,
    DateTime? first,
    DateTime? last,
  }) async {
    first ??= DateTime(1920);
    last ??= DateTime(2100);
    if (context.isIOS) {
      var picked = initial;
      final ok = await showCupertinoModalPopup<bool>(
        context: context,
        builder: (ctx) => Container(
          height: 300,
          color: ctx.colors.elevated,
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: CupertinoButton(
                    child: const Text('Done'),
                    onPressed: () => Navigator.pop(ctx, true),
                  ),
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: initial,
                    minimumDate: first,
                    maximumDate: last,
                    onDateTimeChanged: (d) => picked = d,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      return ok == true ? picked : null;
    }
    return showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: first,
      lastDate: last,
    );
  }
}

class AdaptiveAction<T> {
  const AdaptiveAction({
    required this.label,
    required this.value,
    this.icon,
    this.destructive = false,
  });
  final String label;
  final T value;
  final IconData? icon;
  final bool destructive;
}

/// Platform loader.
class AdaptiveLoader extends StatelessWidget {
  const AdaptiveLoader({super.key, this.size = 26, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final col = color ?? context.colors.primary;
    if (context.isIOS) {
      return CupertinoActivityIndicator(radius: size / 2.4, color: col);
    }
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        color: col,
        backgroundColor: context.colors.hairline2,
      ),
    );
  }
}

/// Shows a MindNest-styled modal sheet. On tablets it presents as a centred
/// dialog instead of a full-width sheet.
Future<T?> showMnSheet<T>(
  BuildContext context, {
  required WidgetBuilder builder,
  bool expand = false,
}) {
  final c = context.colors;
  if (context.isTablet) {
    return showDialog<T>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: .35),
      builder: (ctx) => Dialog(
        backgroundColor: c.elevated,
        insetPadding: const EdgeInsets.all(40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MnRadii.xl),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 520,
            maxHeight: MediaQuery.sizeOf(ctx).height * .85,
          ),
          child: builder(ctx),
        ),
      ),
    );
  }
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: c.elevated,
    barrierColor: Colors.black.withValues(alpha: .35),
    showDragHandle: true,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.sizeOf(context).height * (expand ? .92 : .85),
    ),
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
      child: builder(ctx),
    ),
  );
}
