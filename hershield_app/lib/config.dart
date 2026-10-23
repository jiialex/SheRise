/// A phone number someone can call in an emergency. Add ONLY numbers you have
/// verified with a local organisation. The app ships with none on purpose.
class EmergencyContact {
  const EmergencyContact(this.label, this.number);
  final String label;
  final String number;
}

class AppConfig {
  /// Supabase: Project Settings > API. Use the anon public key only,
  /// never the service_role key.
static const supabaseUrl =
    'https://qvdbufhwydlftoeffbva.supabase.co'; 
  
static const supabaseAnonKey = 
    'sb_publishable_P9XDJAeIWXiDZ6Ot9inw5A_scv8U44u';

  static bool get isConfigured =>
      !supabaseUrl.startsWith('YOUR_') && !supabaseAnonKey.startsWith('YOUR_');

  /// Example (verify before adding!):
  /// static const emergencyContacts = [EmergencyContact('Police', '991')];
  static const emergencyContacts = <EmergencyContact>[];
}
