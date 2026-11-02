import 'dart:math';

import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../config.dart';
import 'app_database.dart';
import 'models.dart';

class InstitutionRegistration {
  const InstitutionRegistration({
    required this.institutionName,
    required this.status,
  });

  final String institutionName;
  final String status;
}

/// What happened after someone registered.
enum SignUpResult {
  /// Account created and a session started: go straight inside.
  signedIn,

  /// Account created, but Supabase wants the email confirmed first.
  needsConfirmation,

  /// That email already has an account.
  alreadyRegistered,
}

/// Talks to Supabase when keys are set; otherwise works in demo mode.
class Repo {
  static bool get live => AppConfig.isConfigured;
  static SupabaseClient get _db => Supabase.instance.client;

  // ---------- auth ----------
  static bool get signedIn => live && _db.auth.currentUser != null;

  static String? get email => live ? _db.auth.currentUser?.email : null;

  static String? get displayName {
    if (!live) return null;
    final meta = _db.auth.currentUser?.userMetadata;
    final value = meta == null ? null : meta['display_name'];
    return value is String ? value : null;
  }

  static String _clean(String email) => email.trim().toLowerCase();

  /// Turns Supabase auth errors into messages a person can act on.
  static String authError(AuthException e) {
    final m = e.message.toLowerCase();
    if (m.contains('rate limit')) {
      return 'Too many emails were sent. Please wait a while and try again.';
    }
    if (m.contains('email not confirmed')) {
      return 'Please confirm your email first. Check your inbox and spam folder.';
    }
    if (m.contains('invalid login credentials')) {
      return 'Email or password is incorrect. If you have not registered yet, create an account first.';
    }
    if (m.contains('already registered')) {
      return 'This email already has an account. Please sign in.';
    }
    return e.message;
  }

  static Future<void> signIn(String email, String password) async {
    if (!live) {
      throw StateError('Sign-in requires Supabase configuration.');
    }
    await _db.auth.signInWithPassword(email: _clean(email), password: password);
  }

  static SignUpResult _result(AuthResponse res) {
    if (res.session != null) return SignUpResult.signedIn;
    // Supabase hides existing accounts by returning a user with no identities.
    final ids = res.user?.identities;
    if (res.user != null && ids != null && ids.isEmpty) {
      return SignUpResult.alreadyRegistered;
    }
    return SignUpResult.needsConfirmation;
  }

  static Future<SignUpResult> signUp(
    String email,
    String password,
    String name,
  ) async {
    if (!live) {
      throw StateError('Account registration requires Supabase configuration.');
    }
    final Map<String, dynamic>? data = name.isEmpty
        ? null
        : <String, dynamic>{'display_name': name};
    final res = await _db.auth.signUp(
      email: _clean(email),
      password: password,
      data: data,
    );
    return _result(res);
  }

  static Future<SignUpResult> registerInstitution({
    required String institutionName,
    required String applicantName,
    required String applicantTitle,
    required String email,
    required String password,
  }) async {
    if (!live) {
      throw StateError(
        'Institution registration requires Supabase configuration.',
      );
    }
    final res = await _db.auth.signUp(
      email: _clean(email),
      password: password,
      data: {
        'account_type': 'institution',
        'display_name': applicantName,
        'institution_name': institutionName,
        'applicant_title': applicantTitle,
      },
    );
    return _result(res);
  }

  static Future<InstitutionRegistration?> institutionRegistration() async {
    if (!live) {
      throw StateError(
        'Institution registration requires Supabase configuration.',
      );
    }
    final user = _db.auth.currentUser;
    if (user == null) return null;
    final row = await _db
        .from('institution_registrations')
        .select('institution_name,status')
        .eq('user_id', user.id)
        .maybeSingle();
    if (row == null) return null;
    return InstitutionRegistration(
      institutionName: row['institution_name'] as String,
      status: row['status'] as String,
    );
  }

  static Future<void> recover(String email) async {
    if (!live) {
      throw StateError('Password recovery requires Supabase configuration.');
    }
    await _db.auth.resetPasswordForEmail(email);
  }

  static Future<void> signOut() async {
    if (!live) return;
    await _db.auth.signOut();
  }

  // ---------- reports ----------
  static String _category(String? label) {
    switch (label) {
      case 'Harassment':
        return 'harassment';
      case 'Bullying':
        return 'bullying';
      case 'Discrimination':
        return 'discrimination';
      case 'Unequal opportunity':
        return 'workplace_inequality';
      default:
        return 'other';
    }
  }

