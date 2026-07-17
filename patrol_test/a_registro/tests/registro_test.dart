import 'package:flutter_ces/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import '../robot/registro_robot.dart';
import '../../login/robot/login_robot.dart';
import '../../login/data/auth_data.dart';
import '../../login/data/test_credentials.dart';
import '../../carrito/robot/catalogo_robot.dart';

void main() {
  // TC-01: Registrarse con datos válidos
  patrolTest(
    'TC-01 - Registrarse con datos válidos',
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final login    = LoginRobot($);
      final registro = RegistroRobot($);
      final catalogo = CatalogoRobot($);

      // Navegar a registro
      await login.presionarRegistrarte();
      await registro.verificarPantallaRegistroVisible();

      // Generar credenciales únicas para esta sesión
      final email    = AuthData.emailRegistroUnico();
      final password = AuthData.password;

      await registro.ingresarEmail(email);
      await registro.ingresarPassword(password);
      await registro.presionarRegistrarse();

      // Verificar diálogo de éxito y confirmar
      // El OK navega directamente al LoginPage
      await registro.verificarRegistroExitoso();
      await registro.confirmarRegistroExitoso();

      // Guardar credenciales para los tests posteriores
      await TestCredentials.guardar(email, password);

      // Ahora estamos en LoginPage — verificar login con la cuenta creada
      await login.ingresarEmail(email);
      await login.ingresarPassword(password);
      await login.presionarBotonLogin();
      await login.verificarInicioDeSesionExitoso();

      await catalogo.presionarLogout();
    },
  );

  // TC-02: Registrarse con contraseña vacía
  patrolTest(
    'TC-02 - Registrarse con datos inválidos (contraseña vacía)',
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final login    = LoginRobot($);
      final registro = RegistroRobot($);

      await login.presionarRegistrarte();
      await registro.verificarPantallaRegistroVisible();

      await registro.ingresarEmail(AuthData.emailRegistroUnico());
      await registro.ingresarPassword(AuthData.passwordVacio);
      await registro.presionarRegistrarse();

      await registro.verificarRegistroFallido();
    },
  );

  // TC-03: Registrarse con email sin formato válido
  patrolTest(
    'TC-03 - Registrarse con datos inválidos (email sin formato)',
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final login    = LoginRobot($);
      final registro = RegistroRobot($);

      await login.presionarRegistrarte();
      await registro.verificarPantallaRegistroVisible();

      await registro.ingresarEmail(AuthData.emailInvalidoSinArroba);
      await registro.ingresarPassword(AuthData.password);
      await registro.presionarRegistrarse();

      await registro.verificarRegistroFallido();
    },
  );
}
