import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import '../robot/login_robot.dart';
import '../../registro/robot/registro_robot.dart';

class AuthTask {
  final PatrolTester $;
  final _login    = LoginRobot();
  final _registro = RegistroRobot();

  AuthTask(this.$);

  // ── Login ──────────────────────────────────────────────────────

  Future<void> login(String email, String password) async {
    await $(_login.campoEmail).enterText(email);
    await $(_login.campoPassword).enterText(password);
    await $(_login.botonIniciarSesion).tap();
    await $.pumpAndSettle();
  }

  // ── Registro ───────────────────────────────────────────────────

  Future<void> irARegistro() async {
    await $(_login.botonNecesitasRegistrarte).tap();
    await $.pumpAndSettle();
  }

  Future<void> registrar(String email, String password) async {
    await $(_registro.campoEmail).enterText(email);
    await $(_registro.campoPassword).enterText(password);
    await $(_registro.botonRegistrarse).tap();
    await $.pumpAndSettle();
  }

  Future<void> confirmarRegistro() async {
    await $(_registro.botonOkConfirmacion).tap();
    await $.pumpAndSettle();
  }

  // ── Logout ─────────────────────────────────────────────────────

  Future<void> logout() async {
    final menuHamburguesa = find.byWidgetPredicate(
      (widget) => widget is Icon && widget.icon?.codePoint == 58332,
    );
    final logoutTile = find.byWidgetPredicate(
      (widget) =>
          widget is ListTile &&
          widget.title is Text &&
          (widget.title as Text).data == 'Logout',
    );
    await $(menuHamburguesa).tap();
    await $.pumpAndSettle();
    await $(logoutTile).tap();
    await $.pumpAndSettle();
  }
}
