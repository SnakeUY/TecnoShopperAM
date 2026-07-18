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
    await $(find.byIcon(Icons.shopping_cart_outlined)).waitUntilVisible();
  }

  Future<void> verificarLoginVisible() async {
    // Cerrar AlertDialog de error si está presente, sin esperar timeout completo
    await $.pumpAndSettle();
    if (find.text('OK').evaluate().isNotEmpty) {
      await $(find.text('OK')).tap();
      await $.pumpAndSettle();
    }
    await $(const ValueKey('login_button')).waitUntilVisible();
  }

  Future<void> verificarNavegoACatalogo({required bool esperado}) async {
    if (esperado) {
      expect(find.byIcon(Icons.shopping_cart_outlined), findsOneWidget);
    } else {
      expect(find.byKey(const ValueKey('login_button')), findsOneWidget);
    }
  }
}
