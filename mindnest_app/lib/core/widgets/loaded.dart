import 'package:flutter/widgets.dart';
import 'package:mindnest_app/core/theme/text.dart';
import 'package:mindnest_app/core/theme/tokens.dart';
import 'package:mindnest_app/core/widgets/common.dart';
import 'package:mindnest_app/core/widgets/controls.dart';
import 'package:mindnest_app/core/widgets/icon.dart';
import 'package:mindnest_app/core/widgets/nav.dart';
import 'package:mindnest_app/shared/widgets/app_loader.dart';

/// Async data gate — backend only, no sample fallback. Fires [fetch] once and
/// renders one of four states:
///
///  • loading  → a centered loader
///  • error    → a message + Retry
///  • empty    → an [EmptyState] (when [isEmpty] returns true)
///  • data     → [builder]
///
/// For pushed screens pass [title]: the loading/error/empty states are then
/// wrapped in a page with a back button so the user is never stranded. The
/// success [builder] supplies its own page chrome.
class Loaded<T> extends StatefulWidget {
  const Loaded({
    super.key,
    required this.fetch,
    required this.builder,
    this.title,
    this.isEmpty,
    this.emptyIcon = 'sparkle',
    this.emptyTitle = 'Nothing here yet',
    this.emptyBody = 'This will fill in as you use MindNest.',
  });

  final Future<T> Function() fetch;
  final Widget Function(BuildContext context, T data) builder;

  /// When set, non-data states render inside a titled page (with back button).
  final String? title;
  final bool Function(T data)? isEmpty;
  final String emptyIcon, emptyTitle, emptyBody;

  @override
  State<Loaded<T>> createState() => _LoadedState<T>();
}

enum _S { loading, error, data }

class _LoadedState<T> extends State<Loaded<T>> {
  _S _status = _S.loading;
  T? _data;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _status = _S.loading);
    try {
      final result = await widget.fetch();
      if (!mounted) return;
      setState(() {
        _data = result;
        _status = _S.data;
      });
    } catch (_) {
      if (mounted) setState(() => _status = _S.error);
    }
  }

  /// Wraps a non-data state in page chrome when [title] is set.
  Widget _chrome(Widget child) {
    if (widget.title == null) return Center(child: child);
    return MnScaffold(
      child: Column(
        children: [
          SizedBox(height: safeTop(context)),
          NavHeader(title: widget.title, onBack: () => Navigator.of(context).maybePop()),
          Expanded(child: Center(child: child)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (_status) {
      case _S.loading:
        return _chrome(const AppLoader());
      case _S.error:
        return _chrome(_ErrorRetry(onRetry: _load));
      case _S.data:
        final data = _data as T;
        if (widget.isEmpty?.call(data) ?? false) {
          return _chrome(
            EmptyState(
              icon: widget.emptyIcon,
              title: widget.emptyTitle,
              body: widget.emptyBody,
            ),
          );
        }
        return widget.builder(context, data);
    }
  }
}

class _ErrorRetry extends StatelessWidget {
  const _ErrorRetry({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(color: c.fill, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: MnIcon('info', size: 36, color: c.ink4, stroke: 1.7),
          ),
          const SizedBox(height: 18),
          Text('Couldn’t load this', style: MnText.title3.copyWith(color: c.ink)),
          const SizedBox(height: 6),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 280),
            child: Text(
              'Check your connection and try again.',
              textAlign: TextAlign.center,
              style: MnText.body.copyWith(color: c.ink2),
            ),
          ),
          const SizedBox(height: 22),
          MnButton(
            label: 'Retry',
            variant: MnVariant.tonal,
            expand: false,
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}
