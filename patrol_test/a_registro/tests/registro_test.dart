import 'package:flutter_ces/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import '../robot/registro_robot.dart';
import '../../login/robot/login_robot.dart';
import '../../login/data/auth_data.dart';
import '../../login/data/test_credentials.dart';
import '../../carrito/robot/catalogo_robot.dart';

void main() {
  patrolTest(
    'TC-01 - Registrarse con datos válidos',
    tags: ['smoke', 'registro'],
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final login    = LoginRobot($);
      final registro = RegistroRobot($);
      final catalogo = CatalogoRobot($);

      // ── Precondición ──────────────────────────────────────────
      // Verificar que la pantalla de login está activa
      await login.verificarLoginVisible();

      // ── Pasos ─────────────────────────────────────────────────
      await login.presionarRegistrarte();

      // Verificación: pantalla de registro visible
      await registro.verificarPantallaRegistroVisible();

      final email    = AuthData.emailRegistroUnico();
      final password = AuthData.password;

      await registro.ingresarEmail(email);
      await registro.ingresarPassword(password);
      await registro.presionarRegistrarse();

      // Verificación: diálogo de registro exitoso visible
      await registro.verificarRegistroExitoso();
      await registro.confirmarRegistroExitoso();

      // Guardar credenciales para tests posteriores
      await TestCredentials.guardar(email, password);

      // Verificación: puede iniciar sesión con la cuenta recién creada
      await login.ingresarEmail(email);
      await login.ingresarPassword(password);
      await login.presionarBotonLogin();
      await login.verificarInicioDeSesionExitoso();

      // Verificación: catálogo visible — usuario autenticado correctamente
      await catalogo.verificarCatalogoVisible();

      await catalogo.presionarLogout();

      // Verificación final: volvió a la pantalla de login
      await login.verificarLoginVisible();
    },
  );

  patrolTest(
    'TC-02 - Registrarse con datos inválidos (contraseña vacía)',
    tags: ['regression', 'registro'],
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final login    = LoginRobot($);
      final registro = RegistroRobot($);

      await login.verificarLoginVisible();
      await login.presionarRegistrarte();
      await registro.verificarPantallaRegistroVisible();

      await registro.ingresarEmail(AuthData.emailRegistroUnico());
      await registro.ingresarPassword(AuthData.passwordVacio);
      await registro.presionarRegistrarse();

      // Verificación: el registro NO fue exitoso
      await registro.verificarRegistroFallido();

      // Verificación: sigue en pantalla de registro (no navegó)
      await registro.verificarPantallaRegistroVisible();
    },
  );

  patrolTest(
    'TC-03 - Registrarse con datos inválidos (email sin formato)',
    tags: ['regression', 'registro'],
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final login    = LoginRobot($);
      final registro = RegistroRobot($);

      await login.verificarLoginVisible();
      await login.presionarRegistrarte();
      await registro.verificarPantallaRegistroVisible();

      await registro.ingresarEmail(AuthData.emailInvalidoSinArroba);
      await registro.ingresarPassword(AuthData.password);
      await registro.presionarRegistrarse();

      // Verificación: el registro NO fue exitoso
      await registro.verificarRegistroFallido();

      // Verificación: sigue en pantalla de registro (no navegó)
      await registro.verificarPantallaRegistroVisible();
    },
  );
}
