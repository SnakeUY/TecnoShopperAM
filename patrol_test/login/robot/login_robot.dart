import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

class LoginRobot {
  final PatrolIntegrationTester $;

  LoginRobot(this.$);

  Future<void> ingresarEmail(String email) async {
    await $(const ValueKey('email_field')).enterText(email);
  }

  Future<void> ingresarPassword(String password) async {
    await $(const ValueKey('password_field')).enterText(password);
  }

  Future<void> presionarBotonLogin() async {
    await $(const ValueKey('login_button')).tap();
    await $.pumpAndSettle();
  }

  Future<void> presionarRegistrarte() async {
    await $(find.text('¿Necesitás registrarte?')).tap();
    await $.pumpAndSettle();
  }

  Future<void> verificarInicioDeSesionExitoso() async {
    // Después del login exitoso va a SplashPage y luego a ProductosPage
    // Verificamos que el ícono del carrito del bottom nav sea visible
    await $(find.byIcon(Icons.shopping_cart_outlined)).waitUntilVisible();
  }

  Future<void> verificarLoginVisible() async {
    // En TC-05/06: login falla y muestra AlertDialog.
    // Hay que cerrar el diálogo primero para que el botón sea hit-testable.
    // Esperamos que el diálogo aparezca y lo cerramos.
    try {
      await $(find.text('OK')).waitUntilVisible();
      await $(find.text('OK')).tap();
      await $.pumpAndSettle();
    } catch (_) {
      // Si no hay diálogo, continuamos
    }
    await $(const ValueKey('login_button')).waitUntilVisible();
  }

  Future<void> verificarMensajeDeError(String mensaje) async {
    await $(find.text(mensaje)).waitUntilVisible();
  }
}
