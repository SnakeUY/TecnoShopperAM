import 'package:flutter_ces/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import '../robot/login_robot.dart';
import '../data/auth_data.dart';
import '../data/test_credentials.dart';
import '../task/setup_task.dart';
import '../../carrito/robot/catalogo_robot.dart';

void main() {
  patrolTest(
    'TC-04 - Iniciar sesión con datos válidos',
    tags: ['smoke', 'login'],
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final login    = LoginRobot($);
      final catalogo = CatalogoRobot($);

      // ── Precondición ──────────────────────────────────────────
      await login.verificarLoginVisible();
      await ensureUsuarioRegistrado($);

      final email    = await TestCredentials.leerEmail();
      final password = await TestCredentials.leerPassword();

      // ── Pasos ─────────────────────────────────────────────────
      await login.ingresarEmail(email);
      await login.ingresarPassword(password);
      await login.presionarBotonLogin();

      // Verificación: login exitoso — botón de login no visible
      await login.verificarInicioDeSesionExitoso();

      // Verificación: catálogo visible
      await catalogo.verificarCatalogoVisible();

      await catalogo.presionarLogout();

      // Verificación final: volvió a la pantalla de login
      await login.verificarLoginVisible();
    },
  );

  patrolTest(
    'TC-05 - Iniciar sesión con datos inválidos (contraseña incorrecta)',
    tags: ['regression', 'login'],
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final login = LoginRobot($);

      await login.verificarLoginVisible();
      await ensureUsuarioRegistrado($);

      final email = await TestCredentials.leerEmail();

      await login.ingresarEmail(email);
      await login.ingresarPassword('ClaveErronea999');
      await login.presionarBotonLogin();

      // Verificación: login fallido — botón de login sigue visible
      await login.verificarLoginVisible();

      // Verificación: NO llegó al catálogo
      await login.verificarNavegoACatalogo(esperado: false);
    },
  );

  patrolTest(
    'TC-06 - Iniciar sesión con datos inválidos (email no registrado)',
    tags: ['regression', 'login'],
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final login = LoginRobot($);

      await login.verificarLoginVisible();

      await login.ingresarEmail('noexiste@testces.com');
      await login.ingresarPassword(AuthData.password);
      await login.presionarBotonLogin();

      // Verificación: login fallido — botón de login sigue visible
      await login.verificarLoginVisible();

      // Verificación: NO llegó al catálogo
      await login.verificarNavegoACatalogo(esperado: false);
    },
  );
}
