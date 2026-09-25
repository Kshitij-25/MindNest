import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';
import '../utils/context_x.dart';
import 'mn_icon.dart';

/// Text field with optional leading icon and trailing widget (`.field`).
/// Shows the focus ring from the prototype.
class MnTextField extends StatefulWidget {
  const MnTextField({
    super.key,
    this.controller,
    this.hint,
    this.icon,
    this.trailing,
    this.obscure = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.autofillHints,
    this.errorText,
    this.label,
    this.initialValue,
    this.textCapitalization = TextCapitalization.none,
  });

  final TextEditingController? controller;
  final String? hint;
  final MnIconData? icon;
  final Widget? trailing;
  final bool obscure;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool autofocus;
  final int? maxLines;
  final int? minLines;
  final Iterable<String>? autofillHints;
  final String? errorText;
  final String? label;
  final String? initialValue;
  final TextCapitalization textCapitalization;

  @override
  State<MnTextField> createState() => _MnTextFieldState();
}

class _MnTextFieldState extends State<MnTextField> {
  final _focus = FocusNode();
  TextEditingController? _own;

  TextEditingController get _ctrl => widget.controller ?? (_own ??= TextEditingController(text: widget.initialValue));

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focus.dispose();
    _own?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final focused = _focus.hasFocus;
    final hasError = widget.errorText != null;
    final borderColor = hasError ? c.red : (focused ? c.primary : c.hairline);

    final field = AnimatedContainer(
      duration: MnMotion.base,
      curve: MnMotion.ease,
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(MnRadii.sm),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: focused ? MnShadows.ring(c) : const [],
      ),
      constraints: const BoxConstraints(minHeight: 54),
      child: Row(
        crossAxisAlignment: widget.maxLines == 1 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          if (widget.icon != null)
            Padding(
              padding: EdgeInsets.only(left: 15, top: widget.maxLines == 1 ? 0 : 16),
              child: MnIcon(widget.icon!, size: 20, stroke: 1.9, color: c.ink3),
            ),
          Expanded(
            child: TextField(
              controller: _ctrl,
              focusNode: _focus,
              obscureText: widget.obscure,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              autofocus: widget.autofocus,
              maxLines: widget.obscure ? 1 : widget.maxLines,
              minLines: widget.minLines,
              autofillHints: widget.autofillHints,
              textCapitalization: widget.textCapitalization,
              style: context.text.body.copyWith(color: c.ink, height: 1.35),
              cursorColor: c.primary,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: widget.hint,
                hintStyle: context.text.body.copyWith(color: c.ink4, height: 1.35),
                contentPadding: EdgeInsets.fromLTRB(widget.icon != null ? 12 : 16, 16, widget.trailing != null ? 4 : 16, 16),
              ),
            ),
          ),
          if (widget.trailing != null) Padding(padding: const EdgeInsets.only(right: 8), child: widget.trailing),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(widget.label!, style: context.text.foot.copyWith(color: c.ink2, fontWeight: FontWeight.w600)),
          ),
        ],
        field,
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 6),
            child: Text(widget.errorText!, style: context.text.foot.copyWith(color: c.red)),
          ),
      ],
    );
  }
}

/// Search field (`.tb-search` / discover search).
class MnSearchField extends StatelessWidget {
  const MnSearchField({super.key, this.hint = 'Search', this.onChanged, this.controller, this.trailing, this.onTap, this.readOnly = false});

  final String hint;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      height: 46,
      padding: const EdgeInsets.only(left: 14, right: 6),
      decoration: BoxDecoration(color: c.fill, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          MnIcon(MnIcons.search, size: 19, color: c.ink3),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onTap: onTap,
              readOnly: readOnly,
              style: context.text.callout.copyWith(color: c.ink),
              cursorColor: c.primary,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: context.text.callout.copyWith(color: c.ink3),
              ),
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}
