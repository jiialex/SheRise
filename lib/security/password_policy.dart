/// Password rules used when creating accounts (end users and institutions).
/// Sign-in never applies these, so older accounts can still get in.
class PasswordCheck {
  const PasswordCheck({
    required this.longEnough,
    required this.hasLower,
    required this.hasUpper,
    required this.hasDigit,
    required this.hasSymbol,
    required this.notCommon,
    required this.notPersonal,
  });

  final bool longEnough, hasLower, hasUpper, hasDigit, hasSymbol;
  final bool notCommon, notPersonal;

  bool get ok =>
      longEnough &&
      hasLower &&
      hasUpper &&
      hasDigit &&
      hasSymbol &&
      notCommon &&
      notPersonal;

  /// 0 (empty) to 4 (strong).
  int get score {
    var s = 0;
    if (longEnough) s++;
    if (hasLower && hasUpper) s++;
    if (hasDigit && hasSymbol) s++;
    if (notCommon && notPersonal) s++;
    return s;
  }
}

class PasswordPolicy {
  static const minLength = 12;

  static const _common = [
    'password', 'passw0rd', 'qwerty', 'letmein', 'welcome', 'admin',
    'iloveyou', '123456', '111111', '000000', 'abc123', 'monkey',
    'dragon', 'sherise', 'ethiopia', 'addis',
  ];

  /// [personal] = email, name, institution etc. A password must not contain them.
  static PasswordCheck check(String p, {List<String> personal = const []}) {
    final lower = p.toLowerCase();
    final flat = lower.replaceAll(RegExp(r'[^a-z0-9]'), '');

    var common = _common.any(flat.contains);
    if (RegExp(r'^(.)\1+$').hasMatch(p)) common = true; // aaaaaaaa
    if (_sequential(flat)) common = true;

    var personalHit = false;
    for (final raw in personal) {
      final parts = raw.toLowerCase().split(RegExp(r'[^a-z0-9]+'));
      for (final part in parts) {
        if (part.length >= 4 && flat.contains(part)) personalHit = true;
      }
    }

    return PasswordCheck(
      longEnough: p.length >= minLength,
      hasLower: RegExp(r'[a-z]').hasMatch(p),
      hasUpper: RegExp(r'[A-Z]').hasMatch(p),
      hasDigit: RegExp(r'\d').hasMatch(p),
      hasSymbol: RegExp(r'[^A-Za-z0-9]').hasMatch(p),
      notCommon: p.isEmpty ? false : !common,
      notPersonal: p.isEmpty ? false : !personalHit,
    );
  }

  /// True for runs like 12345678 or abcdefgh.
  static bool _sequential(String s) {
    if (s.length < 6) return false;
    var run = 1;
    for (var i = 1; i < s.length; i++) {
      final d = s.codeUnitAt(i) - s.codeUnitAt(i - 1);
      run = d == 1 ? run + 1 : 1;
      if (run >= 6) return true;
    }
    return false;
  }

  /// Message for the first rule that failed, or null when the password is fine.
  static String? firstProblem(PasswordCheck c) {
    if (!c.longEnough) return 'Use a password of at least 12 characters.';
    if (!c.hasLower || !c.hasUpper) {
      return 'Mix upper and lower case letters in your password.';
    }
    if (!c.hasDigit) return 'Add at least one number to your password.';
    if (!c.hasSymbol) return 'Add at least one symbol, like ! or #.';
    if (!c.notCommon) return 'That password is too easy to guess. Choose another.';
    if (!c.notPersonal) {
      return 'Do not use your name, email or institution in the password.';
    }
    return null;
  }
}
