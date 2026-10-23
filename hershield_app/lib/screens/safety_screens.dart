import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config.dart';
import '../data/models.dart';
import '../state.dart';
import '../theme.dart';
import '../widgets.dart';

Future<void> _editContact(
    BuildContext context, WidgetRef ref, TrustedContact? existing) async {
  final name = TextEditingController(text: existing?.name ?? '');
  final relation = TextEditingController(text: existing?.relation ?? '');
  final phone = TextEditingController(text: existing?.phone ?? '');

  await showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Trusted contact'),
      content: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(
              controller: name,
              decoration: const InputDecoration(labelText: 'Name')),
          TextField(
              controller: relation,
              decoration:
                  const InputDecoration(labelText: 'Relationship (e.g. sister)')),
          TextField(
              controller: phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Phone number')),
          const SizedBox(height: 8),
          const Text('Stored only on this device.',
              style: TextStyle(fontSize: 12, color: C.muted)),
        ]),
      ),
      actions: [
        if (existing != null)
          TextButton(
              onPressed: () {
                ref.read(contactProvider.notifier).set(null);
                Navigator.pop(ctx);
              },
              child: const Text('Remove')),
        TextButton(
            onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        FilledButton(
            onPressed: () {
              if (name.text.trim().isEmpty || phone.text.trim().isEmpty) return;
              ref.read(contactProvider.notifier).set(TrustedContact(
                    name: name.text.trim(),
                    relation: relation.text.trim(),
                    phone: phone.text.trim(),
                  ));
              Navigator.pop(ctx);
            },
            child: const Text('Save')),
      ],
    ),
  );
  name.dispose();
  relation.dispose();
  phone.dispose();
}

class SafetyCenterScreen extends ConsumerWidget {
  const SafetyCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contact = ref.watch(contactProvider);

    return PageBody(
      showBack: true,
      quickExit: true,
      stepLabel: '14 / SAFETY',
      title: 'Safety Center',
      children: [
        AppCard(
          child: Row(children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: C.dangerBg, borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.shield_outlined, color: C.danger),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Take one safe step.',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                Text('No automatic alerts or dispatch.',
                    style: TextStyle(color: C.muted, fontSize: 12)),
              ]),
            ),
          ]),
        ),
        const InfoBox(
          tone: Tone.danger,
          icon: Icons.warning_amber_rounded,
          title: 'If you are in immediate danger, move to a safer place if possible',
          text:
              'Do not rely on SheRise in an emergency. Use a known local emergency resource or reach someone you trust another way.',
        ),
        const SectionTitle('Emergency resources'),
        AppCard(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (AppConfig.emergencyContacts.isEmpty) ...[
              const Pill('Verification required before launch',
                  bg: C.warnBg, fg: C.warn),
              const SizedBox(height: 10),
              const Text('Local emergency call',
                  style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              const Text(
                  'No verified emergency number is configured yet. Confirm current local resources before relying on this screen.',
                  style: TextStyle(fontSize: 13, color: C.muted, height: 1.4)),
              const SizedBox(height: 12),
              const SecondaryButton(
                  label: 'Emergency call · not configured', onPressed: null),
            ] else
              for (final e in AppConfig.emergencyContacts)
                PrimaryButton(
                  label: 'Call ${e.label} · ${e.number}',
                  icon: Icons.call,
                  onPressed: () => launchUrl(Uri.parse('tel:${e.number}')),
                ),
            const Text('Calls only start when you tap. Nothing is dialed automatically.',
                style: TextStyle(fontSize: 12, color: C.muted)),
          ]),
        ),
        SectionTitle('Reach someone you trust',
            actionLabel: 'Manage',
            onAction: () => _editContact(context, ref, contact)),
        if (contact == null)
          AppCard(
            child: Column(children: [
              const Text('No trusted contact yet.',
                  style: TextStyle(color: C.muted)),
              const SizedBox(height: 8),
              OutlinedButton(
                  onPressed: () => _editContact(context, ref, null),
                  child: const Text('Add a trusted contact')),
            ]),
          )
        else
          AppCard(
            child: Column(children: [
              Row(children: [
                CircleAvatar(
                    backgroundColor: C.tint,
                    child: Text(contact.name[0].toUpperCase(),
                        style: const TextStyle(color: C.primary))),
                const SizedBox(width: 12),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                      contact.relation.isEmpty
                          ? contact.name
                          : '${contact.name} — ${contact.relation}',
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                  Text('Contact • ${contact.masked}',
                      style: const TextStyle(fontSize: 12, color: C.muted)),
                ]),
              ]),
              const SizedBox(height: 12),
              SecondaryButton(
                  label: 'Review message & sharing',
                  icon: Icons.chat_bubble_outline,
                  onPressed: () => context.push('/home/safety/share')),
            ]),
          ),
        AppCard(
          child: Row(children: [
            const Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Share my location',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                Text('Not available in this version',
                    style: TextStyle(fontSize: 12, color: C.muted)),
              ]),
            ),
            Switch(value: false, onChanged: null),
          ]),
        ),
        const SectionTitle('Planning ahead'),
        AppCard(
          onTap: () => context.push('/home/safety/plan'),
          child: const Row(children: [
            Icon(Icons.checklist, color: C.primary),
            SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('My safety plan',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                Text('A simple checklist, kept on this device',
                    style: TextStyle(fontSize: 12, color: C.muted)),
              ]),
            ),
            Icon(Icons.chevron_right, color: C.muted),
          ]),
        ),
        const SectionTitle('While you find support'),
        AppCard(
          child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('• Move to a public or safer place if possible.'),
            SizedBox(height: 8),
            Text('• Contact a trusted person using a safe device.'),
            SizedBox(height: 8),
            Text('• If a message fails, use another way to reach help.'),
          ]),
        ),
        const Text('SheRise does not automatically contact emergency services.',
            style: TextStyle(fontSize: 12, color: C.muted)),
      ],
    );
  }
}

