import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

class CarritoRobot {
  final PatrolIntegrationTester $;

  CarritoRobot(this.$);

  Future<void> eliminarPrimerProducto() async {
    await $(find.byIcon(Icons.delete)).first.tap();
    await $.pumpAndSettle();
  }

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
    await $(find.byType(BackButton)).tap();
    await $.pumpAndSettle();
  }

  // ── Verificaciones ────────────────────────────────────────────

  Future<void> verificarCarritoVacio() async {
    await $(find.text('Total: \$0.0')).waitUntilVisible();
  }

  Future<void> verificarBotonFinalizarVisible() async {
    await $(find.text('Finalizar Compra')).waitUntilVisible();
  }

  Future<void> verificarFinalizarDeshabilitado() async {
    // Con carrito vacío el botón existe pero no es hit-testable
    expect(
      $(find.text('Finalizar Compra')).hitTestable(),
      findsNothing,
    );
  }

  Future<void> verificarTotalMayorACero() async {
    // Verifica que el total no sea $0.0 (hay productos en el carrito)
    expect(find.text('Total: \$0.0'), findsNothing);
  }
}
