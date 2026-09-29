import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// Public web and support addresses. Override per build with `--dart-define`.
abstract final class LinkConfig {
  static const webBaseUrl = String.fromEnvironment('WEB_BASE_URL', defaultValue: 'https://mindnest.app');
  static const supportEmail = String.fromEnvironment('SUPPORT_EMAIL', defaultValue: 'support@mindnest.app');

  static Uri get helpCentre => Uri.parse('$webBaseUrl/help');
  static Uri post(String id) => Uri.parse('$webBaseUrl/posts/$id');
}

abstract final class ExternalLinks {
  /// Opens [uri] in the in-app browser (or the mail app for `mailto:`),
  /// showing a snackbar if nothing can handle it.
  static Future<void> open(BuildContext context, Uri uri) async {
    final messenger = ScaffoldMessenger.of(context);
    final mode = uri.scheme.startsWith('http') ? LaunchMode.inAppBrowserView : LaunchMode.externalApplication;
    var ok = false;
    try {
      ok = await launchUrl(uri, mode: mode);
    } catch (_) {}
    if (!ok) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(switch (uri.scheme) {
            'mailto' => 'No email app found. Write to ${uri.path}',
            'tel' => 'Can’t place calls on this device. Dial ${uri.path}',
            _ => 'Couldn\'t open $uri',
          }),
        ),
      );
    }
  }

  static Future<void> email(BuildContext context, {required String subject, String body = ''}) => open(
    context,
    Uri(
      scheme: 'mailto',
      path: LinkConfig.supportEmail,
      query: 'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
    ),
  );

  /// Opens the system share sheet. [context] anchors the popover on iPad.
  static Future<void> share(BuildContext context, {required String text, String? subject, Uri? uri}) {
    final box = context.findRenderObject() as RenderBox?;
    return SharePlus.instance.share(
      ShareParams(
        text: uri == null ? text : '$text\n$uri',
        subject: subject,
        sharePositionOrigin: box == null ? null : box.localToGlobal(Offset.zero) & box.size,
      ),
    );
  }
}
