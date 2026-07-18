import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

class PerfilRobot {
  final PatrolIntegrationTester $;

  PerfilRobot(this.$);

  Future<void> ingresarNombre(String valor) async {
    await $(find.byWidgetPredicate(
      (w) => w is TextField && w.decoration?.hintText == 'Nombre',
    )).enterText(valor);
  }

  Future<void> ingresarApellido(String valor) async {
    await $(find.byWidgetPredicate(
      (w) => w is TextField && w.decoration?.hintText == 'Apellido',
    )).enterText(valor);
  }

  Future<void> ingresarTelefono(String valor) async {
    await $(find.byWidgetPredicate(
      (w) => w is TextField && w.decoration?.hintText == 'Teléfono',
    )).enterText(valor);
  }

  Future<void> ingresarFechaNacimiento(String valor) async {
    await $(find.byWidgetPredicate(
      (w) => w is TextField && w.decoration?.hintText == 'Fecha de Nacimiento',
    )).enterText(valor);
  }

  Future<void> ingresarDireccion(String valor) async {
    await $(find.byWidgetPredicate(
      (w) => w is TextField && w.decoration?.hintText == 'Dirección',
    )).enterText(valor);
  }

  Future<void> ingresarPais(String valor) async {
    await $(find.byWidgetPredicate(
      (w) => w is TextField && w.decoration?.hintText == 'País',
    )).enterText(valor);
  }

  Future<void> presionarGuardar() async {
    await $(find.text('Guardar')).tap();
    await $.pumpAndSettle();
  }

  Future<void> volverAtras() async {
    await $(find.byIcon(Icons.arrow_back)).tap();
    await $.pumpAndSettle();
  }

  // ── Verificaciones ────────────────────────────────────────────

  Future<void> verificarPantallaPerfilVisible() async {
    await $(find.text('Datos de Cuenta')).waitUntilVisible();
  }

  Future<void> verificarGuardadoExitoso() async {
    await $(find.text('Perfil actualizado correctamente')).waitUntilVisible();
  }

  Future<void> verificarAppNoCrasheo() async {
    // La app sigue activa y el botón Guardar sigue visible
    await $(find.text('Guardar')).waitUntilVisible();
  }

  Future<void> verificarDatoPersistido(String valor) async {
    // El valor ingresado debe seguir visible en la pantalla de perfil
    expect(find.text(valor), findsOneWidget);
  }
}
