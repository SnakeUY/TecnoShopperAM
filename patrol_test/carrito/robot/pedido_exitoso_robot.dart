import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

class PedidoExitosoRobot {
  final PatrolIntegrationTester $;

  PedidoExitosoRobot(this.$);

  Future<void> verificarPedidoExitoso() async {
    // Usamos pump en lugar de pumpAndSettle porque la pantalla de éxito
    // puede tener animaciones continuas que impiden que settle termine.
    await $.tester.pump(const Duration(seconds: 2));
    expect(
      find.text('¡Tu pedido ha sido procesado con éxito!'),
      findsOneWidget,
    );
  }
}
