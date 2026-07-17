import 'package:patrol/patrol.dart';
import '../robot/perfil_robot.dart';
import '../data/perfil_data.dart';

class PerfilTask {
  final PatrolTester $;
  final _perfil = PerfilRobot();

  PerfilTask(this.$);

  Future<void> completarYGuardarPerfil() async {
    await $(_perfil.campoNombre).enterText(PerfilData.nombre);
    await $(_perfil.campoApellido).enterText(PerfilData.apellido);
    await $(_perfil.campoTelefono).enterText(PerfilData.telefono);
    await $(_perfil.campoFechaNacimiento).enterText(PerfilData.fechaNacimiento);
    await $(_perfil.campoDireccion).enterText(PerfilData.direccion);
    await $(_perfil.campoPais).enterText(PerfilData.pais);
    await $.pumpAndSettle();
    await $(_perfil.botonGuardar).tap();
    await $.pumpAndSettle();
  }

  Future<void> limpiarCamposYGuardar() async {
    await $(_perfil.campoNombre).enterText(PerfilData.vacio);
    await $(_perfil.campoApellido).enterText(PerfilData.vacio);
    await $(_perfil.campoTelefono).enterText(PerfilData.vacio);
    await $(_perfil.campoFechaNacimiento).enterText(PerfilData.vacio);
    await $(_perfil.campoDireccion).enterText(PerfilData.vacio);
    await $(_perfil.campoPais).enterText(PerfilData.vacio);
    await $.pumpAndSettle();
    await $(_perfil.botonGuardar).tap();
    await $.pumpAndSettle();
  }
}