  /// Returns the private reference code. Saved locally in AppDatabase and
  /// sent to Supabase if configured.
  static Future<String> submitReport(ReportDraft d) async {
    // Save to robust local persistent database first (offline-first)
    final code = await AppDatabase.instance.submitReport(
      d,
      reporterName: displayName,
      reporterContact: email,
    );

    if (live) {
      try {
        final params = <String, dynamic>{
          'p_category': _category(d.category),
          'p_environment': 'other',
          'p_description': d.description.trim().isEmpty
              ? 'Voice report. Please see the attached voice note.'
              : d.description.trim(),
          'p_anonymous': d.anonymous,
        };
        if (d.date != null) {
          params['p_incident_date'] = DateFormat('yyyy-MM-dd').format(d.date!);
        }
        await _db.rpc('submit_report', params: params);
      } catch (e) {
        // Fall back gracefully to local database
      }
    }
    return code;
  }

  static String _randomId() {
    final r = Random.secure();
    return List.generate(
      16,
      (_) => r.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();
  }

  /// Uploads attachments to private storage under random names, then links
  /// them to the report using its private code. Returns how many failed.
  static Future<int> uploadEvidence(String code, List<Attachment> items) async {
    if (!live || items.isEmpty) return 0;
    var failed = 0;
    final folder = _randomId();
    for (final a in items) {
      try {
        final path = '$folder/${_randomId()}.${a.ext}';
        await _db.storage
            .from('evidence')
            .uploadBinary(
              path,
              a.bytes,
              fileOptions: FileOptions(contentType: a.mime),
            );
        await _db.rpc(
          'attach_evidence',
          params: {'p_code': code, 'p_path': path, 'p_mime': a.mime},
        );
      } catch (_) {
        failed++;
      }
    }
    return failed;
  }

  static Future<CaseStatus?> trackStatus(String code) async {
    // 1. Check local persistent database first
    final local = AppDatabase.instance.findByCode(code);
    if (local != null) {
      return CaseStatus(
        status: local.status,
        category: local.category,
        createdAt: local.createdAt,
        updatedAt: local.updatedAt,
      );
    }

    if (live) {
      try {
        final res = await _db.rpc(
          'get_report_status',
          params: {'p_code': code},
        );
        final list = res as List;
        if (list.isNotEmpty) {
          final r = list.first as Map<String, dynamic>;
          return CaseStatus(
            status: r['status'] as String,
            category: r['category'] as String,
            createdAt: DateTime.parse(r['created_at'] as String),
            updatedAt: DateTime.parse(r['updated_at'] as String),
          );
        }
      } catch (_) {}
    }
    return null;
  }

  static Future<List<CaseMessage>> messages(String code) async {
    // 1. Check local persistent database
    final local = AppDatabase.instance.findByCode(code);
    if (local != null && local.messages.isNotEmpty) {
      return local.messages;
    }

    if (live) {
      try {
        final res = await _db.rpc(
          'get_report_messages',
          params: {'p_code': code},
        );
        return (res as List).map((e) {
          final r = e as Map<String, dynamic>;
          return CaseMessage(
            sender: r['sender'] as String,
            body: r['body'] as String,
            createdAt: DateTime.parse(r['created_at'] as String),
          );
        }).toList();
      } catch (_) {}
    }
    return local?.messages ?? <CaseMessage>[];
  }

  static Future<void> sendMessage(String code, String body) async {
    // Save to local database
    await AppDatabase.instance.addReporterMessage(code, body);

    if (live) {
      try {
        await _db.rpc(
          'add_reporter_message',
          params: {'p_code': code, 'p_body': body},
        );
      } catch (_) {}
    }
  }

  // ---------- directories ----------
  static Future<List<ServiceListing>> services() async {
    if (!live) return sampleServices;
    final rows = await _db
        .from('support_providers')
        .select()
        .eq('verified', true);
    return (rows as List)
        .map((r) => ServiceListing.fromRow(r as Map<String, dynamic>))
        .toList();
  }

  static Future<List<Opportunity>> opportunities() async {
    if (!live) return sampleOpportunities;
    final rows = await _db.from('opportunities').select().eq('active', true);
    return (rows as List)
        .map((r) => Opportunity.fromRow(r as Map<String, dynamic>))
        .toList();
  }
}
