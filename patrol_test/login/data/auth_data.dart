class AuthData {
  // Contraseña fija usada en todos los tests
  static const String password = 'Test@2026!';

  // Email inválido para TC-02/03
  static const String emailInvalidoSinArroba = 'usuariosindominio';
  static const String passwordVacio          = '';

  // Genera un email único para el registro (TC-01)
  static String emailRegistroUnico() {
    final ts = DateTime.now().millisecondsSinceEpoch;
    return 'user_$ts@testces.com';
  }
}
