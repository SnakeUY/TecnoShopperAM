import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

class DetalleProductoRobot {
  final PatrolIntegrationTester $;

  DetalleProductoRobot(this.$);

  Future<void> presionarAgregar() async {
    await $(find.text('Agregar')).tap();
    // Esperar que el SnackBar (Duration(seconds:1)) desaparezca
    // y que el AppBar sea completamente hit-testable
    await Future.delayed(const Duration(seconds: 3));
    await $.pumpAndSettle();
  }

  Future<void> presionarComprar() async {
    await $(find.text('Comprar')).tap();
    await $.pumpAndSettle();
  }

  Future<void> volverAlCatalogo() async {
    // El AppBar de compra_page.dart tiene un único IconButton como leading.
    // Buscamos el IconButton dentro del AppBar en lugar del ícono específico
    // para evitar depender del codePoint que varía entre versiones.
    await $(find.descendant(
      of: find.byType(AppBar),
      matching: find.byType(IconButton),
    )).tap();
    await $.pumpAndSettle();
  }
}
