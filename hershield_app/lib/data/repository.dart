import 'dart:math';

import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../config.dart';
import 'models.dart';

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

  static Future<void> signIn(String email, String password) async {
    await _db.auth.signInWithPassword(email: email, password: password);
  }

  static Future<void> signUp(String email, String password, String name) async {
    await _db.auth.signUp(
      email: email,
      password: password,
      data: name.isEmpty ? null : {'display_name': name},
    );
  }

  static Future<void> recover(String email) async {
    await _db.auth.resetPasswordForEmail(email);
  }

  static Future<void> signOut() async {
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

  static String _demoCode() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final r = Random.secure();
    String part() =>
        List.generate(4, (_) => chars[r.nextInt(chars.length)]).join();
    return 'DEMO-${part()}-${part()}';
  }

  /// Returns the private reference code. It is shown once and the server
  /// keeps only a hash of it.
  static Future<String> submitReport(ReportDraft d) async {
    if (!live) return _demoCode();
    final params = <String, dynamic>{
      'p_category': _category(d.category),
      'p_environment': 'other',
      'p_description': d.description.trim(),
      'p_anonymous': d.anonymous,
    };
    if (d.date != null) {
      params['p_incident_date'] = DateFormat('yyyy-MM-dd').format(d.date!);
    }
    final res = await _db.rpc('submit_report', params: params);
    return res as String;
  }

  static Future<CaseStatus?> trackStatus(String code) async {
    final res = await _db.rpc('get_report_status', params: {'p_code': code});
    final list = res as List;
    if (list.isEmpty) return null;
    final r = list.first as Map<String, dynamic>;
    return CaseStatus(
      status: r['status'] as String,
      category: r['category'] as String,
      createdAt: DateTime.parse(r['created_at'] as String),
      updatedAt: DateTime.parse(r['updated_at'] as String),
    );
  }

  static Future<List<CaseMessage>> messages(String code) async {
    final res = await _db.rpc('get_report_messages', params: {'p_code': code});
    return (res as List).map((e) {
      final r = e as Map<String, dynamic>;
      return CaseMessage(
        sender: r['sender'] as String,
        body: r['body'] as String,
        createdAt: DateTime.parse(r['created_at'] as String),
      );
    }).toList();
  }

  static Future<void> sendMessage(String code, String body) async {
    await _db.rpc('add_reporter_message',
        params: {'p_code': code, 'p_body': body});
  }

  // ---------- directories ----------
  static Future<List<ServiceListing>> services() async {
    if (!live) return sampleServices;
    final rows =
        await _db.from('support_providers').select().eq('verified', true);
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
