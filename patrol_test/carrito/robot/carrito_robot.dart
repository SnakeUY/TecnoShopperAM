import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

class CarritoRobot {
  final PatrolIntegrationTester $;

  CarritoRobot(this.$);

  // carrito_page.dart usa Icons.delete para eliminar
  Future<void> eliminarPrimerProducto() async {
    await $(find.byIcon(Icons.delete)).first.tap();
    await $.pumpAndSettle();
  }

  // Icons.add y Icons.remove para cantidad
  Future<void> aumentarCantidadPrimerProducto() async {
    await $(find.byIcon(Icons.add)).first.tap();
    await $.pumpAndSettle();
  }

  Future<void> bajarCantidadPrimerProducto() async {
    await $(find.byIcon(Icons.remove)).first.tap();
    await $.pumpAndSettle();
  }

  Future<void> presionarFinalizarCompra() async {
    await $(find.text('Finalizar Compra')).waitUntilVisible();
    await $(find.text('Finalizar Compra')).tap();
    await $.pumpAndSettle();
  }

  Future<void> volverAlCatalogo() async {
    // AppBar del carrito tiene botón de volver automático (Navigator.pop)
    await $(find.byType(BackButton)).tap();
    await $.pumpAndSettle();
  }

  Future<void> verificarCarritoVacio() async {
    await $(find.text('Total: \$0.0')).waitUntilVisible();
  }

  Future<void> verificarBotonFinalizarVisible() async {
    await $(find.text('Finalizar Compra')).waitUntilVisible();
  }
}
