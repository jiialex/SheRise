import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../data/app_database.dart';
import '../data/models.dart';
import '../theme.dart';
import '../widgets.dart';

class InstitutionCaseDetailScreen extends StatefulWidget {
  const InstitutionCaseDetailScreen({super.key, required this.code});
  final String code;

  @override
  State<InstitutionCaseDetailScreen> createState() =>
      _InstitutionCaseDetailScreenState();
}

class _InstitutionCaseDetailScreenState
    extends State<InstitutionCaseDetailScreen> {
  final _messageController = TextEditingController();
  final _internalNoteController = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _messageController.dispose();
    _internalNoteController.dispose();
    super.dispose();
  }

  // Workflow 1: Status Change Dialog
  void _openStatusDialog(DeliveredReport report) {
    String chosenStatus = report.status;
    final staffNoteCtrl = TextEditingController();
    final reporterMsgCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.sync_alt, color: C.primary),
              SizedBox(width: 8),
              Tx(
                'Update Case Status',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Tx(
                  'Select New Workflow Status:',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: C.muted,
                  ),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: chosenStatus,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: C.tint.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'received',
                      child: Tx('Received / Intake'),
                    ),
                    DropdownMenuItem(
                      value: 'under_review',
                      child: Tx('Under Active Review'),
                    ),
                    DropdownMenuItem(
                      value: 'referred',
                      child: Tx('Referred to Partner'),
                    ),
                    DropdownMenuItem(
                      value: 'resolved',
                      child: Tx('Resolved / Action Taken'),
                    ),
                    DropdownMenuItem(value: 'closed', child: Tx('Closed')),
                  ],
                  onChanged: (v) {
                    if (v != null) setModalState(() => chosenStatus = v);
                  },
                ),
                const SizedBox(height: 14),
                const Tx(
                  'Internal Staff Audit Note:',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: C.muted,
                  ),
                ),
                const SizedBox(height: 4),
                TxTextField(
                  controller: staffNoteCtrl,
                  decoration: InputDecoration(
                    hintText: 'e.g. Assigned to disciplinary panel...',
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 14),
                const Tx(
                  'Send Update Message to Reporter (Optional):',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: C.muted,
                  ),
                ),
                const SizedBox(height: 4),
                TxTextField(
                  controller: reporterMsgCtrl,
                  decoration: InputDecoration(
                    hintText:
                        'e.g. Your case has been escalated to senior review...',
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Tx('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                await AppDatabase.instance.updateStatus(
                  report.code,
                  chosenStatus,
                  staffNote: staffNoteCtrl.text.trim().isNotEmpty
                      ? staffNoteCtrl.text.trim()
                      : null,
                  messageToReporter: reporterMsgCtrl.text.trim().isNotEmpty
                      ? reporterMsgCtrl.text.trim()
                      : null,
                );
                if (ctx.mounted) Navigator.pop(ctx);
                if (mounted) {
                  setState(() {});
                  snack(context, 'Status updated to $chosenStatus');
                }
              },
              child: const Tx('Save Status'),
            ),
          ],
        ),
      ),
    );
  }

  // Workflow 2: Assign Officer Dialog
  void _openAssignDialog(DeliveredReport report) {
    final officers = [
      ('Officer Almaz Tadesse', 'Ethics & Gender Directorate'),
      ('Dawit Mengistu', 'Legal Advocacy Unit'),
      ('Dr. Helen Berhanu', 'Psychological Counseling Unit'),
      ('Tigist Abebe', 'Student Affairs Committee'),
      ('Inspector Yohannes G.', 'Campus Security Liaison'),
    ];

    String chosenName = report.assignedOfficer ?? officers.first.$1;
    String chosenDept = report.assignedDepartment ?? officers.first.$2;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.assignment_ind_outlined, color: C.primary),
              SizedBox(width: 8),
              Tx(
                'Assign Case Officer',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Tx(
                'Select Designated Reviewer:',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: C.muted,
                ),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: chosenName,
                isExpanded: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: C.tint.withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: officers.map((o) {
                  return DropdownMenuItem(
                    value: o.$1,
                    child: Tx(
                      '${o.$1} (${o.$2})',
                      style: const TextStyle(fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  if (v != null) {
                    final match = officers.firstWhere((o) => o.$1 == v);
                    setModalState(() {
                      chosenName = match.$1;
                      chosenDept = match.$2;
                    });
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Tx('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                await AppDatabase.instance.assignOfficer(
                  report.code,
                  chosenName,
                  chosenDept,
                );
                if (ctx.mounted) Navigator.pop(ctx);
                if (mounted) {
                  setState(() {});
                  snack(context, 'Assigned to $chosenName');
                }
              },
              child: const Tx('Assign Officer'),
            ),
          ],
        ),
      ),
    );
  }

  // Workflow 3: Urgency Priority Dialog
  void _openPriorityDialog(DeliveredReport report) {
    String chosen = report.priority;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => AlertDialog(
          title: const Tx('Set Case Urgency / Priority'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Tx(
                  'URGENT (Immediate Danger / Safety Risk)',
                  style: TextStyle(
                    color: C.danger,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: 'urgent',
                groupValue: chosen,
                onChanged: (v) => setModalState(() => chosen = v!),
              ),
              RadioListTile<String>(
                title: const Tx(
                  'HIGH (Retaliation Threat / Severe Harassment)',
                  style: TextStyle(
                    color: Color(0xFFC05621),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: 'high',
                groupValue: chosen,
                onChanged: (v) => setModalState(() => chosen = v!),
              ),
              RadioListTile<String>(
                title: const Tx('MEDIUM (General Concern / Policy Breach)'),
                value: 'medium',
                groupValue: chosen,
                onChanged: (v) => setModalState(() => chosen = v!),
              ),
              RadioListTile<String>(
                title: const Tx('LOW (Informational / Inquiry)'),
                value: 'low',
                groupValue: chosen,
                onChanged: (v) => setModalState(() => chosen = v!),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Tx('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                await AppDatabase.instance.updatePriority(report.code, chosen);
                if (ctx.mounted) Navigator.pop(ctx);
                if (mounted) {
                  setState(() {});
                  snack(context, 'Priority updated to ${chosen.toUpperCase()}');
                }
              },
              child: const Tx('Save Priority'),
            ),
          ],
        ),
      ),
    );
  }

  // Workflow 4: External Referral Dialog
  void _openReferralDialog(DeliveredReport report) {
    final partners = [
      (
        'Ethiopian Women Lawyers Association (EWLA)',
        'Advocate Selamawit Bekele',
        '+251 11 550 7711',
      ),
      ('Red Cross Emergency & GBV Shelter', 'Sister Martha Worku', '907'),
      (
        'St. Paul Hospital GBV Clinical Unit',
        'Dr. Tsion Haile',
        '+251 11 275 0125',
      ),
      (
        'National Human Rights Commission (GBV Desk)',
        'Ato Daniel Tefera',
        '7711',
      ),
    ];

    var selectedPartner = partners.first;
    final notesCtrl = TextEditingController(
      text: 'Case referred for specialized external intervention.',
    );

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.handshake_outlined, color: Colors.purple),
              SizedBox(width: 8),
              Tx(
                'Refer Case to Partner',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Tx(
                  'Select Partner Organization:',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: C.muted,
                  ),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<int>(
                  value: 0,
                  isExpanded: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: C.tint.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: List.generate(partners.length, (i) {
                    return DropdownMenuItem(
                      value: i,
                      child: Tx(
                        partners[i].$1,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }),
                  onChanged: (idx) {
                    if (idx != null) {
                      setModalState(() => selectedPartner = partners[idx]);
                    }
                  },
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TxParts(
                        ['Contact:', selectedPartner.$2],
                        separator: ' ',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      TxParts(
                        ['Phone:', selectedPartner.$3],
                        separator: ' ',
                        style: const TextStyle(color: C.muted, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Tx(
                  'Referral Notes & Specific Instructions:',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: C.muted,
                  ),
                ),
                const SizedBox(height: 4),
                TxTextField(
                  controller: notesCtrl,
                  decoration: InputDecoration(
                    hintText: 'e.g. Reporter requests confidential legal representation...',
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Tx('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                final ref = CaseReferral(
                  partnerName: selectedPartner.$1,
                  contactPerson: selectedPartner.$2,
                  phone: selectedPartner.$3,
                  notes: notesCtrl.text.trim(),
                  referredAt: DateTime.now(),
                  status: 'in_progress',
                );
                await AppDatabase.instance.referCase(report.code, ref);
                if (ctx.mounted) Navigator.pop(ctx);
                if (mounted) {
                  setState(() {});
                  snack(context, 'Referred to ${selectedPartner.$1}');
                }
              },
              child: const Tx('Submit Referral'),
            ),
          ],
        ),
      ),
    );
  }

  // Workflow 5: Case Resolution Dialog
  void _openResolutionDialog(DeliveredReport report) {
    final outcomes = [
      'Disciplinary Reprimand & Sanctions Issued',
      'Restraining Order / Protective Reassignment',
      'Mandatory Harassment Retraining & Probation',
      'Mediation & Formal Resolution Agreement',
      'Safe Relocation / Emergency Housing Support Provided',
    ];

    String chosenOutcome = outcomes.first;
    final summaryCtrl = TextEditingController(
      text: 'Investigation concluded with substantiated evidence.',
    );
    final actionCtrl = TextEditingController(
      text: 'Administrative protective sanctions enacted; monitoring active.',
    );

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.verified_outlined, color: C.ok),
              SizedBox(width: 8),
              Tx(
                'Resolve & Conclude Case',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Tx(
                  'Outcome Classification:',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: C.muted,
                  ),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: chosenOutcome,
                  isExpanded: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: C.tint.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: outcomes.map((o) {
                    return DropdownMenuItem(
                      value: o,
                      child: Tx(
                        o,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (v) {
                    if (v != null) setModalState(() => chosenOutcome = v);
                  },
                ),
                const SizedBox(height: 12),
                const Tx(
                  'Resolution Summary:',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: C.muted,
                  ),
                ),
                const SizedBox(height: 4),
                TxTextField(
                  controller: summaryCtrl,
                  decoration: InputDecoration(
                    hintText: 'Summary of findings and hearings...',
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 12),
                const Tx(
                  'Specific Actions Enacted:',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: C.muted,
                  ),
                ),
                const SizedBox(height: 4),
                TxTextField(
                  controller: actionCtrl,
                  decoration: InputDecoration(
                    hintText: 'Action taken to protect reporter...',
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Tx('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: C.ok),
              onPressed: () async {
                final res = CaseResolution(
                  outcome: chosenOutcome,
                  summary: summaryCtrl.text.trim(),
                  actionTaken: actionCtrl.text.trim(),
                  resolvedBy: AppDatabase.instance.currentStaffName,
                  resolvedAt: DateTime.now(),
                );
                await AppDatabase.instance.resolveCase(report.code, res);
                if (ctx.mounted) Navigator.pop(ctx);
                if (mounted) {
                  setState(() {});
                  snack(context, 'Case resolved: $chosenOutcome');
                }
              },
              child: const Tx('Confirm Resolution'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendMessage(DeliveredReport report) async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() => _sending = true);
    try {
      await AppDatabase.instance.addStaffMessage(report.code, text);
      _messageController.clear();
      if (mounted) {
        setState(() => _sending = false);
        snack(context, 'Message delivered to reporter.');
      }
    } catch (_) {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _addInternalNote(DeliveredReport report) async {
    final text = _internalNoteController.text.trim();
    if (text.isEmpty) return;

    await AppDatabase.instance.addInternalNote(report.code, text);
    _internalNoteController.clear();
    if (mounted) {
      setState(() {});
      snack(context, 'Confidential note logged.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final report = AppDatabase.instance.findByCode(widget.code);

    if (report == null) {
      return Scaffold(
        appBar: AppBar(title: const Tx('Case Not Found')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.search_off, size: 60, color: C.muted),
              const SizedBox(height: 12),
              TxParts(
                ['No report found with code', '"${widget.code}".'],
                separator: ' ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              PrimaryButton(
                label: 'Back to Board',
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: C.bg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: C.ink),
          tooltip: 'Back to Institution Board',
          onPressed: () => context.canPop()
              ? context.pop()
              : context.go('/institution/dashboard'),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Tx(
                  report.code,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 6),
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: report.code));
                    snack(context, 'Copied code ${report.code}');
                  },
                  child: const Icon(Icons.copy, size: 14, color: C.muted),
                ),
              ],
            ),
            Tx(
              report.category,
              style: const TextStyle(fontSize: 12, color: C.muted),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Share / Export Case File',
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              snack(context, 'Case export ready for confidential hearing.');
            },
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
            children: [
              // Top Navigation Back Button Row
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: [
                    TextButton.icon(
                      onPressed: () => context.canPop()
                          ? context.pop()
                          : context.go('/institution/dashboard'),
                      icon: const Icon(Icons.arrow_back, size: 18),
                      label: const Tx('Back to Institution Board'),
                      style: TextButton.styleFrom(
                        foregroundColor: C.primary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Case Status Header Card
              AppCard(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _statusBadge(report.status),
                        const SizedBox(width: 8),
                        _priorityBadge(report.priority),
                        const Spacer(),
                        Tx(
                          DateFormat('d MMM yyyy, HH:mm')
                              .format(report.createdAt),
                          style: const TextStyle(color: C.muted, fontSize: 12),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    Row(
                      children: [
                        const Icon(
                          Icons.business_outlined,
                          size: 16,
                          color: C.primary,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Tx(
                            report.institutionName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.badge_outlined,
                          size: 16,
                          color: C.muted,
                        ),
                        const SizedBox(width: 6),
                        Tx(
                          report.assignedOfficer != null
                              ? 'Assigned: ${report.assignedOfficer} (${report.assignedDepartment ?? "Staff"})'
                              : 'Status: Unassigned Case',
                          style: TextStyle(
                            fontSize: 12,
                            color: report.assignedOfficer != null
                                ? C.ink
                                : Colors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Institutional Workflow Actions Panel
              const SectionTitle('Workflow Actions'),
              AppCard(
                color: C.tint.withOpacity(0.4),
                border: C.tintBorder,
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Tx(
                      'Case Officer Controls:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: C.primary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => _openStatusDialog(report),
                          icon: const Icon(Icons.sync_alt, size: 16),
                          label: const Tx('Update Status'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: C.primary,
                            elevation: 0,
                            side: const BorderSide(color: C.tintBorder),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _openAssignDialog(report),
                          icon: const Icon(
                            Icons.assignment_ind_outlined,
                            size: 16,
                          ),
                          label: const Tx('Assign Officer'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: C.primary,
                            elevation: 0,
                            side: const BorderSide(color: C.tintBorder),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _openPriorityDialog(report),
                          icon: const Icon(Icons.flag_outlined, size: 16),
                          label: const Tx('Set Urgency'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: C.primary,
                            elevation: 0,
                            side: const BorderSide(color: C.tintBorder),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _openReferralDialog(report),
                          icon: const Icon(Icons.handshake_outlined, size: 16),
                          label: const Tx('Refer to Partner'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.purple,
                            elevation: 0,
                            side: const BorderSide(color: Color(0xFFE9D5FF)),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _openResolutionDialog(report),
                          icon: const Icon(Icons.verified_outlined, size: 16),
                          label: const Tx('Resolve Case'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: C.ok,
                            foregroundColor: Colors.white,
                            elevation: 0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Active External Referral Banner (if referred)
              if (report.referral != null) ...[
                const SectionTitle('External Partner Referral'),
                AppCard(
                  color: const Color(0xFFFAF5FF),
                  border: const Color(0xFFE9D5FF),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.handshake,
                            color: Colors.purple,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Tx(
                              report.referral!.partnerName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const Pill(
                            'In Progress',
                            bg: Color(0xFFE9D5FF),
                            fg: Colors.purple,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TxParts(
                        [
                          'Contact:',
                          report.referral!.contactPerson,
                          '·',
                          'Phone:',
                          report.referral!.phone,
                        ],
                        separator: ' ',
                        style: const TextStyle(fontSize: 12, color: C.muted),
                      ),
                      const SizedBox(height: 6),
                      TxParts(
                        ['Notes:', report.referral!.notes],
                        separator: ' ',
                        style: const TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TxParts(
                        [
                          'Referred on',
                          DateFormat('d MMM yyyy, HH:mm')
                              .format(report.referral!.referredAt),
                        ],
                        separator: ': ',
                        style: const TextStyle(fontSize: 11, color: C.muted),
                      ),
                    ],
                  ),
                ),
              ],

              // Formal Resolution Record (if resolved)
              if (report.resolution != null) ...[
                const SectionTitle('Formal Case Resolution'),
                AppCard(
                  color: C.okBg,
                  border: const Color(0xFFBFE3CC),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.verified, color: C.ok, size: 22),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Tx(
                              report.resolution!.outcome,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: C.ok,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TxParts(
                        ['Summary', report.resolution!.summary],
                        separator: ': ',
                        style: const TextStyle(fontSize: 13, height: 1.3),
                      ),
                      const SizedBox(height: 6),
                      TxParts(
                        ['Action Taken:', report.resolution!.actionTaken],
                        separator: ' ',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Divider(height: 16),
                      TxParts(
                        [
                          'Closed by',
                          report.resolution!.resolvedBy,
                          DateFormat('d MMM yyyy, HH:mm')
                              .format(report.resolution!.resolvedAt),
                        ],
                        separator: ' · ',
                        style: const TextStyle(fontSize: 11, color: C.muted),
                      ),
                    ],
                  ),
                ),
              ],

              // Incident Details Section
              const SectionTitle('Incident Dossier'),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          size: 16,
                          color: C.primary,
                        ),
                        const SizedBox(width: 6),
                        const Tx(
                          'Confidentiality:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 6),
                        if (report.anonymous)
                          const Pill(
                            'Anonymous (Identity Protected)',
                            bg: Color(0xFFF1F5F9),
                          )
                        else
                          PillParts(
                            ['Confidential:', report.reporterName ?? 'User'],
                            separator: ' ',
                            bg: C.tint,
                            fg: C.primary,
                          ),
                      ],
                    ),
                    if (!report.anonymous &&
                        report.reporterContact != null) ...[
                      const SizedBox(height: 4),
                      TxParts(
                        ['Contact:', report.reporterContact!],
                        separator: ' ',
                        style: const TextStyle(fontSize: 12, color: C.muted),
                      ),
                    ],
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.place_outlined,
                          size: 16,
                          color: C.muted,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: TxParts(
                            ['Location', report.location],
                            separator: ': ',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (report.incidentDate != null) ...[
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 15,
                            color: C.muted,
                          ),
                          const SizedBox(width: 6),
                          TxParts(
                            [
                              'Incident Date',
                              DateFormat('d MMMM yyyy')
                                  .format(report.incidentDate!),
                            ],
                            separator: ': ',
                            style: const TextStyle(
                              fontSize: 12,
                              color: C.muted,
                            ),
                          ),
                        ],
                      ),
                    ],
                    const Divider(height: 20),
                    const Tx(
                      'Incident Statement:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    SelectableText(
                      report.description,
                      style: const TextStyle(fontSize: 14, height: 1.45),
                    ),
                  ],
                ),
              ),

              // Attached Evidence Section
              const SectionTitle('Submitted Evidence'),
              if (report.attachments.isEmpty)
                const AppCard(
                  child: Row(
                    children: [
                      Icon(Icons.attachment, color: C.muted),
                      SizedBox(width: 10),
                      Tx(
                        'No physical files or voice recordings attached.',
                        style: TextStyle(color: C.muted, fontSize: 13),
                      ),
                    ],
                  ),
                )
              else
                ...report.attachments.map(
                  (att) => _EvidenceItem(attachment: att),
                ),

              // Two-Way Secure Communication Thread
              const SectionTitle('Secure Communication with Reporter'),
              AppCard(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Tx(
                      'Messages sent here appear immediately on the reporter\'s private case tracker.',
                      style: TextStyle(fontSize: 12, color: C.muted),
                    ),
                    const SizedBox(height: 12),
                    if (report.messages.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Tx(
                          'No messages sent yet.',
                          style: TextStyle(color: C.muted, fontSize: 13),
                        ),
                      )
                    else
                      ...report.messages.map((m) => _MessageBubble(message: m)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TxTextField(
                            controller: _messageController,
                            decoration: InputDecoration(
                              hintText: 'Type official response / inquiry...',
                              hintStyle: const TextStyle(fontSize: 13),
                              filled: true,
                              fillColor: Colors.grey.shade50,
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            maxLines: 2,
                            minLines: 1,
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton.filled(
                          onPressed: _sending
                              ? null
                              : () => _sendMessage(report),
                          icon: _sending
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.send, size: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Confidential Internal Staff Notes (Staff Eyes Only)
              const SectionTitle(
                'Confidential Case Assessment Notes (Staff Only)',
              ),
              AppCard(
                color: const Color(0xFFFFFBEB),
                border: const Color(0xFFFDE68A),
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.lock, size: 16, color: Color(0xFFB45309)),
                        SizedBox(width: 6),
                        Tx(
                          'Internal Reviewer Notes - Never visible to reporter',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB45309),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (report.internalNotes.isEmpty)
                      const Tx(
                        'No internal assessment notes recorded.',
                        style: TextStyle(color: C.muted, fontSize: 13),
                      )
                    else
                      ...report.internalNotes.map(
                        (n) => Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFFDE68A)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Tx(
                                    n.author,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Tx(
                                    DateFormat('d MMM, HH:mm')
                                        .format(n.createdAt),
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: C.muted,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Tx(
                                n.content,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TxTextField(
                            controller: _internalNoteController,
                            decoration: InputDecoration(
                              hintText: 'Add confidential case note...',
                              hintStyle: const TextStyle(fontSize: 13),
                              filled: true,
                              fillColor: Colors.white,
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        FilledButton(
                          onPressed: () => _addInternalNote(report),
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFFB45309),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                          ),
                          child: const Tx(
                            'Add Note',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Full Audit Trail & Event Timeline
              const SectionTitle('Audit Trail & Event History'),
              AppCard(
                child: Column(
                  children: report.auditLogs
                      .map((log) => _AuditTile(entry: log))
                      .toList(),
                ),
              ),

              const SizedBox(height: 12),
              // Delete Report Button (for testing/scrubbing)
              Center(
                child: TextButton.icon(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Tx('Delete Report Record?'),
                      content: TxParts([
                        'Permanently remove report',
                        report.code,
                        'from the institution board? This is for testing only.',
                      ], separator: ' '),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Tx('Cancel'),
                        ),
                        FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: C.danger,
                          ),
                          onPressed: () async {
                            await AppDatabase.instance.deleteReport(
                              report.code,
                            );
                            if (ctx.mounted) Navigator.pop(ctx);
                            if (context.mounted) {
                              Navigator.pop(context);
                              snack(context, 'Report deleted.');
                            }
                          },
                          child: const Tx('Delete'),
                        ),
                      ],
                    ),
                  ),
                  icon: const Icon(
                    Icons.delete_outline,
                    size: 16,
                    color: C.muted,
                  ),
                  label: const Tx(
                    'Scrub record from intake board',
                    style: TextStyle(color: C.muted, fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SecondaryButton(
                label: 'Back to Institution Board',
                icon: Icons.arrow_back,
                onPressed: () => context.canPop()
                    ? context.pop()
                    : context.go('/institution/dashboard'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _statusBadge(String status) {
    switch (status) {
      case 'received':
        return const Pill('Received', bg: Color(0xFFEDE6FB), fg: C.primary);
      case 'under_review':
        return const Pill('Under Review', bg: C.warnBg, fg: C.warn);
      case 'referred':
        return const Pill(
          'Referred to Partner',
          bg: Color(0xFFE0F2FE),
          fg: Color(0xFF0369A1),
        );
      case 'resolved':
        return const Pill('Resolved', bg: C.okBg, fg: C.ok);
      case 'closed':
        return const Pill(
          'Closed',
          bg: Color(0xFFF1F5F9),
          fg: Color(0xFF64748B),
        );
      default:
        return Pill(status);
    }
  }

  static Widget _priorityBadge(String priority) {
    switch (priority) {
      case 'urgent':
        return const Pill('URGENT PRIORITY', bg: C.dangerBg, fg: C.danger);
      case 'high':
        return const Pill(
          'HIGH PRIORITY',
          bg: Color(0xFFFFEBD8),
          fg: Color(0xFFC05621),
        );
      case 'medium':
        return const Pill('MEDIUM PRIORITY', bg: C.warnBg, fg: C.warn);
      case 'low':
        return const Pill(
          'LOW PRIORITY',
          bg: Color(0xFFF1F5F9),
          fg: Color(0xFF64748B),
        );
      default:
        return Pill(priority.toUpperCase());
    }
  }
}

class _EvidenceItem extends StatefulWidget {
  const _EvidenceItem({required this.attachment});
  final EvidenceAttachment attachment;

  @override
  State<_EvidenceItem> createState() => _EvidenceItemState();
}

class _EvidenceItemState extends State<_EvidenceItem> {
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    final a = widget.attachment;
    final isVoice = a.kind == 'voice';

    return AppCard(
      bottom: 8,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isVoice ? Colors.blue.withOpacity(0.12) : C.tint,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isVoice ? Icons.mic : Icons.insert_drive_file_outlined,
              color: isVoice ? Colors.blue : C.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Tx(
                  a.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Tx(
                  isVoice
                      ? 'Voice recording · ${a.seconds ?? 0}s duration'
                      : '${(a.size / 1024).round()} KB · ${a.ext.toUpperCase()} document',
                  style: const TextStyle(color: C.muted, fontSize: 11),
                ),
              ],
            ),
          ),
          if (isVoice)
            IconButton.filledTonal(
              onPressed: () {
                setState(() => _isPlaying = !_isPlaying);
                snack(
                  context,
                  _isPlaying ? 'Playing voice note evidence...' : 'Paused',
                );
              },
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
            )
          else
            IconButton(
              icon: const Icon(Icons.open_in_new, size: 20, color: C.muted),
              onPressed: () {
                snack(context, 'Decrypted attachment for officer review.');
              },
            ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});
  final CaseMessage message;

  @override
  Widget build(BuildContext context) {
    final isStaff = message.sender == 'staff';

    return Align(
      alignment: isStaff ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 420),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isStaff ? C.tint : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isStaff ? C.tintBorder : C.line),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Tx(
                  isStaff
                      ? (message.senderName ?? 'Support Officer')
                      : 'Reporter',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isStaff ? C.primary : C.muted,
                  ),
                ),
                const SizedBox(width: 8),
                Tx(
                  DateFormat('HH:mm, d MMM').format(message.createdAt),
                  style: const TextStyle(fontSize: 10, color: C.muted),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Tx(
              message.body,
              style: const TextStyle(fontSize: 13, height: 1.35),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuditTile extends StatelessWidget {
  const _AuditTile({required this.entry});
  final AuditLogEntry entry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: C.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Tx(
                      entry.action,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    Tx(
                      DateFormat('d MMM, HH:mm').format(entry.timestamp),
                      style: const TextStyle(fontSize: 11, color: C.muted),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                TxParts(
                  ['By', entry.actor, '—', entry.details],
                  separator: ' ',
                  style: const TextStyle(fontSize: 12, color: C.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
