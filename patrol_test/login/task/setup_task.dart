import 'package:patrol/patrol.dart';
import '../data/test_credentials.dart';
import '../robot/login_robot.dart';
import '../../a_registro/robot/registro_robot.dart';

/// Garantiza que existe un usuario registrado con credenciales guardadas.
/// Si ya hay credenciales en shared_preferences no hace nada.
/// Si no las hay, navega a registro, crea un usuario nuevo y guarda las credenciales.
/// Llamar al inicio de cualquier test que requiera estar logueado.
Future<void> ensureUsuarioRegistrado(PatrolIntegrationTester $) async {
  if (await TestCredentials.tieneCredenciales()) return;

  final login    = LoginRobot($);
  final registro = RegistroRobot($);

  final email    = TestCredentials.generarEmailNuevo();
  final password = 'Test@2026!';

  await login.presionarRegistrarte();
  await registro.verificarPantallaRegistroVisible();
  await registro.ingresarEmail(email);
  await registro.ingresarPassword(password);
  await registro.presionarRegistrarse();
  await registro.verificarRegistroExitoso();
  await registro.confirmarRegistroExitoso();

  await TestCredentials.guardar(email, password);
}
