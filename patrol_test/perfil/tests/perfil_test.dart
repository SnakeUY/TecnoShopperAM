import 'package:flutter_ces/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import '../../login/robot/login_robot.dart';
import '../../login/data/test_credentials.dart';
import '../../login/task/setup_task.dart';
import '../../carrito/robot/catalogo_robot.dart';
import '../robot/perfil_robot.dart';
import '../data/perfil_data.dart';

void main() {
  patrolTest(
    'TC-09 - Configurar y guardar información personal',
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final login    = LoginRobot($);
      final catalogo = CatalogoRobot($);
      final perfil   = PerfilRobot($);

      await ensureUsuarioRegistrado($);

      final email    = await TestCredentials.leerEmail();
      final password = await TestCredentials.leerPassword();

      await login.ingresarEmail(email);
      await login.ingresarPassword(password);
      await login.presionarBotonLogin();
      await login.verificarInicioDeSesionExitoso();

      await catalogo.irAlPerfil();
      await perfil.verificarPantallaPerfilVisible();

      await perfil.ingresarNombre(PerfilData.nombre);
      await perfil.ingresarApellido(PerfilData.apellido);
      await perfil.ingresarTelefono(PerfilData.telefono);
      await perfil.ingresarFechaNacimiento(PerfilData.fechaNacimiento);
      await perfil.ingresarDireccion(PerfilData.direccion);
      await perfil.ingresarPais(PerfilData.pais);
      await perfil.presionarGuardar();

      await perfil.verificarGuardadoExitoso();

      await perfil.volverAtras();
      await catalogo.irAlPerfil();
      await perfil.verificarPantallaPerfilVisible();

      await catalogo.presionarLogout();
    },
  );

  patrolTest(
    'TC-10 - Configurar información personal con campos vacíos',
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final login    = LoginRobot($);
      final catalogo = CatalogoRobot($);
      final perfil   = PerfilRobot($);

      await ensureUsuarioRegistrado($);

      final email    = await TestCredentials.leerEmail();
      final password = await TestCredentials.leerPassword();

      await login.ingresarEmail(email);
      await login.ingresarPassword(password);
      await login.presionarBotonLogin();
      await login.verificarInicioDeSesionExitoso();

      await catalogo.irAlPerfil();
      await perfil.verificarPantallaPerfilVisible();

      await perfil.ingresarNombre(PerfilData.vacio);
      await perfil.ingresarApellido(PerfilData.vacio);
      await perfil.ingresarTelefono(PerfilData.vacio);
      await perfil.ingresarFechaNacimiento(PerfilData.vacio);
      await perfil.ingresarDireccion(PerfilData.vacio);
      await perfil.ingresarPais(PerfilData.vacio);
      await perfil.presionarGuardar();

      await perfil.verificarAppNoCrasheo();
    },
  );
}
