import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

class RegistroRobot {
  final PatrolIntegrationTester $;

  RegistroRobot(this.$);

  // Los campos de registro son TextField sin key.
  // Se identifican por su hintText.
  Future<void> ingresarEmail(String email) async {
    await $(find.byWidgetPredicate(
      (w) => w is TextField && w.decoration?.hintText == 'Email',
    )).enterText(email);
  }

  Future<void> ingresarPassword(String password) async {
    await $(find.byWidgetPredicate(
      (w) => w is TextField && w.decoration?.hintText == 'Contraseña',
    )).enterText(password);
  }

  Future<void> presionarRegistrarse() async {
    // Hay dos widgets con texto "Registrarse" (el título y el botón).
    // El botón es un ElevatedButton.
    await $(find.byWidgetPredicate(
      (w) => w is ElevatedButton,
    )).tap();
    await $.pumpAndSettle();
  }

  Future<void> confirmarRegistroExitoso() async {
    // El OK navega directamente al LoginPage
    await $(find.text('OK')).tap();
    await $.pumpAndSettle();
  }

  Future<void> verificarPantallaRegistroVisible() async {
    await $(find.text('Crea tu cuenta')).waitUntilVisible();
  }

  Future<void> verificarRegistroExitoso() async {
    await $(find.text('Registro exitoso')).waitUntilVisible();
  }

  Future<void> verificarRegistroFallido() async {
    // Si hay error muestra un diálogo o snackbar, el título de registro sigue visible
    expect(find.text('Registro exitoso'), findsNothing);
    await $(find.text('Crea tu cuenta')).waitUntilVisible();
  }
}
