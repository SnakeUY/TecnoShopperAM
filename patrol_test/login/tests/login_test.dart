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
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final login    = LoginRobot($);
      final catalogo = CatalogoRobot($);

      await ensureUsuarioRegistrado($);

      final email    = await TestCredentials.leerEmail();
      final password = await TestCredentials.leerPassword();

      await login.ingresarEmail(email);
      await login.ingresarPassword(password);
      await login.presionarBotonLogin();

      await login.verificarInicioDeSesionExitoso();
      await catalogo.verificarCatalogoVisible();

      await catalogo.presionarLogout();
    },
  );

  patrolTest(
    'TC-05 - Iniciar sesión con datos inválidos (contraseña incorrecta)',
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final login = LoginRobot($);

      // Usamos el email del usuario registrado pero contraseña incorrecta
      await ensureUsuarioRegistrado($);
      final email = await TestCredentials.leerEmail();

      await login.ingresarEmail(email);
      await login.ingresarPassword('ClaveErronea999');
      await login.presionarBotonLogin();

      await login.verificarLoginVisible();
    },
  );

  patrolTest(
    'TC-06 - Iniciar sesión con datos inválidos (email no registrado)',
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final login = LoginRobot($);

      await login.ingresarEmail('noexiste@testces.com');
      await login.ingresarPassword(AuthData.password);
      await login.presionarBotonLogin();

      await login.verificarLoginVisible();
    },
  );
}
