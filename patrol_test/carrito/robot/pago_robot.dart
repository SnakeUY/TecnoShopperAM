import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

class PagoRobot {
  final PatrolIntegrationTester $;

  PagoRobot(this.$);

  Finder _campo(String key) => find.descendant(
        of: find.byKey(ValueKey(key)),
        matching: find.byType(TextFormField),
      );

  Future<void> _escribirAcumulando(Finder campo, String texto) async {
    await $(campo).tap();
    await $.tester.pump(const Duration(milliseconds: 200));

    String acumulado = '';
    for (final char in texto.split('')) {
      acumulado += char;
      await $.tester.enterText(campo, acumulado);
      await $.tester.pump(const Duration(milliseconds: 100));
    }
    await $.pumpAndSettle();
  }

  Future<void> completarFormulario({
    required String numero,
    required String nombre,
    required String fecha,
    required String cvv,
  }) async {
    await $(_campo('ccNumero')).waitUntilVisible();
    await _escribirAcumulando(_campo('ccNumero'), numero);

    await $(_campo('ccNombre')).waitUntilVisible();
    await $(_campo('ccNombre')).enterText(nombre);
    await $.pumpAndSettle();

    await $(_campo('ccExpFecha')).waitUntilVisible();
    await _escribirAcumulando(_campo('ccExpFecha'), fecha);

    await $(_campo('ccCodigo')).waitUntilVisible();
    await _escribirAcumulando(_campo('ccCodigo'), cvv);

    // Cerrar teclado y hacer scroll hasta el botón Comprar
    await $.tester.testTextInput.receiveAction(TextInputAction.done);
    await $.tester.pump(const Duration(milliseconds: 300));
    await $.tester.drag(
      find.byType(SingleChildScrollView).first,
      const Offset(0, -300),
    );
    await $.tester.pump(const Duration(milliseconds: 300));
  }

  Future<void> presionarComprar() async {
    await $(find.text('Comprar')).waitUntilVisible();
    await $(find.text('Comprar')).tap();
    // La pantalla de éxito tiene animaciones continuas que bloquean pumpAndSettle.
    // Usamos pump con tiempo fijo para dejar que la transición ocurra.
    await $.tester.pump(const Duration(seconds: 3));
  }
}
