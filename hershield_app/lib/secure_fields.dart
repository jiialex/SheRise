import 'package:flutter/material.dart';

import 'i18n.dart';
import 'security/password_policy.dart';
import 'theme.dart';

OutlineInputBorder _border(Color c) => OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: BorderSide(color: c),
);

/// Password field with show/hide, a strength bar and a live rules checklist.
class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
    this.label = 'Password',
    this.personal = const [],
    this.showRules = true,
  });

  final TextEditingController controller;
  final String label;

  /// Values (email, name…) the password must not contain. Read on each rebuild.
  final List<String> personal;
  final bool showRules;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _hidden = true;

  static const _levels = ['Too weak', 'Weak', 'Fair', 'Good', 'Strong'];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (_, lang, _) => ListenableBuilder(
        listenable: widget.controller,
        builder: (_, _) {
          final text = widget.controller.text;
          final c = PasswordPolicy.check(text, personal: widget.personal);
          final score = text.isEmpty ? 0 : c.score;
          final color = score >= 4
              ? C.ok
              : score >= 2
              ? C.warn
              : C.danger;

          Widget rule(bool met, String label) => Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Row(
              children: [
                Icon(
                  met ? Icons.check_circle : Icons.circle_outlined,
                  size: 15,
                  color: met ? C.ok : C.muted,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    trFor(lang, label),
                    style: TextStyle(
                      fontSize: 12,
                      color: met ? C.ok : C.muted,
                    ),
                  ),
                ),
              ],
            ),
          );

          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trFor(lang, widget.label),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: widget.controller,
                  obscureText: _hidden,
                  enableSuggestions: false,
                  autocorrect: false,
                  autofillHints: const [AutofillHints.newPassword],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: _border(C.line),
                    enabledBorder: _border(C.line),
                    focusedBorder: _border(C.primary),
                    suffixIcon: IconButton(
                      tooltip: trFor(lang, _hidden ? 'Show password' : 'Hide password'),
                      icon: Icon(
                        _hidden ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      ),
                      onPressed: () => setState(() => _hidden = !_hidden),
                    ),
                  ),
                ),
                if (widget.showRules) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      for (var i = 1; i <= 4; i++)
                        Expanded(
                          child: Container(
                            height: 5,
                            margin: EdgeInsets.only(right: i < 4 ? 4 : 0),
                            decoration: BoxDecoration(
                              color: i <= score ? color : C.line,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    trFor(lang, _levels[score]),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: text.isEmpty ? C.muted : color,
                    ),
                  ),
                  rule(c.longEnough, 'At least 12 characters'),
                  rule(c.hasUpper && c.hasLower, 'Upper and lower case letters'),
                  rule(c.hasDigit, 'A number'),
                  rule(c.hasSymbol, 'A symbol, like ! or #'),
                  rule(
                    text.isNotEmpty && c.notCommon && c.notPersonal,
                    'Not a common word or your own details',
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Text field that shows a list of matching options as you type.
/// Free text is still allowed, so a name that is not in the list works.
class SuggestField extends StatefulWidget {
  const SuggestField({
    super.key,
    required this.label,
    required this.controller,
    required this.options,
    this.hint,
    this.helper,
    this.maxOptions = 8,
  });

  final String label;
  final TextEditingController controller;
  final List<String> options;
  final String? hint;
  final String? helper;
  final int maxOptions;

  @override
  State<SuggestField> createState() => _SuggestFieldState();
}

class _SuggestFieldState extends State<SuggestField> {
  final _focus = FocusNode();

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  Iterable<String> _match(String q) {
    final query = q.trim().toLowerCase();
    if (query.isEmpty) return widget.options.take(widget.maxOptions);
    final starts = <String>[];
    final contains = <String>[];
    for (final o in widget.options) {
      final l = o.toLowerCase();
      if (l == query) continue; // already fully typed
      if (l.startsWith(query)) {
        starts.add(o);
      } else if (l.contains(query)) {
        contains.add(o);
      }
    }
    return [...starts, ...contains].take(widget.maxOptions);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (_, lang, _) => Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              trFor(lang, widget.label),
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            const SizedBox(height: 6),
            RawAutocomplete<String>(
              textEditingController: widget.controller,
              focusNode: _focus,
              optionsBuilder: (v) => _match(v.text),
              onSelected: (s) => widget.controller.selection =
                  TextSelection.collapsed(offset: s.length),
              fieldViewBuilder: (context, ctrl, focus, onSubmit) => TextField(
                controller: ctrl,
                focusNode: focus,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: widget.hint == null ? null : trFor(lang, widget.hint!),
                  helperText: widget.helper == null ? null : trFor(lang, widget.helper!),
                  helperMaxLines: 3,
                  filled: true,
                  fillColor: Colors.white,
                  border: _border(C.line),
                  enabledBorder: _border(C.line),
                  focusedBorder: _border(C.primary),
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                ),
              ),
              optionsViewBuilder: (context, onSelected, opts) => Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 260,
                      maxWidth: MediaQuery.of(context).size.width > 520
                          ? 480
                          : MediaQuery.of(context).size.width - 40,
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: opts.length,
                      itemBuilder: (_, i) {
                        final o = opts.elementAt(i);
                        return ListTile(
                          dense: true,
                          title: Text(o),
                          onTap: () => onSelected(o),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
