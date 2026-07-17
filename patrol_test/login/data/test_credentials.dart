import 'package:shared_preferences/shared_preferences.dart';

class TestCredentials {
  static const _keyEmail    = 'test_user_email';
  static const _keyPassword = 'test_user_password';
  static const _passwordFijo = 'Test@2026!';

  static Future<void> guardar(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyPassword, password);
  }

  static Future<String> leerEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail) ?? '';
  }

  static Future<String> leerPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPassword) ?? _passwordFijo;
  }

  /// Retorna true si ya hay un usuario registrado guardado
  static Future<bool> tieneCredenciales() async {
    final email = await leerEmail();
    return email.isNotEmpty;
  }

  static String generarEmailNuevo() {
    final ts = DateTime.now().millisecondsSinceEpoch;
    return 'user_$ts@testces.com';
  }
}