class ReviewSharingScreen extends ConsumerStatefulWidget {
  const ReviewSharingScreen({super.key});

  @override
  ConsumerState<ReviewSharingScreen> createState() =>
      _ReviewSharingScreenState();
}

class _ReviewSharingScreenState extends ConsumerState<ReviewSharingScreen> {
  final _message = TextEditingController(
      text: 'Please contact me when you can. I would like support.');
  bool _reviewed = false;

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  Future<void> _share(TrustedContact c) async {
    final number = c.phone.replaceAll(' ', '');
    final uri =
        Uri.parse('sms:$number?body=${Uri.encodeComponent(_message.text)}');
    try {
      final ok = await launchUrl(uri);
      if (!ok && mounted) {
        snack(context, 'Could not open your messaging app. Try another way.');
      }
    } catch (_) {
      if (mounted) {
        snack(context, 'Could not open your messaging app. Try another way.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final contact = ref.watch(contactProvider);

    return PageBody(
      showBack: true,
      quickExit: true,
      fallback: '/home/safety',
      stepLabel: '15 / SAFETY',
      title: 'Review before sharing',
      subtitle:
          'Choose what to share with your trusted contact. Nothing is sent until you press send in your messaging app.',
      children: [
        if (contact == null)
          StateView(
            icon: Icons.person_add_alt,
            title: 'Add a trusted contact first',
            message: 'Go back to the Safety Center to add someone you trust.',
            actionLabel: 'Back to Safety Center',
            onAction: () => context.pop(),
          )
        else ...[
          AppCard(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                  contact.relation.isEmpty
                      ? contact.name
                      : '${contact.name} — ${contact.relation}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 17)),
              const SizedBox(height: 4),
              Text('Masked contact • ${contact.masked}',
                  style: const TextStyle(color: C.muted, fontSize: 13)),
              const SizedBox(height: 6),
              const Text('Check this is the right person before continuing.',
                  style: TextStyle(fontSize: 12, color: C.muted)),
            ]),
          ),
          LabeledField(
              label: 'Message preview', controller: _message, maxLines: 4),
          const InfoBox(
            icon: Icons.location_off_outlined,
            title: 'Location is not included',
            text:
                'Only this message is shared. No location is read, attached or sent.',
          ),
          CheckboxListTile(
            value: _reviewed,
            onChanged: (v) => setState(() => _reviewed = v ?? false),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            title: const Text(
                'I have reviewed the recipient and message and choose to share only these details.',
                style: TextStyle(fontSize: 13)),
          ),
          const SizedBox(height: 8),
          PrimaryButton(
              label: 'Review, then share',
              icon: Icons.send,
              onPressed: _reviewed ? () => _share(contact) : null),
          const Text(
              'Delivery stays unconfirmed. SheRise cannot tell whether the message arrived.',
              style: TextStyle(fontSize: 12, color: C.muted)),
        ],
      ],
    );
  }
}

class SafetyPlanScreen extends ConsumerWidget {
  const SafetyPlanScreen({super.key});

  static const _items = [
    'I know a safe place I can go to',
    'I have a trusted person I can contact',
    'Important documents and ID are somewhere I can reach',
    'My phone is charged and I can reach some money',
    'I have a code word to use with someone I trust',
    'I know how to reach local support services',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final done = ref.watch(planProvider);

    return PageBody(
      showBack: true,
      quickExit: true,
      fallback: '/home/safety',
      title: 'My safety plan',
      subtitle:
          'A general checklist to think through. Tick what is already in place.',
      children: [
        for (final item in _items)
          AppCard(
            bottom: 8,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: CheckboxListTile(
              value: done.contains(item),
              onChanged: (_) => ref.read(planProvider.notifier).toggle(item),
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(item, style: const TextStyle(fontSize: 14)),
            ),
          ),
        const SizedBox(height: 8),
        const InfoBox(
          icon: Icons.info_outline,
          title: 'This is general guidance',
          text:
              'Your situation is unique. A trained gender-based-violence or counseling service can help you build a plan that fits your safety.',
        ),
      ],
    );
  }
}
