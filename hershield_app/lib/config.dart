/// A phone number someone can call in an emergency. Add ONLY numbers you have
/// verified with a local organisation. The app ships with none on purpose.
class EmergencyContact {
  const EmergencyContact(this.label, this.number, {this.note = ''});
  final String label;
  final String number;
  final String note;
}

class AppConfig {
  /// Supabase: Project Settings > API. Use the publishable (anon) key only,
  /// never the service_role / secret key. Override at build time with
  /// --dart-define=NEXT_PUBLIC_SUPABASE_URL=... if needed.
  static const supabaseUrl = String.fromEnvironment(
    'NEXT_PUBLIC_SUPABASE_URL',
    defaultValue: 'https://qvdbufhwydlftoeffbva.supabase.co',
  );
  static const supabaseAnonKey = String.fromEnvironment(
    'NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY',
    defaultValue: 'sb_publishable_P9XDJAeIWXiDZ6Ot9inw5A_scv8U44u',
  );

  static bool get isConfigured =>
      !supabaseUrl.startsWith('YOUR_') && !supabaseAnonKey.startsWith('YOUR_');

  /// Ethiopia emergency numbers, taken from public sources (government travel
  /// advice, UNFPA and listings). Numbers can change and a few older sources
  /// disagree, so CONFIRM each one with a local organization before launch.
  static const emergencyNumbersCheckedOn = '25 Oct 2026';
  static const emergencyContacts = <EmergencyContact>[
    EmergencyContact('Police', '991', note: 'Free to call'),
    EmergencyContact('Ambulance', '907', note: 'Red Cross ambulance'),
    EmergencyContact('Fire', '939'),
    EmergencyContact('Women & GBV hotline', '7711',
        note: 'EWLA · free · Amharic, Afaan Oromo, Tigrinya'),
  ];
}
