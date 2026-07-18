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
    tags: ['smoke', 'perfil'],
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final login    = LoginRobot($);
      final catalogo = CatalogoRobot($);
      final perfil   = PerfilRobot($);

      // ── Precondición ──────────────────────────────────────────
      await login.verificarLoginVisible();
      await ensureUsuarioRegistrado($);

      final email    = await TestCredentials.leerEmail();
      final password = await TestCredentials.leerPassword();

      await login.ingresarEmail(email);
      await login.ingresarPassword(password);
      await login.presionarBotonLogin();
      await login.verificarInicioDeSesionExitoso();

      // ── Perfil ────────────────────────────────────────────────
      await catalogo.irAlPerfil();

      // Verificación: pantalla de perfil visible
      await perfil.verificarPantallaPerfilVisible();

      await perfil.ingresarNombre(PerfilData.nombre);
      await perfil.ingresarApellido(PerfilData.apellido);
      await perfil.ingresarTelefono(PerfilData.telefono);
      await perfil.ingresarFechaNacimiento(PerfilData.fechaNacimiento);
      await perfil.ingresarDireccion(PerfilData.direccion);
      await perfil.ingresarPais(PerfilData.pais);
      await perfil.presionarGuardar();

      // Verificación: toast de confirmación visible
      await perfil.verificarGuardadoExitoso();

      // Verificación: datos persisten al volver y re-abrir perfil
      await perfil.volverAtras();
      await catalogo.irAlPerfil();
      await perfil.verificarPantallaPerfilVisible();
      await perfil.verificarDatoPersistido(PerfilData.nombre);

      await catalogo.presionarLogout();
      await login.verificarLoginVisible();
    },
  );

  patrolTest(
    'TC-10 - Configurar información personal con campos vacíos',
    tags: ['regression', 'perfil'],
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final login    = LoginRobot($);
      final catalogo = CatalogoRobot($);
      final perfil   = PerfilRobot($);

      // ── Precondición ──────────────────────────────────────────
      await login.verificarLoginVisible();
      await ensureUsuarioRegistrado($);

      final email    = await TestCredentials.leerEmail();
      final password = await TestCredentials.leerPassword();

      await login.ingresarEmail(email);
      await login.ingresarPassword(password);
      await login.presionarBotonLogin();
      await login.verificarInicioDeSesionExitoso();

      await catalogo.irAlPerfil();
      await perfil.verificarPantallaPerfilVisible();

      // Limpiar todos los campos
      await perfil.ingresarNombre(PerfilData.vacio);
      await perfil.ingresarApellido(PerfilData.vacio);
      await perfil.ingresarTelefono(PerfilData.vacio);
      await perfil.ingresarFechaNacimiento(PerfilData.vacio);
      await perfil.ingresarDireccion(PerfilData.vacio);
      await perfil.ingresarPais(PerfilData.vacio);
      await perfil.presionarGuardar();

      // Verificación: la app no crasheó
      await perfil.verificarAppNoCrasheo();

      // Verificación: sigue en la pantalla de perfil
      await perfil.verificarPantallaPerfilVisible();
    },
  );
}
